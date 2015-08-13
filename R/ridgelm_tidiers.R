#' Tidying methods for ridgelm objects from the MASS package
#' 
#' These methods tidies the coefficients of a ridge regression model
#' chosen at each value of lambda into a data frame, or constructs
#' a one-row glance of the model's choices of lambda (the ridge
#' constant)
#' 
#' @param x An object of class "ridgelm"
#' @param ... extra arguments (not used)
#'
#' @template boilerplate
#'
#' @name ridgelm_tidiers
#'
#' @examples
#' 
#' names(longley)[1] <- "y"
#' fit1 <- MASS::lm.ridge(y ~ ., longley)
#' tidy(fit1)
#' 
#' fit2 <- MASS::lm.ridge(y ~ ., longley, lambda = seq(0.001, .05, .001))
#' td2 <- tidy(fit2)
#' g2 <- glance(fit2)
#' 
#' # coefficient plot
#' library(ggplot2)
#' ggplot(td2, aes(lambda, estimate, color = term)) + geom_line()
#' 
#' # GCV plot
#' ggplot(td2, aes(lambda, GCV)) + geom_line()
#' 
#' # add line for the GCV minimizing estimate
#' ggplot(td2, aes(lambda, GCV)) + geom_line() +
#'     geom_vline(xintercept = g2$lambdaGCV, col = "red", lty = 2)
NULL


#' @rdname ridgelm_tidiers
#' 
#' @return \code{tidy.ridgelm} returns one row for each combination of
#' choice of lambda and term in the formula, with columns:
#'   \item{lambda}{choice of lambda}
#'   \item{GCV}{generalized cross validation value for this lambda}
#'   \item{term}{the term in the ridge regression model being estimated}
#'   \item{estimate}{estimate of coefficient using this lambda}
#'   \item{scale}{The amount this term was scaled}
#' 
#' @export
tidy.ridgelm <- function(x, ...) {
    if (length(x$lambda) == 1) {
        # only one choice of lambda
        ret <- data.frame(lambda = x$lambda, term = names(x$coef),
                          estimate = x$coef,
                          scale = x$scales, xm = x$xm)
        return(unrowname(ret))
    }

    # otherwise, multiple lambdas/coefs/etc, have to tidy
    cotidy <- data.frame(plyr::unrowname(t(x$coef)), lambda = x$lambda,
                     GCV = unname(x$GCV)) %>%
        tidyr::gather(term, estimate, -lambda, -GCV) %>%
        mutate(term = as.character(term)) %>%
        mutate(scale = x$scales[term])
        
    cotidy
}


#' @rdname ridgelm_tidiers
#' 
#' @return \code{glance.ridgelm} returns a one-row data.frame with the columns
#'   \item{kHKB}{modified HKB estimate of the ridge constant}
#'   \item{kLW}{modified L-W estimate of the ridge constant}
#'   \item{lambdaGCV}{choice of lambda that minimizes GCV}
#' 
#' This is similar to the output of \code{select.ridgelm}, but it is returned
#' rather than printed.
#' 
#' @export
glance.ridgelm <- function(x, ...) {
    ret <- data.frame(kHKB = x$kHKB, kLW = x$kLW,
                      lambdaGCV = x$lambda[which.min(x$GCV)])
    ret
}
