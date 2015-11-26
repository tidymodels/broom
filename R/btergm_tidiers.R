#' Tidying method for a bootstrapped temporal exponential random graph model
#'
#' This method tidies the coefficients of a bootstrapped temporal exponential 
#' random graph model estimated with the \pkg{xergm}. It simply returns the
#' coefficients and their confidence intervals.
#'
#' @return A \code{data.frame} without rownames.
#'
#' @seealso \code{\link[btergm]{btergm}}
#'
#' @name btergm_tidiers
#'
#' @param x a \code{\link[btergm]{btergm}} object
#' @examples
#'
#' if (require("xergm")) {
#'     # Using the same simulated example as the xergm package
#'     # Create 10 random networks with 10 actors
#'     networks <- list()
#'     for(i in 1:10){
#'         mat <- matrix(rbinom(100, 1, .25), nrow = 10, ncol = 10)
#'         diag(mat) <- 0
#'         nw <- network::network(mat)
#'         networks[[i]] <- nw
#'     }
#'     # Create 10 matrices as covariates
#'     covariates <- list()
#'     for (i in 1:10) {
#'         mat <- matrix(rnorm(100), nrow = 10, ncol = 10)
#'         covariates[[i]] <- mat
#'     }
#'     # Fit a model where the propensity to form ties depends
#'     # on the edge covariates, controlling for the number of
#'     # in-stars
#'     btfit <- btergm(networks ~ edges + istar(2) +
#'                       edgecov(covariates), R = 100)
#'
#'     # Show terms, coefficient estimates and errors
#'     tidy(btfit)
#'
#'     # Show coefficients as odds ratios with a 99% CI
#'     tidy(btfit, exponentiate = TRUE, conf.level = 0.99)
#' }
NULL

#' @rdname btergm_tidiers
#'
#' @param conf.level confidence level of the bootstrapped interval
#' @param exponentiate whether to exponentiate the coefficient estimates
#' and confidence intervals
#' @param quick whether to compute a smaller and faster version, containing
#' only the \code{term} and \code{estimate} columns.
#' @param ... extra arguments (currently not used)
#'
#' @details There is no \code{augment} or \code{glance} method 
#' for \pkg{ergm} objects.
#'
#' @return \code{tidy.btergm} returns one row for each coefficient, 
#' with four columns:
#'   \item{term}{The term in the model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{conf.low}{The lower bound of the confidence interval}
#'   \item{conf.high}{The lower bound of the confidence interval}
#'
#' @export
tidy.btergm <- function(x, conf.level = .95,
                        exponentiate = FALSE, quick = FALSE, ...) {
    if (exponentiate) {
        trans <- exp
    } else {
        trans <- identity
    }
    
    if (quick) {
        co <- fit@coef
        ret <- data.frame(term = names(co),
                          estimate = trans(unname(co)))
        return(ret)
    }
    co <- btergm::confint(x, level = conf.level)
    
    nn <- c("estimate", "conf.low", "conf.high")
    if (inherits(co, "listof")) {
        # multiple response variables
        ret <- plyr::ldply(co, fix_data_frame, nn[1:ncol(co[[1]])],
                           .id = "response")
        ret$response <- stringr::str_replace(ret$response, "Response ", "")
    } else {
        ret <- fix_data_frame(co, nn[1:ncol(co)])
    }
    
    ret$conf.low <- trans(ret$conf.low)
    ret$conf.high <- trans(ret$conf.high)
    ret$estimate <- trans(ret$estimate)
    ret
}
