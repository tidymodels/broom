#' Tidiers for biglm and bigglm object
#' 
#' Tidiers for biglm object from the "biglm" package, which contains a linear model
#' object that is limited in memory usage. Generally the behavior is as similar
#' to the \code{\link{lm_tidiers}} as is possible. Currently no \code{augment}
#' is defined.
#' 
#' @param x a "biglm" object
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level of the interval, used only if
#' \code{conf.int=TRUE}
#' @param exponentiate whether to exponentiate the coefficient estimates
#' and confidence intervals (typical for logistic regression)
#' @param ... extra arguments (not used)
#' 
#' @template boilerplate
#' 
#' @return \code{tidy.biglm} returns one row for each coefficient, with columns
#'   \item{term}{The term in the linear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error from the linear model}
#'   \item{p.value}{two-sided p-value}
#' 
#' If \code{conf.int=TRUE}, it also includes columns for \code{conf.low} and
#' \code{conf.high}, computed with \code{\link{confint}}.
#' 
#' @name biglm_tidiers
#' 
#' @examples
#' 
#' if (require("biglm", quietly = TRUE)) {
#'     bfit <- biglm(mpg ~ wt + disp, mtcars)
#'     tidy(bfit)
#'     tidy(bfit, conf.int = TRUE)
#'     tidy(bfit, conf.int = TRUE, conf.level = .9)
#'     
#'     glance(bfit)
#'     
#'     # bigglm: logistic regression
#'     bgfit <- bigglm(am ~ mpg, mtcars, family = binomial())
#'     tidy(bgfit)
#'     tidy(bgfit, exponentiate = TRUE)
#'     tidy(bgfit, conf.int = TRUE)
#'     tidy(bgfit, conf.int = TRUE, conf.level = .9)
#'     tidy(bgfit, conf.int = TRUE, conf.level = .9, exponentiate = TRUE)
#'     
#'     glance(bgfit)
#' }
#' 
#' @import dplyr
#' 
#' @export
tidy.biglm <- function(x, conf.int = FALSE, conf.level = .95,
                       exponentiate = FALSE, ...) {
    mat <- summary(x)$mat
    nn <- c("estimate", "conf.low", "conf.high", "std.error", "p.value")
    ret <- fix_data_frame(mat, nn)
    
    # remove the 95% confidence interval and replace:
    # it isn't exactly 95% (uses 2 rather than 1.96), and doesn't allow
    # specification of confidence level in any case
    ret <- ret %>% dplyr::select(-conf.low, -conf.high)
    
    process_lm(ret, x, conf.int = conf.int, conf.level = conf.level,
               exponentiate = exponentiate)
}


#' @rdname biglm_tidiers
#' 
#' @return \code{glance.biglm} returns a one-row data frame, with columns
#'   \item{r.squared}{The percent of variance explained by the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{deviance}{deviance}
#'   \item{df.residual}{residual degrees of freedom}
#' 
#' @export
glance.biglm <- function(x, ...) {
    s <- summary(x)
    ret <- data.frame(r.squared = s$rsq)
    ret <- finish_glance(ret, x)
    ret$df.residual <- x$df.resid  # add afterwards
    ret
}
