#' @templateVar class polr
#' @template title_desc_tidy
#' 
#' @param x A `polr` object returned from [MASS::polr().
#' @template param_confint
#' @template param_exponentiate
#' @param conf.type Whether to use `"profile"` or `"Wald"` confidendence
#'   intervals, passed to the `type` argument of [ordinal::confint.clm()].
#'   Defaults to `"profile"`.
#' @template param_unused_dots
#'   
#' @examples
#' 
#' library(MASS)
#' 
#' fit <- polr(Sat ~ Infl + Type + Cont, weights = Freq, data = housing)
#' 
#' tidy(fit, exponentiate = TRUE, conf.int = TRUE)
#' 
#' glance(fit)
#' augment(fit, type.predict = "class")
#' 
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
#' @aliases ordinal_tidiers
#' @export
#' @seealso [tidy], [ordinal::clm()], [ordinal::confint.clm()]
#' @family ordinal tidiers
tidy.polr <- function(x, conf.int = FALSE, conf.level = .95,
                      exponentiate = FALSE, ...) {
  
  conf.type <- rlang::arg_match(conf.type)
  ret <- as_broom_tibble(coef(summary(x)))
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")
  
  if (conf.int) {
    ci <- confint(x, level = conf.level)
    ci <- as_broom_tibble(ci)
    colnames(ci) <- c("term", "conf.low", "conf.high")
    ret <- dplyr::left_join(ret, ci)
  }
  
  if (exponentiate) {
    ret <- mutate_at(ret, vars(estimate, conf.low, conf.high), exp)
  }
  
  types <- c("alpha", "beta", "zeta")
  new_types <- c("intercept", "location", "scale")
  ret$coef.type <- rep(types, vapply(x[types], length, numeric(1)))
  
  ret[ret$term %in% names(x$coefficients), "coefficient_type"] <- "coefficient"
  ret[ret$term %in% names(x$zeta), "coefficient_type"] <- "zeta"
  
  as_tibble(ret)
}

#' @templateVar class polr
#' @template title_desc_glance
#' 
#' @inherit tidy.polr params examples
#'
#' @evalRd return_glance(
#'  "edf",
#'  "logLik",
#'  "AIC",
#'  "BIC",
#'  "deviance",
#'  "df.residual",
#'  "nobs"
#' )
#'
#' @export
#' @seealso [tidy], [MASS::polr()]
#' @family ordinal tidiers
glance.polr <- function(x, ...) {
  tibble(
    edf = x$edf,
    logLik = as.numeric(stats::logLik(x)),
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    deviance = stats::deviance(x),
    df.residual = stats::df.residual(x),
    nobs = stats::nobs(x)
  )
}

#' @templateVar class polr
#' @template title_desc_augment
#' 
#' @inherit tidy.polr params examples
#' @template param_data
#' @template param_newdata
#' 
#' @param type.predict Which type of prediction to compute, either `"prob"`
#'   or `"class"`, passed to [MASS::predict.polr()]. Defaults to `"prob"`.
#' 
#' @export
#' @seealso [tidy], [MASS::polr()], [stats::predict.polr()]
#' @family ordinal tidiers
#' 
augment.polr <- function(x, data = model.frame(x), newdata = NULL,
                         type.predict = c("probs", "class"), ...) {
  type <- rlang::arg_match(type.predict)
  augment_columns(x, data, newdata, type = type.predict)
}
