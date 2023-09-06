#' @templateVar class geeglm
#' @template title_desc_tidy
#'
#' @param x A `geeglm` object returned from a call to [geepack::geeglm()].
#' @template param_confint
#' @template param_exponentiate
#' @template param_unused_dots
#'
#' @details If `conf.int = TRUE`, the confidence interval is computed with
#'   the an internal `confint.geeglm()` function.
#'
#'   If you have missing values in your model data, you may need to
#'   refit the model with `na.action = na.exclude` or deal with the
#'   missingness in the data beforehand.
#'
#' @examplesIf rlang::is_installed("geepack")
#'
#' # load modeling library
#' library(geepack)
#'
#' # load data
#' data(state)
#'
#'
#' ds <- data.frame(state.region, state.x77)
#'
#' # fit model
#' geefit <- geeglm(Income ~ Frost + Murder,
#'   id = state.region,
#'   data = ds,
#'   corstr = "exchangeable"
#' )
#'
#' # summarize model fit with tidiers
#' tidy(geefit)
#' tidy(geefit, conf.int = TRUE)
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @export
#' @aliases geeglm_tidiers geepack_tidiers
#' @seealso [tidy()], [geepack::geeglm()]
#'
tidy.geeglm <- function(x, conf.int = FALSE, conf.level = .95,
                        exponentiate = FALSE, ...) {
  co <- stats::coef(summary(x))

  ret <- as_tidy_tibble(
    co,
    c("estimate", "std.error", "statistic", "p.value")[1:ncol(co)]
  )

  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }

  if (exponentiate) {
    if (is.null(x$family) ||
      (x$family$link != "logit" && x$family$link != "log")) {
      warning(paste(
        "Exponentiating coefficients, but model did not use",
        "a log or logit link function"
      ))
    }

    ret <- exponentiate(ret)
  }

  ret
}

#' Generate confidence intervals for geeglm objects
#'
#' @param object A `geeglm` object.
#' @param parm The parameter to calculate the confidence interval
#' for. If not specified, the default is to calculate a confidence
#' interval on all parameters (all variables in the model).
#' @param level Confidence level of the interval.
#' @param ... Additional parameters (ignored).
#'
#' @details From https://stackoverflow.com/a/21221995/2632184.
#'
#' @return Lower and upper confidence bounds in a data.frame(?).
#'
#' @noRd
confint.geeglm <- function(object, parm, level = 0.95, ...) {
  cc <- stats::coef(summary(object))
  mult <- stats::qnorm((1 + level) / 2)
  citab <- with(
    as.data.frame(cc),
    cbind(
      lwr = Estimate - mult * Std.err,
      upr = Estimate + mult * Std.err
    )
  )
  rownames(citab) <- rownames(cc)
  citab[parm, ]
}

#' @templateVar class geeglm
#' @template title_desc_glance
#'
#' @inherit tidy.geeglm params examples
#'
#' @evalRd return_glance("df.residual", "n.clusters", "max.cluster.size", "alpha", "gamma")
#'
#' @export
#' @seealso [glance()], [geepack::geeglm()]
#' @family geepack tidiers
glance.geeglm <- function(x, ...) {
  s <- summary(x)
  as_glance_tibble(
    df.residual = x$df.residual,
    n.clusters = length(s$clusz),
    max.cluster.size = max(s$clusz),
    alpha = x$geese$alpha,
    gamma = x$geese$gamma,
    na_types = "iiirr"
  )
}
