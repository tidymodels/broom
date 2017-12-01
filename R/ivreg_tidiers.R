#' Tidiers for ivreg models
#' 
#' @param x An "ivreg" object 
#' @param data Original dataset
#' @param conf.int Whether to include a confidence interval
#' @param conf.level Confidence level of the interval, used only if
#' \code{conf.int=TRUE}
#' @param exponentiate Whether to exponentiate the coefficient estimates
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
#' @param newdata New data to make predictions from (optional)
#' @return \code{augment} returns a data frame with one row for each
#' initial observation, adding the columns:
#'   \item{.fitted}{predicted (fitted) values}
#' and if \code{newdata} is \code{NULL}:
#'   \item{.resid}{residuals}
#'  
#' 
#' @export
augment.ivreg <- function(x, data = as.data.frame(stats::model.frame(x)), newdata, ...) {
    augment_columns(x, data, newdata, ...)
}


#' @rdname ivreg_tidiers
#' 
#' @param ... extra arguments, not used
#' @param diagnostics Logical. Return results of diagnostic tests.
#' 
#' @return \code{glance} returns a one-row data frame with columns
#'   \item{r.squared}{The percent of variance explained by the model}
#'   \item{adj.r.squared}{r.squared adjusted based on the degrees of freedom}
#'   \item{statistic}{Wald test statistic}
#'   \item{p.value}{p-value from the Wald test}
#'   \item{df}{Degrees of freedom used by the coefficients}
#'   \item{sigma}{The square root of the estimated residual variance}
#'   \item{df.residual}{residual degrees of freedom}
#' If \code{diagnostics} is \code{TRUE}, \code{glance} also returns:
#'   \item{p.value.Sargan}{P value of Sargan test}
#'   \item{p.value.Wu.Hausman}{P value of Wu-Hausman test}
#'   \item{p.value.weakinst}{P value of weak instruments test}
#' 
#' @export
glance.ivreg <- function(x, diagnostics = FALSE, ...) {
    s <- summary(x, diagnostics = diagnostics)
    ret <- with(s, data.frame(
        r.squared     = r.squared,
        adj.r.squared = adj.r.squared,
        sigma         = sigma,
        statistic     = waldtest[1],
        p.value       = waldtest[2],
        df            = df[1]
    ))
    if (diagnostics) {
        ret <- cbind(ret, with(s, data.frame(
            statistic.Sargan     = diagnostics["Sargan", "statistic"],
            p.value.Sargan       = diagnostics["Sargan", "p-value"],
            statistic.Wu.Hausman = diagnostics["Wu-Hausman", "statistic"],
            p.value.Wu.Hausman   = diagnostics["Wu-Hausman", "p-value"],
            statistic.weakinst   = diagnostics["Weak instruments", "statistic"],
            p.value.weakinst     = diagnostics["Weak instruments", "p-value"]    
        )))
    }
    finish_glance(ret, x)
}
