#' Tidying methods for a generalized additive model (gam)
#' 
#' These methods tidy the coefficients of a "gam" object (generalized additive
#' model) into a summary, augment the original data with information on the
#' fitted values and residuals, and construct a one-row glance of the model's
#' statistics.
#' 
#' The "augment" method is handled by \link{lm_tidiers}.
#'
#' @param x gam object
#' 
#' @template boilerplate
#' 
#' @return \code{tidy.gam} returns the tidied output of the
#' parametric ANOVA, with one row for each term in the formula.
#' The columns match those in \link{anova_tidiers}.
#'
#' @name gam_tidiers
#' 
#' @seealso \link{lm_tidiers}, \link{anova_tidiers}
#' 
#' @examples
#' 
#' if (require("gam", quietly = TRUE)) {
#'     data(kyphosis)
#'     g <- gam(Kyphosis ~ s(Age,4) + Number, family = binomial, data = kyphosis)
#'     tidy(g)
#'     augment(g)
#'     glance(g)
#' }
#'
#' @export
tidy.gam <- function(x, ...) {
    # return the output of the parametric ANOVA
    tidy(summary(x)$parametric.anova)
}


#' @rdname gam_tidiers
#' 
#' @param ... extra arguments (not used)
#' 
#' @return \code{glance.gam} returns a one-row data.frame with the columns
#'   \item{df}{Degrees of freedom used by the coefficients}
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'   \item{deviance}{deviance}
#'   \item{df.residual}{residual degrees of freedom}
#' 
#' @export
glance.gam <- function(x, ...) {
    s <- summary(x)
    ret <- data.frame(df = s$df[1])
    finish_glance(ret, x)
}
