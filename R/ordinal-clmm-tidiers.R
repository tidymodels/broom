#' @templateVar class clmm
#' @template title_desc_tidy
#'
#' @param x A `clmm` object returned from [ordinal::clmm()].
#' @template param_confint
#' @template param_exponentiate
#' @template param_unused_dots
#'
#' @examples
#'
#' library(ordinal)
#'
#' fit <- clmm(rating ~ temp + contact + (1 | judge), data = wine)
#'
#' tidy(fit)
#' tidy(fit, conf.int = TRUE, conf.level = 0.9)
#' tidy(fit, conf.int = TRUE, exponentiate = TRUE)
#'
#' glance(fit)
#'
#' fit2 <- clmm(rating ~ temp + (1 | judge), nominal = ~contact, data = wine)
#' tidy(fit2)
#' glance(fit2)
#' @evalRd return_tidy(regression = TRUE)
#'
#' @note In `broom 0.7.0` the `coefficient_type` column was renamed to
#'   `coef.type`, and the contents were changed as well.
#'
#'   Note that `intercept` type coefficients correspond to `alpha`
#'   parameters, `location` type coefficients correspond to `beta`
#'   parameters, and `scale` type coefficients correspond to `zeta`
#'   parameters.
#'
#' @export
#' @seealso [tidy], [ordinal::clmm()], [ordinal::confint.clm()]
#' @family ordinal tidiers
tidy.clmm <- function(x, conf.int = FALSE, conf.level = 0.95,
                      exponentiate = FALSE, ...) {

  # NOTE: pretty much the same as tidy.clm() except there is no
  # `type` argument to confint.clmm()

  ret <- as_tibble(coef(summary(x)), rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")

  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }

  if (exponentiate) {
    ret <- exponentiate(ret)
  }

  types <- c("alpha", "beta", "zeta")
  new_types <- c("intercept", "location", "scale")
  ret$coef.type <- rep(new_types, vapply(x[types], length, numeric(1)))
  as_tibble(ret)
}

#' @templateVar class clmm
#' @template title_desc_glance
#'
#' @inherit tidy.clmm params examples
#'
#' @evalRd return_glance(
#'   "edf",
#'   "AIC",
#'   "BIC",
#'   "logLik",
#'   "nobs"
#' )
#'
#' @export
#' @seealso [tidy], [ordinal::clmm()]
#' @family ordinal tidiers
glance.clmm <- function(x, ...) {
  as_glance_tibble(
    edf = x$edf,
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    logLik = stats::logLik(x),
    nobs = stats::nobs(x),
    na_types = "irrri"
  )
}
