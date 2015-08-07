#' Tidying methods for generalized estimating equations models
#' 
#' These methods tidy the coefficients of generalized estimating
#' equations models of the \code{geeglm} class from functions of the
#' \code{geepack} package.
#' 
#' 
#' @param x An object of class \code{geeglm}, such as from \code{geeglm}
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level of the interval, used only if
#' \code{conf.int=TRUE}
#' @param exponentiate whether to exponentiate the coefficient estimates
#' and confidence intervals (typical for log distributions)
#' @param quick whether to compute a smaller and faster version, containing
#' only the \code{term} and \code{estimate} columns.
#' @param ... Additional arguments to be passed to other methods.  Currently
#' not used.
#' 
#' @details If \code{conf.int=TRUE}, the confidence interval is computed with
#' the \code{\link{confint.geeglm}} function.
#' 
#' While \code{tidy} is supported for "geeglm" objects, \code{augment} and
#' \code{glance} are not.
#' 
#' If you have missing values in your model data, you may need to
#' refit the model with \code{na.action = na.exclude} or deal with the
#' missingness in the data beforehand.
#' 
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#' 
#' @name geeglm_tidiers
#' 
#' @examples
#' 
#' if (require('geepack')) {
#'     data(state)
#'     ds <- data.frame(state.region, state.x77)
#' 
#'     geefit <- geeglm(Income ~ Frost + Murder, id = state.region,
#'                      data = ds, family = gaussian,
#'                      corstr = 'exchangeable')
#' 
#'     tidy(geefit)
#'     tidy(geefit, quick = TRUE)
#'     tidy(geefit, conf.int = TRUE)
#' }
#' 
#' @rdname geeglm_tidiers
#' @return \code{tidy.geeglm} returns one row for each coefficient, with five columns:
#'   \item{term}{The term in the linear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error from the GEE model}
#'   \item{statistic}{Wald statistic}
#'   \item{p.value}{two-sided p-value}
#' 
#' If \code{conf.int=TRUE}, it also includes columns for
#' \code{conf.low} and \code{conf.high}, computed with
#' \code{\link{confint.geeglm}} (included as part of broom).
#' 
#' @export
#' 
#' @import dplyr
#' 
#' @export
tidy.geeglm <- function(x, conf.int = FALSE, conf.level = .95,
                    exponentiate = FALSE, quick = FALSE, ...) {
    if (quick) {
        co <- stats::coef(x)
        ret <- data.frame(term = names(co), estimate = unname(co))
        return(ret)
    }
    co <- stats::coef(summary(x))
    
    nn <- c("estimate", "std.error", "statistic", "p.value")
    ret <- fix_data_frame(co, nn[1:ncol(co)])

    process_geeglm(ret, x, conf.int = conf.int, conf.level = conf.level,
               exponentiate = exponentiate)
}


#' helper function to process a tidied geeglm object
#' 
#' Adds a confidence interval, and possibly exponentiates, a tidied
#' object.
#' 
#' @param ret data frame with a tidied version of a coefficient matrix
#' @param x a "geeglm" object
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level of the interval, used only if
#' \code{conf.int=TRUE}
#' @param exponentiate whether to exponentiate the coefficient estimates
#' and confidence intervals (typical for log distributions)
process_geeglm <- function(ret, x, conf.int = FALSE, conf.level = .95,
                       exponentiate = FALSE) {
    if (exponentiate) {
        # save transformation function for use on confidence interval
        if (is.null(x$family) ||
            (x$family$link != "logit" && x$family$link != "log")) {
            warning(paste("Exponentiating coefficients, but model did not use",
                          "a log or logit link function"))
        }
        trans <- exp
    } else {
        trans <- identity
    }
    
    if (conf.int) {
        # avoid "Waiting for profiling to be done..." message
        CI <- suppressMessages(stats::confint(x, level = conf.level))
        colnames(CI) = c("conf.low", "conf.high")
        ret <- cbind(ret, trans(unrowname(CI)))
    }
    ret$estimate <- trans(ret$estimate)
    
    ret
}

##' Generate confidence intervals for GEE analyses
##'
##' @title Confidence interval for \code{geeglm} objects
##' @param object The 'geeglm' object
##' @param parm The parameter to calculate the confidence interval
##' for.  If not specified, the default is to calculate a confidence
##' interval on all parameters (all variables in the model).
#' @param level confidence level of the interval, used only if
#' \code{conf.int=TRUE}
##' @param ... Additional parameters
##' @details This function was taken from
##' http://stackoverflow.com/a/21221995/2632184.
##' @return Returns the upper and lower confidence intervals
confint.geeglm <- function(object, parm, level = 0.95, ...) {
    cc <- stats::coef(summary(object))
    mult <- stats::qnorm((1+level)/2)
    citab <- with(as.data.frame(cc),
                  cbind(lwr=Estimate-mult*Std.err,
                        upr=Estimate+mult*Std.err))
    rownames(citab) <- rownames(cc)
    citab[parm,]
}
