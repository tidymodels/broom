#' @templateVar class probitmfx
#' @template title_desc_tidy
#'
#' @param x A `probitmfx` object returned from [mfx::probitmfx()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "term",
#'   atmean = "were the marginal effects originally calculated as the partial effects for the avaerage observation? If FALSE, then these were instead calculated as average partial effects.",
#'   "estimate",
#'   "std.error",
#'   "statistic",
#'   "p.value",
#'   "conf.low",
#'   "conf.high"
#' )
#' 
#' @details This function provides a tidy method for [mfx::probitmfx()], an
#'   enhanced implementation of probit regression that calculates the 
#'   actual marginal effects (i.e. as opposed to just returning the naive model 
#'   coefficients). Calling the function on a `probitmfx()` regression object will
#'   yield a tibble containing these marginal effects and other key model components.
#'   Note that this includes a column indicating whether the marginal effects were 
#'   originally calculated for the average observation, or the average of the sample
#'   marginal effects. See [vignette("mfxarticle")] for more details.

#' @examples 
#' library(mfx)
#' mfx_probreg <- probitmfx(am ~ cyl + hp + wt, atmean = T, data = mtcars)
#' tidy(mfx_probreg)
#' tidy(mfx_probreg, conf.int=T)
#' mfx_probreg2 <- probitmfx(am ~ cyl + hp + wt, atmean = F, robust = T, data = mtcars)
#' tidy(mfx_probreg2, conf.int=T)
#' @export
#' @seealso [tidy()], [tidy.glm()], [mfx::probitmfx()]
#' @family mfx tidiers
#' @aliases mfx_tidiers

tidy.probitmfx <- tidy.logitmfx


#' @templateVar class probitmfx
#' @template title_desc_augment
#'
#' @param x A `probitmfx` object returned from [mfx::probitmfx()].
#' @template param_data
#' @template param_newdata
#' @param type.predict Passed to [stats::predict.glm()] `type`
#'   argument. Defaults to `"link"`.
#' @param type.residuals Passed to [stats::residuals.glm()] and
#'   to [stats::rstandard.glm()] `type` arguments. Defaults to `"deviance"`.
#' @template param_se_fit
#' @template param_unused_dots
#' 
#' @evalRd return_augment(
#'   ".se.fit",
#'   ".hat",
#'   ".sigma",
#'   ".std.resid",
#'   ".cooksd"
#' )
#'
#' @details This augment method wraps [augment.glm()] for [mfx::probitmfx()] 
#'   objects.
#'
#' @export
#' @seealso [augment()], [augment.glm()], [mfx::probitmfx()]
#' @family mfx tidiers
#' @aliases mfx_tidiers
augment.probitmfx <- augment.logitmfx


#' @templateVar class probitmfx
#' @template title_desc_glance
#'
#' @param x A `probitmfx` object returned from [mfx::probitmfx()].
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
#' @details This method wraps [glance.glm()] for [mfx::probitmfx()] objects.
#'   
#' @examples
#' library(mfx)
#' mfx_reg <- probitmfx(am ~ cyl + hp + wt, atmean = T, data = mtcars)
#' glance(mfx_reg)
#'
#' @export
#' @family mfx tidiers
#' @aliases mfx_tidiers
#' @seealso [mfx::probitmfx()], [glance.glm()]
glance.probitmfx <- glance.logitmfx
