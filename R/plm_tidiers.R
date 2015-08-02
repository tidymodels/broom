#' Tidiers for panel regression linear models
#' 
#' @param x a "plm" object representing a panel object
#' @param data original dataset
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level of the interval, used only if
#' \code{conf.int=TRUE}
#' @param exponentiate whether to exponentiate the coefficient estimates
#' and confidence intervals
#' 
#' @template boilerplate
#' 
#' @return \code{tidy.plm} returns a data frame with one row per
#' coefficient, of the same form as \code{\link{tidy.lm}}.
#' 
#' @seealso \code{\link{lm_tidiers}}
#' 
#' @name plm_tidiers
#' 
#' @examples
#' 
#' if (require("plm", quietly = TRUE)) {
#'     data("Produc", package = "plm")
#'     zz <- plm(log(gsp) ~ log(pcap) + log(pc) + log(emp) + unemp,
#'               data = Produc, index = c("state","year"))
#'     
#'     summary(zz)
#'     
#'     tidy(zz)
#'     tidy(zz, conf.int = TRUE)
#'     tidy(zz, conf.int = TRUE, conf.level = .9)
#'     
#'     head(augment(zz))
#'     
#'     glance(zz)
#' }
#' 
#' @export
tidy.plm <- function(x, conf.int = FALSE, conf.level = .95,
                     exponentiate = FALSE, ...) {
    tidy.lm(x, conf.int = conf.int, conf.level = conf.level,
            exponentiate = exponentiate)
}


#' @rdname plm_tidiers
#' 
#' @return \code{augment} returns a data frame with one row for each
#' initial observation, adding the columns
#'   \item{.fitted}{predicted (fitted) values}
#'   \item{.resid}{residuals}
#' 
#' @export
augment.plm <- function(x, data = as.data.frame(stats::model.frame(x)), ...) {
    augment_columns(x, data, ...)
}


#' @rdname plm_tidiers
#' 
#' @param ... extra arguments, not used
#' 
#' @return \code{glance} returns a one-row data frame with columns
#'   \item{r.squared}{The percent of variance explained by the model}
#'   \item{adj.r.squared}{r.squared adjusted based on the degrees of freedom}
#'   \item{statistic}{F-statistic}
#'   \item{p.value}{p-value from the F test, describing whether the full
#'   regression is significant}
#'   \item{deviance}{deviance}
#'   \item{df.residual}{residual degrees of freedom}
#' 
#' @export
glance.plm <- function(x, ...) {
    s <- summary(x)
    ret <- with(s, data.frame(r.squared = r.squared[1],
                       adj.r.squared = r.squared[2],
                       statistic = fstatistic$statistic,
                       p.value = fstatistic$p.value
    ))
    finish_glance(ret, x)
}
