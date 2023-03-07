#' @templateVar class glmRob
#' @template title_desc_tidy
#'
#' @param x A `glmRob` object returned from [robust::glmRob()].
#' @template param_unused_dots
#'
#' @details For tidiers for robust models from the \pkg{MASS} package see
#'   [tidy.rlm()].
#'
#' @examplesIf rlang::is_installed("robust")
#'
#' # load libraries for models and data
#' library(robust)
#'
#' # fit model
#' gm <- glmRob(am ~ wt, data = mtcars, family = "binomial")
#'
#' # summarize model fit with tidiers
#' tidy(gm)
#' glance(gm)
#'
#' @export
#' @family robust tidiers
#' @seealso [robust::glmRob()]
tidy.glmRob <- function(x, ...) {
  co <- stats::coef(summary(x))
  ret <- as_tibble(co, rownames = "term")
  names(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")
  ret
}

#' @templateVar class glmRob
#' @template title_desc_augment
#'
#' @param x Unused.
#' @param ... Unused.
#'
#' @export
augment.glmRob <- function(x, ...) {
  stop(
    paste0(
      "`augment.glmRob` has been deprecated as the robust package",
      "doesn't provide the functionality necessary to implement ",
      "an augment method. Please see the augment method for ",
      "glmrob objects from robustbase."
    ),
    call. = FALSE
  )
  invisible(TRUE)
}

#' @templateVar class glmRob
#' @template title_desc_glance
#'
#' @inherit tidy.glmRob params examples
#' @template param_unused_dots
#'
#' @evalRd return_glance(
#'   "deviance",
#'   "sigma",
#'   "null.deviance",
#'   "df.residual",
#'   "nobs"
#' )
#'
#' @export
#' @family robust tidiers
#' @seealso [robust::glmRob()]
#'
glance.glmRob <- function(x, ...) {
  as_glance_tibble(
    deviance = x$deviance,
    sigma = stats::sigma(x),
    null.deviance = x$null.deviance,
    df.residual = stats::df.residual(x),
    nobs = stats::nobs(x),
    na_types = "rrrii"
  )
}
