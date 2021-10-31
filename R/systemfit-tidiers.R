#' @templateVar class systemfit
#' @template title_desc_tidy
#'
#' @param x A `systemfit` object produced by a call to [systemfit::systemfit()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "term",
#'   "estimate",
#'   "std.error",
#'   "p.value",
#'   "conf.low",
#'   "conf.high"
#' )
#'
#' @details This tidy method works with any model objects of class `systemfit`.
#'          Default returns a tibble of six columns.
#'
#' @examples
#' 
#' if (requireNamespace("systemfit", quietly = TRUE)) {
#'
#' set.seed(27)
#'
#' library(systemfit)
#'
#' df <- data.frame(
#'   X = rnorm(100),
#'   Y = rnorm(100),
#'   Z = rnorm(100),
#'   W = rnorm(100)
#' )
#'
#' fit <- systemfit(formula = list(Y ~ Z, W ~ X), data = df, method = "SUR")
#' tidy(fit)
#'
#' tidy(fit, conf.int = TRUE)
#' 
#' }
#' 
#' @export
#' @seealso [tidy()], [systemfit::systemfit()]
#'
#' @family systemfit tidiers
#' @aliases systemfit_tidiers
#'
tidy.systemfit <- function(x, conf.int = TRUE, conf.level = 0.95, ...) {
  ret <- as_tibble(summary(x)$coefficients, rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")

  if (conf.int) {
    # can't use broom_confint_terms since the resulting confidence
    # intervals are of type `confint.systemfit` not `matrix`

    ci <- confint(x, level = conf.level)
    colnames(ci) <- c("conf.low", "conf.high")
    ci <- as_tibble(unclass(ci), rownames = "term")
    ret <- left_join(ret, ci, by = "term")
  }

  ret
}
