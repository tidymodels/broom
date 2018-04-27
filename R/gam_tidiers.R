#' Tidying methods for a generalized additive model (gam)
#' 
#' These methods tidy the coefficients of a "gam" object (generalized additive
#' model) into a summary, augment the original data with information on the
#' fitted values and residuals, and construct a one-row glance of the model's
#' statistics.
#' 
#' The "augment" method is handled by \link{lm_tidiers}.
#'
#' @param x gam or Gam object
#' @param parametric logical. Return parametric coefficients (\code{TRUE}) or 
#' information about smooth terms (\code{FALSE})?
#' 
#' @template boilerplate
#' 
#' @return \code{tidy.gam} called on an object from the gam package,
#' or an object from the mgcv package with \code{parametric = FALSE}, returns the 
#' tidied output of the parametric ANOVA with one row for each term in the formula.
#' The columns match those in \link{anova_tidiers}. 
#' \code{tidy.gam} called on a gam object from the mgcv package with 
#' \code{parametric = TRUE} returns the fixed coefficients.
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
tidy.gam <- function(x, parametric = FALSE, ...) {
    if(is_mgcv(x)){
        tidy_mcgv(x, parametric)
    }else{
        tidy.Gam(x)
    }
}

is_mgcv <- function(x) {
    # figure out if gam is from package gam or mcgv
    # As of gam 1.15 this is no longer necessary since gam's class is now named Gam
    mgcv_names <- c("linear.predictors", "converged", "sig2", "edf", "edf1", 
                    "hat", "boundary", "sp", "nsdf", "Ve", "Vp", "rV", 
                    "gcv.ubre", "scale.estimated", "var.summary", 
                    "cmX", "pred.formula", "pterms", "min.edf", "optimizer")
    all(mgcv_names %in% names(x))
    
}

#' @rdname gam_tidiers
#' @export
tidy.Gam <- function(x, ...) {
    # return the output of the parametric ANOVA
    tidy(summary(x)$parametric.anova) 
}

tidy_mcgv <- function(x, parametric = FALSE) {
    if (parametric) {
        px <- summary(x)$p.table
        px <- as.data.frame(px) 
        fix_data_frame(px, c("estimate", "std.error", "statistic", "p.value"))  
    } else {
        sx <- summary(x)$s.table
        sx <- as.data.frame(sx)
        class(sx) <- c("anova", "data.frame")
        tidy(sx)
    }
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
    if(is_mgcv(x)){
        glance_mcgv(x)
    }else{
        glance.Gam(x)
    }
}


#' @rdname gam_tidiers
#' @export 
glance.Gam <- function(x, ...) {
    s <- summary(x)
    ret <- data.frame(df = s$df[1])
    finish_glance(ret, x) 
}

glance_mcgv <- function(x) {
    ret <- data.frame(df = sum(x$edf))
    finish_glance(ret, x)
}
