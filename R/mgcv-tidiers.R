#' @templateVar class gam
#' @template title_desc_tidy
#'
#' @param x A `gam` object returned from a call to [mgcv::gam()].
#' @param parametric Logical indicating if parametric or smooth terms should
#'   be tidied. Defaults to `FALSE`, meaning that smooth terms are tidied
#'   by default.
#' @template param_confint
#' @template param_exponentiate
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "term",
#'   "estimate",
#'   "std.error",
#'   "statistic",
#'   "p.value",
#'   edf = "The effective degrees of freedom. Only reported when
#'     `parametric = FALSE`",
#'   ref.df = "The reference degrees of freedom. Only reported when
#'     `parametric = FALSE`"
#' )
#'
#' @details When `parametric = FALSE` return columns `edf` and `ref.df` rather
#'   than `estimate` and `std.error`.
#'
#'
#' @examplesIf rlang::is_installed("mgcv")
#'
#' # load libraries for models and data
#' library(mgcv)
#'
#' # fit model
#' g <- gam(mpg ~ s(hp) + am + qsec, data = mtcars)
#'
#' # summarize model fit with tidiers
#' tidy(g)
#' tidy(g, parametric = TRUE)
#' glance(g)
#' augment(g)
#'
#' @export
#' @aliases mgcv_tidiers gam_tidiers tidy.gam
#' @family mgcv tidiers
#' @seealso [tidy()], [mgcv::gam()]
tidy.gam <- function(x, parametric = FALSE, conf.int = FALSE,
                     conf.level = 0.95, exponentiate = FALSE, ...) {
  if (!parametric && conf.int) {
    message("Confidence intervals only available for parametric terms.")
  }
  if (!parametric && exponentiate) {
    message("Exponentiating coefficients only available for parametric terms.")
  }
  if (parametric) {
    px <- summary(x)$p.table
    ret <- as_tidy_tibble(
      px,
      new_names = c("estimate", "std.error", "statistic", "p.value")
    )
    if (conf.int) {
      # avoid "Waiting for profiling to be done..." message
      # This message doesn't seem to happen with confint.default
      CI <- suppressMessages(
        stats::confint.default(x, level = conf.level)[rownames(px), , drop = FALSE]
      )
      # Think about rank deficiency
      colnames(CI) <- c("conf.low", "conf.high")
      ret <- cbind(ret, unrowname(CI))
      ret <- as_tibble(ret)
    }
  } else {
    sx <- summary(x)$s.table
    sx <- as.data.frame(sx)
    class(sx) <- c("anova", "data.frame")
    ret <- tidy(sx)
  }
  
  if (exponentiate && parametric) {
    ret <- exponentiate(ret)
  }
  
  ret
}

#' @templateVar class gam
#' @template title_desc_glance
#'
#' @inherit tidy.gam params examples
#'
#' @evalRd return_glance(
#'   "df",
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "deviance",
#'   "df.residual",
#'   "nobs",
#'   "adj.r.squared",
#'   "npar"
#' )
#'
#'
#' @export
#' @family mgcv tidiers
#' @seealso [glance()], [mgcv::gam()]
glance.gam <- function(x, ...) {
  s <- summary(x)
  
  as_glance_tibble(
    df = sum(x$edf),
    logLik = as.numeric(stats::logLik(x)),
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    deviance = stats::deviance(x),
    df.residual = stats::df.residual(x),
    nobs = stats::nobs(x),
    # m = s$m, # number of smooth terms (non-standard)
    adj.r.squared = s$r.sq,
    # dev.expl = s$dev.expl, # proportion deviance explained (non-standard)
    # dispersion = s$dispersion, # scale parameter (non-standard)
    # rank = s$rank, # apparent model rank (non-standard)
    npar = s$np,
    na_types = "irrrriiri"
  )
}


#' @templateVar class gam
#' @template title_desc_augment
#'
#' @inherit tidy.gam params examples
#' @template param_data
#' @template param_newdata
#' @template param_type_predict
#' @template param_type_residuals
#'
#' @evalRd return_augment(
#'   ".se.fit",
#'   ".resid",
#'   ".hat",
#'   ".sigma",
#'   ".cooksd"
#' )
#'
#' @details For additional details on Cook's distance, see
#'   [stats::cooks.distance()].
#'
#' @seealso [augment()], [mgcv::gam()]
#' @export
augment.gam <- function(x, data = model.frame(x), newdata = NULL,
                        type.predict, type.residuals, ...) {
  augment_columns(
    x, data, newdata,
    type.predict = type.predict,
    type.residuals = type.residuals
  )
}
