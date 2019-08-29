#' @templateVar class mfx
#' @template title_desc_tidy
#' 
#' @description The particular functions below provide generic tidy methods for 
#'   objects returned by the `mfx` package, preserving the calculated marginal 
#'   effects instead of the naive model coefficients. The returned tidy tibble 
#'   will also include an additional "atmean"column indicating how the marginal 
#'   effects were originally calculated (see Details below).
#' 
#' @param x A `betamfx`, `logitmfx`, `negbinmfx`, `poissonmfx`, or `probitmfx`  object.
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "term",
#'   atmean = "were the marginal effects originally calculated as the partial effects for the average observation? If FALSE, then these were instead calculated as average partial effects.",
#'   "estimate",
#'   "std.error",
#'   "statistic",
#'   "p.value",
#'   "conf.low",
#'   "conf.high"
#' )
#' 
#' @details The `mfx` package provides methods for calculating marginal effects
#'   for various generalised linear models (GLMs). Unlike standard linear models 
#'   (e.g. OLS regression), estimated model coefficients in a GLM cannot be
#'   directly interpreted as marginal effects (i.e., the change in the response 
#'   variable predicted after a one unit change in one of the regressors). This 
#'   is because the estimated coefficients are multiplicative, dependent on both
#'   the link function that was used for the estimation and any other variables
#'   that were included in the model. When calculating marginal effects, users
#'   must typically choose whether they want to use i) the average observation 
#'   in the data, or ii) the average of the sample marginal effects. See 
#'   `vignette("mfxarticle")` from the `mfx` vignette for more details.
#'   
#' @examples 
#' library(mfx)
#' 
#' ## Using logit regression
#' mfx_logitreg <- logitmfx(am ~ cyl + hp + wt, atmean = T, data = mtcars)
#' tidy(mfx_logitreg)
#' tidy(mfx_logitreg, conf.int=T)
#' mfx_logitreg2 <- logitmfx(am ~ cyl + hp + wt, atmean = F, robust = T, data = mtcars)
#' tidy(mfx_logitreg, conf.int=T)
#' 
#' ## Compare with naive model coefficients (not run)
#' # tidy(glm(am ~ cyl + hp + wt, family = binomial, data = mtcars), conf.int=T)
#' 
#' ## One more example, this time using probit regression on the same data
#' mfx_probitreg <- probitmfx(am ~ cyl + hp + wt, atmean = T, data = mtcars)
#' tidy(mfx_probitreg, conf.int=T)
#' 
#' @name mfx_tidiers
#' 
NULL
#' @rdname mfx_tidiers
#' @seealso [tidy()], [mfx::betamfx()], [mfx::logitmfx()], [mfx::negbinmfx()], [mfx::poissonmfx()], [mfx::probitmfx()]
#' @export
tidy.mfx <-
  function(x, conf.int = FALSE, conf.level = 0.95, ...) {
    
    x_tidy <-
      x$mfxest %>% 
      as.data.frame() %>% 
      tibble::rownames_to_column() %>% 
      tibble::as_tibble() %>%
      ## Note: using the ".data" prefix to avoid "no visible binding for global 
      ## variable" warning during devtools::check()
      dplyr::select(
        term=.data$rowname, estimate=.data$`dF/dx`, std.error=.data$`Std. Err.`, 
        statistic=.data$z, p.value=.data$`P>|z|`
        )
    
    ## Optional: Add "atmean" column
    ## If no "atmean" argument is specified in the model call, then will default to TRUE
    if (!grepl("atmean", format(c(x$call)))) {
      x_tidy$atmean <- TRUE
      ## Else, extract the user-specified "atmean" argument from the model call
    } else {
      x_tidy$atmean <- as.logical(gsub(".*atmean = |,.*|).*", "", format(c(x$call))))
    }
    
    if (conf.int) {
      x_tidy <-
        x_tidy %>%
        dplyr::mutate(
          conf.low = estimate - qt(1-(1-conf.level)/2, df=x$fit$df.residual)*std.error,
          conf.high = estimate + qt(1-(1-conf.level)/2, df=x$fit$df.residual)*std.error
        )
    }
    
    x_tidy <-
      x_tidy %>%
      dplyr::select(term, contains("atmean"), everything())
    
    x_tidy
  }

#' @rdname mfx_tidiers
#' @export
#' @method tidy betamfx
tidy.betamfx <- tidy.mfx

