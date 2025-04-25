#' @templateVar class speedglm
#' @template title_desc_tidy
#'
#' @param x A `speedglm` object returned from [speedglm::speedglm()].
#' @template param_confint
#' @template param_exponentiate
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @examplesIf rlang::is_installed("speedglm")
#'
#' # load libraries for models and data
#' library(speedglm)
#'
#' # generate data
#' clotting <- data.frame(
#'   u = c(5, 10, 15, 20, 30, 40, 60, 80, 100),
#'   lot1 = c(118, 58, 42, 35, 27, 25, 21, 19, 18)
#' )
#'
#' # fit model
#' fit <- speedglm(lot1 ~ log(u), data = clotting, family = Gamma(log))
#'
#' # summarize model fit with tidiers
#' tidy(fit)
#' glance(fit)
#'
#' @aliases speedglm_tidiers
#' @export
#' @family speedlm tidiers
#' @seealso [speedglm::speedglm()]
tidy.speedglm <- function(
  x,
  conf.int = FALSE,
  conf.level = 0.95,
  exponentiate = FALSE,
  ...
) {
  ret <- as_tibble(coef(summary(x)), rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")

  if (is.factor(ret$p.value)) {
    ret$p.value <- as.numeric(levels(ret$p.value))[ret$p.value]
  } else {
    ret$p.value <- as.numeric(ret$p.value)
  }

  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }

  if (exponentiate) {
    ret <- exponentiate(ret)
  }

  as_tibble(ret)
}

#' @templateVar class speedglm
#' @template title_desc_glance
#'
#' @inherit tidy.speedglm params examples
#' @template param_unused_dots
#'
#' @evalRd return_glance(
#'   "null.deviance",
#'   "df.null",
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "deviance",
#'   "df.residual",
#'   "nobs"
#' )
#'
#' @export
#' @family speedlm tidiers
#' @seealso [speedglm::speedlm()]
glance.speedglm <- function(x, ...) {
  as_glance_tibble(
    null.deviance = x$nulldev,
    df.null = x$nulldf,
    logLik = as.numeric(stats::logLik(x)),
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    deviance = x$deviance,
    df.residual = x$df,
    nobs = stats::nobs(x),
    na_types = "rirrrrii"
  )
}

#' @export
augment.speedglm <- augment.default
