#' Tidying methods for an htest object
#' 
#' Tidies hypothesis test objects, such as those from \code{cor.test},
#' \code{t.test}, and \code{wilcox.test}, into a one-row data frame.
#' 
#' @details No \code{augment} method is provided for \code{"htest"},
#' since there is no sense in which a hypothesis test generates one
#' value for each observation.
#' 
#' @param x An object of class \code{"htest"}
#' @param ... extra arguments (not used)
#' 
#' @return Both \code{tidy} and \code{glance} return the same output,
#' a one-row data frame with one or more of the following columns:
#'   \item{estimate}{Estimate of the effect size}
#'   \item{statistic}{Test statistic used to compute the p-value}
#'   \item{p.value}{P-value}
#'   \item{parameter}{Parameter field in the htest, typically degrees of
#'   freedom}
#'   \item{conf.low}{Lower bound on a confidence interval}
#'   \item{conf.high}{Upper bound on a confidence interval}
#'   \item{estimate1}{Sometimes two estimates are computed, such as in a
#'   two-sample t-test}
#'   \item{estimate2}{Sometimes two estimates are computed, such as in a
#'   two-sample t-test}
#'   
#' Which columns are included depends on the hypothesis test used.
#' 
#' @examples
#' 
#' tt <- t.test(rnorm(10))
#' tidy(tt)
#' glance(tt)  # same output for all htests
#' 
#' tt <- t.test(mpg ~ am, data = mtcars)
#' tidy(tt)
#' 
#' wt <- wilcox.test(mpg ~ am, data = mtcars)
#' tidy(wt)
#' 
#' ct <- cor.test(mtcars$wt, mtcars$mpg)
#' tidy(ct)
#' 
#' @name htest_tidiers
NULL


#' @rdname htest_tidiers
#' @export
tidy.htest <- function(x, ...) {
    ret <- x[c("estimate", "statistic", "p.value", "parameter")]
    
    # estimate may have multiple values
    if (length(ret$estimate) > 1) {
        names(ret$estimate) <- paste0("estimate", seq_along(ret$estimate))
        ret <- c(ret$estimate, ret)
        ret$estimate <- NULL
        
        # special case: in a t-test, estimate = estimate1 - estimate2
        if (x$method == "Welch Two Sample t-test") {
            ret <- c(estimate=ret$estimate1 - ret$estimate2, ret)
        }
    }
    
    # parameter may have multiple values as well, such as oneway.test
    if (length(x$parameter) > 1) {
        ret$parameter <- NULL
        if (is.null(names(x$parameter))) {
            warning("Multiple unnamed parameters in hypothesis test; dropping them")
        } else {
            message("Multiple parameters; naming those columns ",
                    paste(make.names(names(x$parameter)), collapse = ", "))
            ret <- append(ret, x$parameter, after = 1)
        }
    }
    
    ret <- compact(ret)
    if (!is.null(x$conf.int)) {
        ret <- c(ret, conf.low=x$conf.int[1], conf.high=x$conf.int[2])
    }
    unrowname(as.data.frame(ret))
}


#' @rdname htest_tidiers
#' @export
glance.htest <- function(x, ...) tidy(x) 
