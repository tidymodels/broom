#' @templateVar class clmm
#' @template title_desc_tidy
#' 
#' @param x A `clmm` object returned from [ordinal::clmm()].
#' @template param_confint
#' @template param_exponentiate
#' @param conf.type Whether to use `"profile"` or `"Wald"` confidendence
#'   intervals, passed to the `type` argument of [ordinal::confint.clm()].
#'   Defaults to `"profile"`.
#' @template param_unused_dots
#'   
#' @examples
#' 
#' library(ordinal)
#' 
#' fit <- clmm(rating ~ temp + contact + (1|judge), data = wine)
#' 
#' tidy(fit)
#' tidy(fit, conf.int = TRUE, conf.level = 0.9)
#' tidy(fit, conf.int = TRUE, conf.type = "Wald", exponentiate = TRUE)
#' 
#' glance(fit)
#' 
#' fit2 <- clmm(rating ~ temp + (1|judge), nominal = ~ contact, data = wine)
#' tidy(fit2)
#' glance(fit2)
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
#' @export
#' @seealso [tidy], [ordinal::clmm()], [ordinal::confint.clm()]
#' @family ordinal tidiers
tidy.clmm <- tidy.clm

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
  tibble(
    edf = x$edf,
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    logLik = stats::logLik(x),
    nobs = stats::nobs(x)
  )
}
