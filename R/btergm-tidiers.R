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
#' @template param_confint
#' @template param_exponentiate
#' @template param_unused_dots
#'
#' @evalRd return_tidy("term", "estimate", "conf.low", "conf.high")
#'
#' @export
#' @aliases btergm_tidiers
#' @seealso [tidy()], [btergm::btergm()]
tidy.btergm <- function(x, conf.int = FALSE, conf.level = .95, exponentiate = FALSE, ...) {

  ret <- tibble::tibble(
    term = names(x@coef),
    estimate = x@coef
  )

  if (conf.int) {
    ci <- as_tidy_tibble(
      btergm::confint(x, level = conf.level),
      new_names = c("estimate", "conf.low", "conf.high"))[, -2]
    ret <- dplyr::left_join(ret, ci, by = "term")
  }

  if (exponentiate) {
    ret <- exponentiate(ret)
  }

  ret
}
