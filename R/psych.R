#' @templateVar class kappa
#' @template title_desc_tidy
#'
#' @param x A `kappa` object returned from [psych::cohen.kappa()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   type = "Either `weighted` or `unweighted`.",
#'   "estimate",
#'   "conf.low",
#'   "conf.high"
#' )
#'
#' @details Note that confidence level (alpha) for the confidence interval
#'   cannot be set in `tidy`. Instead you must set the `alpha` argument
#'   to [psych::cohen.kappa()] when creating the `kappa` object.
#'
#' @examplesIf rlang::is_installed(c("psych", "ggplot2"))
#'
#' # load libraries for models and data
#' library(psych)
#'
#' # generate example data
#' rater1 <- 1:9
#' rater2 <- c(1, 3, 1, 6, 1, 5, 5, 6, 7)
#'
#' # fit model
#' ck <- cohen.kappa(cbind(rater1, rater2))
#'
#' # summarize model fit with tidiers + visualization
#' tidy(ck)
#'
#' # graph the confidence intervals
#' library(ggplot2)
#'
#' ggplot(tidy(ck), aes(estimate, type)) +
#'   geom_point() +
#'   geom_errorbarh(aes(xmin = conf.low, xmax = conf.high))
#'
#' @aliases kappa_tidiers psych_tidiers
#' @export
#' @seealso [tidy()], [psych::cohen.kappa()]
#'
tidy.kappa <- function(x, ...) {
  ret <- as_tidy_tibble(
    x$confid,
    new_names = c("conf.low", "estimate", "conf.high"),
    new_column = "type"
  ) |>
    dplyr::select(type, estimate, conf.low, conf.high) |>
    mutate(type = gsub(" kappa", "", type))

  ret
}
