#' Tidying methods for a nonlinear model
#'
#' These methods tidy the coefficients of a nonlinear model into a summary,
#' augment the original data with information on the fitted values and residuals,
#' and construct a one-row glance of the model's statistics.
#' 
#' @param x An object of class "nls"
#' @param data original data this was fitted on; if not given this will
#' attempt to be reconstructed from nls (may not be successful)
#' 
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#' 
#' @template augment_NAs
#' 
#' @seealso \code{\link{nls}} and \code{\link{summary.nls}}
#' 
#' @examples
#' 
#' n <- nls(mpg ~ k * e ^ wt, data = mtcars, start = list(k = 1, e = 2))
#' 
#' tidy(n)
#' augment(n)
#' glance(n)
#' 
#' library(ggplot2)
#' ggplot(augment(n), aes(wt, mpg)) + geom_point() + geom_line(aes(y = .fitted))
#' 
#' # augment on new data
#' newdata <- head(mtcars)
#' newdata$wt <- newdata$wt + 1
#' augment(n, newdata = newdata)
#' 
#' @name nls_tidiers
NULL


#' @rdname nls_tidiers
#' 
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level of the interval, used only if
#' \code{conf.int=TRUE}
#' @param quick whether to compute a smaller and faster version, containing
#' only the \code{term} and \code{estimate} columns.
#'
#' @return \code{tidy} returns one row for each coefficient in the model,
#' with five columns:
#'   \item{term}{The term in the nonlinear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error from the linear model}
#'   \item{statistic}{t-statistic}
#'   \item{p.value}{two-sided p-value}
#' 
#' @export
tidy.nls <- function(x, conf.int = FALSE, conf.level = .95,
                     quick = FALSE, ...) {
    if (quick) {
        co <- stats::coef(x)
        ret <- data.frame(term = names(co), estimate = unname(co))
        return(ret)
    }
    
    nn <- c("estimate", "std.error", "statistic", "p.value")
    ret <- fix_data_frame(stats::coef(summary(x)), nn)

    if (conf.int) {
        # avoid "Waiting for profiling to be done..." message
        CI <- suppressMessages(stats::confint(x, level = conf.level))
        if (is.null(dim(CI))) {
            CI = matrix(CI, nrow=1)
        }
        colnames(CI) = c("conf.low", "conf.high")
        ret <- cbind(ret, unrowname(CI))
    }
    ret
}


#' @rdname nls_tidiers
#' 
#' @param newdata new data frame to use for predictions
#' 
#' @return \code{augment} returns one row for each original observation,
#' with two columns added:
#'   \item{.fitted}{Fitted values of model}
#'   \item{.resid}{Residuals}
#' 
#' If \code{newdata} is provided, these are computed on based on predictions
#' of the new data.
#' 
#' @export
augment.nls <- function(x, data = NULL, newdata = NULL, ...) {
    if (!is.null(newdata)) {
        # use predictions on new data
        newdata <- fix_data_frame(newdata, newcol = ".rownames")
        newdata$.fitted <- stats::predict(x, newdata = newdata)
        return(newdata)
    }

    if (is.null(data)) {
        pars <- names(x$m$getPars())
        env <- as.list(x$m$getEnv())
        data <- as.data.frame(env[!(names(env) %in% pars)])
    } else {
        # preprocess data to fit NAs
        #if (!is.null(x$na.action) && class(x$na.action) == "omit") {
        #    data <- data[-x$na.action, ]
        #    # get rid of rownames
        #    rownames(data) <- NULL
        #}
    }
    
    return(augment_columns(x, data))
        
    # move rownames if necessary
    data <- fix_data_frame(data, newcol = ".rownames")
    
    data$.fitted <- stats::predict(x)
    data$.resid <- stats::resid(x)
    data
}


#' @rdname nls_tidiers
#' 
#' @param ... extra arguments (not used)
#' 
#' @return \code{glance} returns one row with the columns
#'   \item{sigma}{the square root of the estimated residual variance}
#'   \item{isConv}{whether the fit successfully converged}
#'   \item{finTol}{the achieved convergence tolerance}
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'   \item{deviance}{deviance}
#'   \item{df.residual}{residual degrees of freedom}
#' 
#' @export
glance.nls <- function(x, ...) {
    s <- summary(x)
    ret <- unrowname(data.frame(sigma=s$sigma, isConv=s$convInfo$isConv,
                                finTol=s$convInfo$finTol))
    finish_glance(ret, x)
}
