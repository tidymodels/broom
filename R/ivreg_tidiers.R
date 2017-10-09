#' Tidiers for ivreg models
#' 
#' @param x an "ivreg" object 
#' @param data original dataset
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level of the interval, used only if
#' \code{conf.int=TRUE}
#' @param exponentiate whether to exponentiate the coefficient estimates
#' and confidence intervals
#' 
#' @template boilerplate
#' 
#' @return \code{tidy.ivreg} returns a data frame with one row per
#' coefficient, of the same form as \code{\link{tidy.lm}}.
#' 
#' @seealso \code{\link{lm_tidiers}}
#' 
#' @name ivreg_tidiers
#' 
#' @examples
#' 
#' if (require("AER", quietly = TRUE)) {
#'     data("CigarettesSW", package = "AER")
#'     CigarettesSW$rprice <- with(CigarettesSW, price/cpi)
#'     CigarettesSW$rincome <- with(CigarettesSW, income/population/cpi)
#'     CigarettesSW$tdiff <- with(CigarettesSW, (taxs - tax)/cpi)
#'     ivr <- ivreg(log(packs) ~ log(rprice) + log(rincome) | log(rincome) + tdiff + I(tax/cpi),
#'           data = CigarettesSW, subset = year == "1995")
#'     
#'     summary(ivr)
#'     
#'     tidy(ivr)
#'     tidy(ivr, conf.int = TRUE)
#'     tidy(ivr, conf.int = TRUE, exponentiate = TRUE)
#'     
#'     head(augment(ivr))
#'     
#'     glance(ivr)
#' }
#' 
#' @export
tidy.ivreg <- function(x, conf.int = FALSE, conf.level = .95,
    exponentiate = FALSE, ...) {
    
    co <- stats::coef(summary(x))
    nn <- c("estimate", "std.error", "statistic", "p.value")
    ret <- fix_data_frame(co, nn[1:ncol(co)])
    
   process_lm(ret, x, conf.int = conf.int, conf.level = conf.level, exponentiate = exponentiate)
}


#' @rdname ivreg_tidiers
#' 
#' @return \code{augment} returns a data frame with one row for each
#' initial observation, adding the columns
#'   \item{.fitted}{predicted (fitted) values}
#'   \item{.resid}{residuals}
#' 
#' @export
augment.ivreg <- function(x, data = as.data.frame(stats::model.frame(x)), ...) {
    augment_columns(x, data, ...)
}


#' @rdname ivreg_tidiers
#' 
#' @param ... extra arguments, not used
#' 
#' @return \code{glance} returns a one-row data frame with columns
#'   \item{r.squared}{The percent of variance explained by the model}
#'   \item{adj.r.squared}{r.squared adjusted based on the degrees of freedom}
#'   \item{statistic}{Wald test statistic}
#'   \item{p.value}{p-value from the Wald test}
#'   \item{df}{Degrees of freedom used by the coefficients}
#'   \item{sigma}{The square root of the estimated residual variance}
#'   \item{df.residual}{residual degrees of freedom}
#' 
#' @export
glance.ivreg <- function(x, ...) {
    s <- summary(x)
    ret <- with(s, data.frame(
        r.squared     = r.squared,
        adj.r.squared = adj.r.squared,
        sigma         = sigma,
        statistic     = waldtest[1],
        p.value       = waldtest[2],
        df            = df[1]
    ))
    finish_glance(ret, x)
}
