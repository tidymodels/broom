#' @templateVar class mfx
#' @template title_desc_tidy
#' @description The particular functions below provide generic tidy methods for 
#'   objects returned by the `mfx` package, preserving the calculated marginal 
#'   effects instead of the naive model coefficients. The returned tidy tibble 
#'   will also include an additional "atmean" column indicating how the marginal 
#'   effects were originally calculated (see Details below).
#' @param x A `logitmfx`, `negbinmfx`, `poissonmfx`, or `probitmfx`  object. 
#' (Note that `betamfx` objects receive their own set of tidiers.)
#' @template param_confint
#' @template param_unused_dots
#' @evalRd return_tidy(
#'   "term",
#'   atmean = "TRUE if the marginal effects were originally calculated as 
#'   the partial effects for the average observation. If FALSE, then these 
#'   were instead calculated as average partial effects.",
#'   "estimate",
#'   "std.error",
#'   "statistic",
#'   "p.value",
#'   "conf.low",
#'   "conf.high"
#' )
#' @details The `mfx` package provides methods for calculating marginal effects
#'   for various generalized linear models (GLMs). Unlike standard linear 
#'   models, estimated model coefficients in a GLM cannot be directly 
#'   interpreted as marginal effects (i.e., the change in the response variable
#'   predicted after a one unit change in one of the regressors). This is 
#'   because the estimated coefficients are multiplicative, dependent on both 
#'   the link function that was used for the estimation and any other variables
#'   that were included in the model. When calculating marginal effects, users
#'   must typically choose whether they want to use i) the average observation 
#'   in the data, or ii) the average of the sample marginal effects. See 
#'   `vignette("mfxarticle")` from the `mfx` package for more details.
#' 
#' @examplesIf rlang::is_installed("mfx")
#' 
#' # load libraries for models and data
#' library(mfx)
#' 
#' # get the marginal effects from a logit regression
#' mod_logmfx <- logitmfx(am ~ cyl + hp + wt, atmean = TRUE, data = mtcars)
#' 
#' tidy(mod_logmfx, conf.int = TRUE)
#' 
#' # compare with the naive model coefficients of the same logit call
#' tidy(
#'   glm(am ~ cyl + hp + wt, family = binomial, data = mtcars), conf.int = TRUE
#' )
#' 
#' augment(mod_logmfx)
#' glance(mod_logmfx)
#' 
#' # another example, this time using probit regression
#' mod_probmfx <- probitmfx(am ~ cyl + hp + wt, atmean = TRUE, data = mtcars)
#' 
#' tidy(mod_probmfx, conf.int = TRUE)
#' augment(mod_probmfx)
#' glance(mod_probmfx)
#' 
#' @family mfx tidiers
#' @seealso [tidy()], [mfx::logitmfx()], [mfx::negbinmfx()], [mfx::poissonmfx()], [mfx::probitmfx()]
#' @export
tidy.mfx <-
  function(x, conf.int = FALSE, conf.level = 0.95, ...) {
    check_ellipses("exponentiate", "tidy", "mfx", ...)
    
    x_tidy <- as_tibble(x$mfxest, rownames = "term")
    colnames(x_tidy) <- c("term", "estimate", "std.error", "statistic", "p.value")
    
    # Optional: Add "atmean" column
    # If no "atmean" argument is specified in the model call, then will default to TRUE
    if (!grepl("atmean", format(c(x$call)))) {
      x_tidy$atmean <- TRUE
      # Else, extract the user-specified "atmean" argument from the model call
    } else {
      x_tidy$atmean <- as.logical(gsub(".*atmean = |,.*|).*", "", format(c(x$call))))
    }
    
    if (conf.int) {
      x_tidy <-
        x_tidy %>%
        dplyr::mutate(
          conf.low = estimate - qt(1 - (1 - conf.level) / 2, 
                                   df = x$fit$df.residual) * std.error,
          conf.high = estimate + qt(1 - (1 - conf.level) / 2, 
                                    df = x$fit$df.residual) * std.error
        )
    }
    
    dplyr::select(x_tidy, term, contains("atmean"), everything())
  }

