#' Tidying methods for a speedlm model
#' 
#' These methods tidy the coefficients of a "speedlm" object 
#' into a summary, augment the original data with information on the
#' fitted values and residuals, and construct a one-row glance of the model's
#' statistics.
#' 
#'
#' @param x speedlm object
#' 
#' @template boilerplate
#' 
#' @return \code{tidy.speedlm} returns the tidied output of the
#' lm with one row for each term in the formula.
#' The columns match those in \link{lm_tidiers}.
#'
#' @name speedlm_tidiers
#' @inheritParams lm_tidiers
#' @seealso \link{lm_tidiers}, \link{biglm_tidiers}
#' 
#' @examples
#' 
#' if (require("speedglm", quietly = TRUE)) {
#'     mod <- speedglm::speedlm(mpg ~ wt + qsec, data = mtcars)
#'     tidy(mod)
#'     glance(mod)
#'     augment(mod)
#' }
#'
#' @export
tidy.speedlm <- tidy.lm

#' @rdname speedlm_tidiers
#' 
#' @param ... extra arguments (not used)
#' 
#' @return \code{glance.speedlm} returns a one-row data.frame with the columns
#'   \item{r.squared}{The percent of variance explained by the model}
#'   \item{adj.r.squared}{r.squared adjusted based on the degrees of freedom}
#'   \item{statistic}{F-statistic}
#'   \item{p.value}{p-value from the F test, describing whether the full
#'   regression is significant}
#'   \item{df}{Degrees of freedom used by the coefficients}
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'   \item{deviance}{deviance}
#'   \item{df.residual}{residual degrees of freedom}
#' 
#' @export
glance.speedlm <- function(x, ...) {
    s <- summary(x)
    ret <- data.frame(r.squared = s$r.squared, adj.r.squared = s$adj.r.squared, statistic = s$fstatistic[1],
        p.value = s$f.pvalue, df = x$nvar)
    ret <- finish_glance(ret, x)
    ret$deviance <- x$RSS # overwritten by finish_glance
    ret
}

#' @rdname speedlm_tidiers
#' @param data data frame to augment
#' @param newdata new data to use for predictions, optional
#' @return  \code{augment.speedlm} returns  one row for each observation, with just one column added:
#'   \item{.fitted}{Fitted values of model}
#' @export
augment.speedlm <- function(x, data = stats::model.frame(x), newdata = data, ...) {
    augment_columns(x, data, newdata)
}
