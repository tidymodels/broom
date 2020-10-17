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
tidy.btergm <- function(x, conf.level = .95, exponentiate = FALSE, ...) {
  if (exponentiate) {
    trans <- exp
  } else {
    trans <- identity
  }

  co <- btergm::confint(x, level = conf.level)

  ret <- as_tidy_tibble(
    co, 
    new_names = c("estimate", "conf.low", "conf.high")[1:ncol(co)]
  )

  ret$conf.low <- trans(ret$conf.low)
  ret$conf.high <- trans(ret$conf.high)
  ret$estimate <- trans(ret$estimate)
  as_tibble(ret)
}
