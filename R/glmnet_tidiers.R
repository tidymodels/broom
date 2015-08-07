# tidiers from the glmnet package, specifically glmnet and cv.glmnet objects

#' Tidiers for LASSO or elasticnet regularized fits
#' 
#' Tidying methods for regularized fits produced by \code{glmnet}, summarizing
#' the estimates across values of the penalty parameter lambda.
#' 
#' @template boilerplate
#' 
#' @details Note that while this representation of GLMs is much easier
#' to plot and combine than the default structure, it is also much
#' more memory-intensive. Do not use for extremely large, sparse matrices.
#' 
#' No \code{augment} method is yet provided even though the model produces
#' predictions, because the input data is not tidy (it is a matrix that
#' may be very wide) and therefore combining predictions with it is not
#' logical. Furthermore, predictions make sense only with a specific
#' choice of lambda.
#' 
#' @examples
#' 
#' if (require("glmnet", quietly = TRUE)) {
#'     set.seed(2014)
#'     x <- matrix(rnorm(100*20),100,20)
#'     y <- rnorm(100)
#'     fit1 <- glmnet(x,y)
#'     
#'     head(tidy(fit1))
#'     glance(fit1)
#'     
#'     library(dplyr)
#'     library(ggplot2)
#'     
#'     tidied <- tidy(fit1) %>% filter(term != "(Intercept)")
#'     
#'     ggplot(tidied, aes(step, estimate, group = term)) + geom_line()
#'     ggplot(tidied, aes(lambda, estimate, group = term)) +
#'         geom_line() + scale_x_log10()
#'  
#'     ggplot(tidied, aes(lambda, dev.ratio)) + geom_line()
#'     
#'     # works for other types of regressions as well, such as logistic
#'     g2 <- sample(1:2, 100, replace=TRUE)
#'     fit2 <- glmnet(x, g2, family="binomial")
#'     head(tidy(fit2))
#' }
#' 
#' @rdname glmnet_tidiers


#' @name glmnet_tidiers
#' 
#' @param x a "glmnet" object
#' @param ... extra arguments (not used)
#' 
#' @return \code{tidy} produces a data.frame with one row per combination of
#' coefficient (including the intercept) and value of lambda, with the
#' columns:
#'   \item{term}{coefficient name (V1...VN by default, along with
#'   "(Intercept)")}
#'   \item{step}{which step of lambda choices was used}
#'   \item{estimate}{estimate of coefficient}
#'   \item{lambda}{value of penalty parameter lambda}
#'   \item{dev.ratio}{fraction of null deviance explained at each
#'   value of lambda}
#' 
#' @import dplyr
#' @importFrom tidyr gather
#' 
#' @export
tidy.glmnet <- function(x, ...) {
    beta <- stats::coef(x)
    
    if (inherits(x, "multnet")) {
        beta_d <- plyr::ldply(beta, function(b) {
            fix_data_frame(as.matrix(b), newcol = "term")
        }, .id = "class")
        ret <- beta_d %>% tidyr::gather(step, estimate, -term, -class)
    } else {
        beta_d <- fix_data_frame(as.matrix(beta), newcol = "term")
        ret <- beta_d %>% tidyr::gather(step, estimate, -term)
    }
    # add values specific to each step
    ret <- ret %>%
        mutate(step = as.numeric(step),
               lambda = x$lambda[step],
               dev.ratio = x$dev.ratio[step])
    ret
}


#' @rdname glmnet_tidiers
#' 
#' @return \code{glance} returns a one-row data.frame with the values
#'   \item{nulldev}{null deviance}
#'   \item{npasses}{total passes over the data across all lambda values}
#' 
#' @export 
glance.glmnet <- function(x, ...) {
    data.frame(nulldev = x$nulldev, npasses = x$npasses)
}


#' Tidiers for glmnet cross-validation objects
#' 
#' Tidying methods for cross-validation performed by \code{glmnet.cv},
#' summarizing the mean-squared-error across choices of the penalty parameter
#' lambda.
#' 
#' @details No \code{augment} method exists for this class.
#' 
#' @template boilerplate
#' 
#' @examples
#' 
#' if (require("glmnet", quietly = TRUE)) {
#'     set.seed(2014)
#' 
#'     nobs <- 100
#'     nvar <- 50
#'     real <- 5
#'     
#'     x <- matrix(rnorm(nobs * nvar), nobs, nvar)
#'     beta <- c(rnorm(real, 0, 1), rep(0, nvar - real))
#'     y <- c(t(beta) %*% t(x)) + rnorm(nvar, sd = 3)
#'     
#'     cvfit1 <- cv.glmnet(x,y)
#'     
#'     head(tidy(cvfit1))
#'     glance(cvfit1)
#'     
#'     library(ggplot2)
#'     tidied_cv <- tidy(cvfit1)
#'     glance_cv <- glance(cvfit1)
#'     
#'     # plot of MSE as a function of lambda
#'     g <- ggplot(tidied_cv, aes(lambda, estimate)) + geom_line() + scale_x_log10()
#'     g
#'     
#'     # plot of MSE as a function of lambda with confidence ribbon
#'     g <- g + geom_ribbon(aes(ymin = conf.low, ymax = conf.high), alpha = .25)
#'     g
#'     
#'     # plot of MSE as a function of lambda with confidence ribbon and choices
#'     # of minimum lambda marked
#'     g <- g + geom_vline(xintercept = glance_cv$lambda.min) +
#'         geom_vline(xintercept = glance_cv$lambda.1se, lty = 2)
#'     g
#'     
#'     # plot of number of zeros for each choice of lambda
#'     ggplot(tidied_cv, aes(lambda, nzero)) + geom_line() + scale_x_log10()
#'     
#'     # coefficient plot with min lambda shown
#'     tidied <- tidy(cvfit1$glmnet.fit)
#'     ggplot(tidied, aes(lambda, estimate, group = term)) + scale_x_log10() +
#'         geom_line() +
#'         geom_vline(xintercept = glance_cv$lambda.min) +
#'         geom_vline(xintercept = glance_cv$lambda.1se, lty = 2)
#' }
#' 
#' @rdname cv.glmnet_tidiers


#' @name cv.glmnet_tidiers
#' 
#' @param x a "cv.glmnet" object
#' @param ... extra arguments (not used)
#' 
#' @return \code{tidy} produces a data.frame with one row per choice of lambda,
#' with columns
#'   \item{lambda}{penalty parameter lambda}
#'   \item{estimate}{estimate (median) of mean-squared error or other
#'   criterion}
#'   \item{std.error}{standard error of criterion}
#'   \item{conf.high}{high end of confidence interval on criterion}
#'   \item{conf.low}{low end of confidence interval on criterion}
#'   \item{nzero}{number of parameters that are zero at this choice of lambda}
#' 
#' @import dplyr
#' @importFrom tidyr gather
#' 
#' @export
tidy.cv.glmnet <- function(x, ...) {
    ret <- as.data.frame(x[c("lambda", "cvm", "cvsd", "cvup", "cvlo",
                             "nzero")])
    colnames(ret) <- c("lambda", "estimate", "std.error", "conf.high",
                       "conf.low", "nzero")
    return(unrowname(ret))
}


#' @rdname cv.glmnet_tidiers
#' 
#' @return \code{glance} returns a one-row data.frame with the values
#'   \item{nulldev}{null deviance}
#'   \item{npasses}{total passes over the data across all lambda values}
#' 
#' @export 
glance.cv.glmnet <- function(x, ...) {
    data.frame(lambda.min = x$lambda.min, lambda.1se = x$lambda.1se)
}