#' @rdname mfx_tidiers
#' @export
#' @method tidy logitmfx
tidy.logitmfx <- tidy.mfx

#' @rdname mfx_tidiers
#' @export
#' @method tidy negbinmfx
tidy.negbinmfx <- tidy.mfx

#' @rdname mfx_tidiers
#' @export
#' @method tidy poissonmfx
tidy.poissonmfx <- tidy.mfx

#' @rdname mfx_tidiers
#' @export
#' @method tidy probitmfx
tidy.probitmfx <- tidy.mfx



#' @templateVar class mfx
#' @template title_desc_augment
#' 
#' @param x A `betamfx`, `logitmfx`, `negbinmfx`, `poissonmfx`, or `probitmfx`  object.
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
#' @details This generic augment method wraps [augment.glm()] for objects from
#'   the `mfx` package.
#'   
#' @examples
#' library(mfx)
#' mfx_logitreg <- logitmfx(am ~ cyl + hp + wt, atmean = T, data = mtcars)
#' augment(mfx_logitreg)
#' mfx_probitreg <- probitmfx(am ~ cyl + hp + wt, atmean = T, data = mtcars)
#' augment(mfx_probitreg)
#' @export
#' @seealso [augment()], [augment.glm()], [mfx::betamfx()], [mfx::logitmfx()], [mfx::negbinmfx()], [mfx::poissonmfx()], [mfx::probitmfx()]
#' @family mfx tidiers
#' @aliases mfx_tidiers
augment.mfx <- function(x, 
                        data = model.frame(x$fit),
                        newdata = NULL,
                        type.predict = c("link", "response", "terms"),
                        type.residuals = c("deviance", "pearson"),
                        se_fit = FALSE, ...) {
  ## Use augment.glm() method on internal fit object
  df <- augment(x$fit, 
                data = data,
                newdata = newdata,
                type.predict = type.predict,
                type.residuals = type.residuals,
                se_fit = se_fit)
  
  df
}

#' @rdname mfx_tidiers
#' @export
#' @method augment betamfx
augment.betamfx <- augment.mfx

#' @rdname mfx_tidiers
#' @export
#' @method augment logitmfx
augment.logitmfx <- augment.mfx

#' @rdname mfx_tidiers
#' @export
#' @method augment negbinmfx
augment.negbinmfx <- augment.mfx

#' @rdname mfx_tidiers
#' @export
#' @method augment poissonmfx
augment.poissonmfx <- augment.mfx

#' @rdname mfx_tidiers
#' @export
#' @method augment probitmfx
augment.probitmfx <- augment.mfx



#' @templateVar class mfx
#' @template title_desc_glance
#' 
#' @param x A `betamfx`, `logitmfx`, `negbinmfx`, `poissonmfx`, or `probitmfx`  object.
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
#' @details This generic glance method wraps [glance.glm()] for objects from
#'   the `mfx` package.   
#' @examples
#' library(mfx)
#' mfx_logitreg <- logitmfx(am ~ cyl + hp + wt, atmean = T, data = mtcars)
#' glance(mfx_logitreg)
#' mfx_probitreg <- probitmfx(am ~ cyl + hp + wt, atmean = T, data = mtcars)
#' glance(mfx_probitreg)
#'
#' @export
#' @seealso [glance()], [glance.glm()], [mfx::betamfx()], [mfx::logitmfx()], [mfx::negbinmfx()], [mfx::poissonmfx()], [mfx::probitmfx()]
#' @family mfx tidiers
#' @aliases mfx_tidiers
glance.mfx <- function(x, ...) {
  ## Use glance.glm() method on internal fit object
  ret <- glance(x$fit)
  ret
}

#' @rdname mfx_tidiers
#' @export
#' @method glance betamfx
glance.betamfx <- glance.mfx

#' @rdname mfx_tidiers
#' @export
#' @method glance logitmfx
glance.logitmfx <- glance.mfx

#' @rdname mfx_tidiers
#' @export
#' @method glance negbinmfx
glance.negbinmfx <- glance.mfx

#' @rdname mfx_tidiers
#' @export
#' @method glance poissonmfx
glance.poissonmfx <- glance.mfx

#' @rdname mfx_tidiers
#' @export
#' @method glance probitmfx
glance.probitmfx <- glance.mfx