#' @rdname tidy.mfx
#' @method tidy logitmfx
#' @export
tidy.logitmfx <- tidy.mfx

#' @rdname tidy.mfx
#' @method tidy negbinmfx
#' @export
tidy.negbinmfx <- tidy.mfx

#' @rdname tidy.mfx
#' @method tidy poissonmfx
#' @export
tidy.poissonmfx <- tidy.mfx

#' @rdname tidy.mfx
#' @method tidy probitmfx
#' @export
tidy.probitmfx <- tidy.mfx

#' @templateVar class mfx
#' @template title_desc_augment
#' @inherit tidy.mfx examples
#' @param x A `logitmfx`, `negbinmfx`, `poissonmfx`, or `probitmfx`  object. 
#'   (Note that `betamfx` objects receive their own set of tidiers.)
#' @template param_data
#' @template param_newdata
#' @param type.predict Passed to [stats::predict.glm()] `type` argument. 
#'   Defaults to `"link"`.
#' @param type.residuals Passed to [stats::residuals.glm()] and
#'   to [stats::rstandard.glm()] `type` arguments. Defaults to `"deviance"`.
#' @template param_se_fit
#' @template param_unused_dots
#' @evalRd return_augment(
#'   ".se.fit",
#'   ".hat",
#'   ".sigma",
#'   ".std.resid",
#'   ".cooksd"
#' )
#' @details This generic augment method wraps [augment.glm()] for applicable
#'   objects from the `mfx` package.
#' @family mfx tidiers
#' @seealso [augment.glm()], [mfx::logitmfx()], [mfx::negbinmfx()], 
#'   [mfx::poissonmfx()], [mfx::probitmfx()]
#' @export
augment.mfx <- function(x, 
                        data = model.frame(x$fit),
                        newdata = NULL,
                        type.predict = c("link", "response", "terms"),
                        type.residuals = c("deviance", "pearson"),
                        se_fit = FALSE, ...) {
  # Use augment.glm() method on internal fit object
  augment.glm(x$fit, 
              data = data,
              newdata = newdata,
              type.predict = type.predict,
              type.residuals = type.residuals,
              se_fit = se_fit, ...)
}
#' @rdname augment.mfx
#' @method augment logitmfx
#' @export
augment.logitmfx <- augment.mfx

#' @rdname augment.mfx
#' @method augment negbinmfx
#' @export
augment.negbinmfx <- augment.mfx

#' @rdname augment.mfx
#' @method augment poissonmfx
#' @export
augment.poissonmfx <- augment.mfx

#' @rdname augment.mfx
#' @method augment probitmfx
#' @export
augment.probitmfx <- augment.mfx


#' @templateVar class mfx
#' @template title_desc_glance
#' @inherit tidy.mfx examples
#' @param x A `logitmfx`, `negbinmfx`, `poissonmfx`, or `probitmfx`  object. (Note that `betamfx` objects receive their own set of tidiers.)
#' @template param_unused_dots
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
#' @details This generic glance method wraps [glance.glm()] for applicable 
#'   objects from the `mfx` package.   
#' @family mfx tidiers
#' @seealso [glance.glm()], [mfx::logitmfx()], [mfx::negbinmfx()], 
#'   [mfx::poissonmfx()], [mfx::probitmfx()]
#' @export
glance.mfx <- function(x, ...) {
  # Use glance.glm() method on internal fit object
  glance.glm(x$fit)
}
#' @rdname glance.mfx
#' @method glance logitmfx
#' @export
glance.logitmfx <- glance.mfx

#' @rdname glance.mfx
#' @method glance negbinmfx
#' @export
glance.negbinmfx <- glance.mfx

#' @rdname glance.mfx
#' @method glance poissonmfx
#' @export
glance.poissonmfx <- glance.mfx

