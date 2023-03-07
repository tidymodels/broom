#' @templateVar class btergm
#' @template title_desc_tidy
#'
#' @description This method tidies the coefficients of a bootstrapped
#'   temporal exponential random graph model estimated with the \pkg{xergm}.
#'   It simply returns the coefficients and their confidence intervals.
#'
#' @param x A [btergm::btergm()] object.
#' @param conf.level Confidence level for confidence intervals. Defaults to
#'   0.95.
#' @template param_exponentiate
#' @template param_unused_dots
#'
#' @evalRd return_tidy("term", "estimate", "conf.low", "conf.high")
#'
#' @export
#' @aliases btergm_tidiers
#' @seealso [tidy()], [btergm::btergm()]
#' @examplesIf (rlang::is_installed("btergm") & rlang::is_installed("network"))
#'
#' library(btergm)
#' library(network)
#'
#' set.seed(5)
#'
#' # create 10 random networks with 10 actors
#' networks <- list()
#' for (i in 1:10) {
#'   mat <- matrix(rbinom(100, 1, .25), nrow = 10, ncol = 10)
#'   diag(mat) <- 0
#'   nw <- network(mat)
#'   networks[[i]] <- nw
#' }
#'
#' # create 10 matrices as covariates
#' covariates <- list()
#' for (i in 1:10) {
#'   mat <- matrix(rnorm(100), nrow = 10, ncol = 10)
#'   covariates[[i]] <- mat
#' }
#'
#' # fit the model
#' mod <- btergm(networks ~ edges + istar(2) + edgecov(covariates), R = 100)
#'
#' # summarize model fit with tidiers
#' tidy(mod)
#'
tidy.btergm <- function(x, conf.level = .95, exponentiate = FALSE, ...) {
  co <- btergm::confint(x, level = conf.level)[, -2]

  ret <- as_tidy_tibble(
    co,
    new_names = c("estimate", "conf.low", "conf.high")[1:ncol(co)]
  )

  if (exponentiate) {
    ret <- exponentiate(ret)
  }

  as_tibble(ret)
}
