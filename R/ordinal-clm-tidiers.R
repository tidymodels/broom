#' @templateVar class clm
#' @template title_desc_tidy
#'
#' @param x A `clm` object returned from [ordinal::clm()].
#' @template param_confint
#' @template param_exponentiate
#' @param conf.type Whether to use `"profile"` or `"Wald"` confidence
#'   intervals, passed to the `type` argument of [ordinal::confint.clm()].
#'   Defaults to `"profile"`.
#' @template param_unused_dots
#'
#' @examples
#'
#' library(ordinal)
#'
#' fit <- clm(rating ~ temp * contact, data = wine)
#'
#' tidy(fit)
#' tidy(fit, conf.int = TRUE, conf.level = 0.9)
#' tidy(fit, conf.int = TRUE, conf.type = "Wald", exponentiate = TRUE)
#'
#' glance(fit)
#' augment(fit, type.predict = "prob")
#' augment(fit, type.predict = "class")
#'
#' fit2 <- clm(rating ~ temp, nominal = ~contact, data = wine)
#' tidy(fit2)
#' glance(fit2)
#' @evalRd return_tidy(regression = TRUE)
#'
#' @details In `broom 0.7.0` the `coefficient_type` column was renamed to
#'   `coef.type`, and the contents were changed as well.
#'
#'   Note that `intercept` type coefficients correspond to `alpha`
#'   parameters, `location` type coefficients correspond to `beta`
#'   parameters, and `scale` type coefficients correspond to `zeta`
#'   parameters.
#'
#' @aliases ordinal_tidiers
#' @export
#' @seealso [tidy], [ordinal::clm()], [ordinal::confint.clm()]
#' @family ordinal tidiers
tidy.clm <- function(x, conf.int = FALSE, conf.level = 0.95,
                     conf.type = c("profile", "Wald"), exponentiate = FALSE,
                     ...) {
  conf.type <- rlang::arg_match(conf.type)
  ret <- as_tibble(coef(summary(x)), rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")

  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level, type = conf.type)
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

#' @templateVar class clm
#' @template title_desc_glance
#'
#' @inherit tidy.clm params examples
#'
#' @evalRd return_glance(
#'   "edf",
#'   "AIC",
#'   "BIC",
#'   "logLik",
#'   "df.residual",
#'   "nobs"
#' )
#'
#' @export
#' @seealso [tidy], [ordinal::clm()]
#' @family ordinal tidiers
glance.clm <- function(x, ...) {
  as_glance_tibble(
    edf = x$edf,
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    logLik = stats::logLik(x),
    df.residual = stats::df.residual(x),
    nobs = stats::nobs(x),
    na_types = "irrrii"
  )
}

#' @templateVar class clm
#' @template title_desc_augment
#'
#' @inherit tidy.clm params examples
#' @template param_data
#' @template param_newdata
#'
#' @param type.predict Which type of prediction to compute, either `"prob"`
#'   or `"class"`, passed to [ordinal::predict.clm()]. Defaults to `"prob"`.
#'
#' @export
#' @seealso [tidy], [ordinal::clm()], [ordinal::predict.clm()]
#' @family ordinal tidiers
#'
augment.clm <- function(x, data = model.frame(x), newdata = NULL,
                        type.predict = c("prob", "class"), ...) {
  type.predict <- rlang::arg_match(type.predict)

  df <- if (is.null(newdata)) data else newdata
  df <- as_augment_tibble(df)

  df$.fitted <- predict(object = x, newdata = df, type = type.predict)$fit

  df
}
