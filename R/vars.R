#' @templateVar class varest
#' @template title_desc_tidy
#'
#' @param x A `varest` object produced by a call to [vars::VAR()].
#' @template param_confint
#' @param ... For `glance()`, additional arguments passed to [summary()].
#' Otherwise ignored.
#'
#' @evalRd return_tidy(regression = TRUE,
#'   component = "Whether a particular term was used to model the mean or the
#'     precision in the regression. See details."
#' )
#'
#' @details The tibble has one row for each term in the regression. The
#'   `component` column indicates whether a particular
#'   term was used to model either the `"mean"` or `"precision"`. Here the
#'   precision is the inverse of the variance, often referred to as `phi`.
#'   At least one term will have been used to model the precision `phi`.
#'
#'   The `vars` package does not include a `confint` method and does not report
#'   confidence intervals for `varest` objects. Setting the `tidy` argument
#'   `conf.int = TRUE` will return a warning.
#'
#' @examplesIf rlang::is_installed("vars")
#'
#' # load libraries for models and data
#' library(vars)
#'
#' # load data
#' data("Canada", package = "vars")
#'
#' # fit models
#' mod <- VAR(Canada, p = 1, type = "both")
#'
#' # summarize model fit with tidiers
#' tidy(mod)
#' glance(mod)
#'
#' @export
#' @seealso [tidy()], [vars::VAR()]
#' @family vars tidiers
#' @aliases vars_tidiers
tidy.varest <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
  check_ellipses("exponentiate", "tidy", "varest", ...)

  # `vars` does not define a `confint` method and does not calculate CIs
  if (isTRUE(conf.int)) {
    cli::cli_warn(c(
      "Confidence intervals are not supported for {.cls varest} objects.",
      "i" = "The {.arg conf.level} argument will be ignored."
    ))
  }

  s <- summary(x)

  ret <- list()

  for (v in names(s$varresult)) {
    ret[[v]] <- as_tidy_tibble(
      s$varresult[[v]]$coefficients,
      new_names = c("estimate", "std.error", "statistic", "p.value")
    )
    ret[[v]]$group <- v
  }

  ret <- dplyr::bind_rows(ret) %>%
    dplyr::relocate(group, 1)

  ret
}


#' @templateVar class varest
#' @template title_desc_glance
#'
#' @inherit tidy.varest params examples
#' @template param_unused_dots
#'
#' @evalRd return_glance(
#'   "lag.order",
#'   "logLik",
#'   "n",
#'   "nobs"
#' )
#'
#' @seealso [glance()], [vars::VAR()]
#' @export
glance.varest <- function(x, ...) {
  s <- summary(x, ...)
  as_glance_tibble(
    lag.order = x$p,
    logLik = s$logLik,
    nobs = x$obs,
    n = x$totobs,
    na_types = "riii"
  )
}
