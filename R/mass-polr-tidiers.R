#' @templateVar class polr
#' @template title_desc_tidy
#' 
#' @param x A `polr` object returned from [MASS::polr()].
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
#' @details In `broom 0.7.0` the `coefficient_type` column was renamed to
#'   `coef.type`, and the contents were changed as well. Now the contents
#'   are `coefficient` and `scale`, rather than `coefficient` and `zeta`.
#'
#' @aliases polr_tidiers
#' @export
#' @seealso [tidy], [MASS::polr()]
#' @family ordinal tidiers
tidy.polr <- function(x, conf.int = FALSE, conf.level = 0.95,
                      exponentiate = FALSE, ...) {
  
  ret <- as_tibble(coef(summary(x)), rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic")
  
  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }
  
  if (exponentiate)
    ret <- exponentiate(ret)
  
  mutate(
    ret, 
    coef.type = if_else(term %in% names(x$zeta), "scale", "coefficient")
  )
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
#' @param type.predict Which type of prediction to compute,
#'  passed to [MASS::predict.polr()]. Only supports `"class"` at
#'  the moment.
#' 
#' @export
#' @seealso [tidy], [MASS::polr()], [stats::predict.polr()]
#' @family ordinal tidiers
#' 
augment.polr <- function(x, data = model.frame(x), newdata = NULL,
                         type.predict = c("class"), ...) {
  type <- rlang::arg_match(type.predict)
  augment_columns(x, data, newdata, type = type.predict)
}