#' @rdname glance.mfx
#' @method glance probitmfx
#' @export
glance.probitmfx <- glance.mfx

#' @templateVar class betamfx
#' @template title_desc_tidy
#' @inherit tidy.mfx description details 
#' @param x A `betamfx` object.
#' @template param_confint
#' @template param_unused_dots
#' @evalRd return_tidy(
#'   "term",
#'   atmean = "TRUE if the marginal effects were originally calculated as the 
#'     partial effects for the average observation. If FALSE, then these were 
#'     instead calculated as average partial effects.",
#'   "estimate",
#'   "std.error",
#'   "statistic",
#'   "p.value",
#'   "conf.low",
#'   "conf.high"
#' )
#' 
#' @examplesIf rlang::is_installed("mfx")
#'  
#' library(mfx)
#' 
#' # Simulate some data
#' set.seed(12345)
#' n = 1000
#' x = rnorm(n)
#'
#' # Beta outcome
#' y = rbeta(n, shape1 = plogis(1 + 0.5 * x), shape2 = (abs(0.2*x)))
#' # Use Smithson and Verkuilen correction
#' y = (y*(n-1)+0.5)/n
#' 
#' d = data.frame(y,x)
#' mod_betamfx = betamfx(y ~ x | x, data = d)
#' 
#' tidy(mod_betamfx, conf.int = TRUE)
#' 
#' # Compare with the naive model coefficients of the equivalent betareg call (not run)
#' # tidy(betamfx(y ~ x | x, data = d), conf.int = TRUE)
#' 
#' augment(mod_betamfx)
#' glance(mod_betamfx)
#' 
#' @family mfx tidiers
#' @seealso [tidy.betareg()], [mfx::betamfx()]
#' @export
tidy.betamfx <- tidy.mfx


#' @templateVar class betamfx
#' @template title_desc_augment
#' @inherit tidy.betamfx examples
#' @param x A `betamfx`  object.
#' @template param_data
#' @template param_newdata
#' @param type.predict Character indicating type of prediction to use. Passed to 
#'   the `type` argument of [betareg::predict.betareg()]. Defaults to 
#'   `"response"`.
#' @param type.residuals 	Character indicating type of residuals to use. Passed 
#'   to the `type` argument of [betareg::residuals.betareg()]. Defaults to
#'  `"sweighted2`.
#' @template param_unused_dots
#' @evalRd return_augment(".cooksd")
#' @details This augment method wraps [augment.betareg()] for 
#'   [mfx::betamfx()] objects.
#' @family mfx tidiers
#' @seealso [augment.betareg()], [mfx::betamfx()]
#' @export
augment.betamfx <- function(x, 
                            data = model.frame(x$fit),
                            newdata = NULL,
                            type.predict = c("response", "link", "precision", "variance", "quantile"),
                            type.residuals = c("sweighted2", "deviance", "pearson", "response", "weighted", "sweighted"),
                            ...) {
  # Use augment.betareg() method on internal fit object
  augment.betareg(x$fit,
                  data = data,
                  newdata = newdata,
                  type.predict = type.predict,
                  type.residuals = type.residuals,
                  ...)
}


#' @templateVar class betamfx
#' @template title_desc_glance
#' @inherit tidy.betamfx examples
#' @param x A `betamfx` object.
#' @template param_unused_dots
#' @evalRd return_glance(
#'   "pseudo.r.squared",
#'   "df.null", 
#'   "logLik", 
#'   "AIC",
#'   "BIC",
#'   "df.residual",
#'   "nobs"
#' )
#' @details This glance method wraps [glance.betareg()] for [mfx::betamfx()] objects.
#' @family mfx tidiers
#' @seealso [glance.betareg()], [mfx::betamfx()]
#' @export
glance.betamfx <- function(x, ...) {
  # Use glance.betareg() method on internal fit object
  glance.betareg(x$fit)
}
