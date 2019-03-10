#' @templateVar class gam
#' @template title_desc_tidy
#' 
#' @param x A `gam` object returned from a call to [mgcv::gam()].
#' @param parametric Logical indicating if parametric or smooth terms should
#'   be tidied. Defaults to `FALSE`, meaning that smooth terms are tidied
#'   by default.
#' @template param_confint 
#' @template param_unused_dots
#' 
#' @evalRd return_tidy(
#'   "term",
#'   "estimate",
#'   "std.error",
#'   "statistic",
#'   "p.value",
#'   "edf",
#'   "ref.df"
#' )
#'
#' @details When `parametric = FALSE` return columns `edf` and `ref.df` rather
#'   than `estimate` and `std.error`.
#' 
#'   To tidy `Gam` objects created by calls to [gam::gam()],
#'   see [tidy.Gam()].
#'
#' @examples
#'
#' g <- mgcv::gam(mpg ~ s(hp) + am + qsec, data = mtcars)
#'   
#' tidy(g)
#' tidy(g, parametric = TRUE)
#' glance(g)
#' 
#'
#' @rdname mgcv_tidy_gam
#' @export
#' @aliases mgcv_tidiers gam_tidiers tidy.gam
#' @family mgcv tidiers
#' @seealso [tidy()], [mgcv::gam()], [tidy.Gam()]
tidy.gam <- function(x, parametric = FALSE, conf.int = FALSE, 
                     conf.level = 0.95, ...) {
    if (!parametric && conf.int) {
      message("Confidence intervals only available for parametric terms.")
    }
    if (parametric) {
    px <- summary(x)$p.table
    px <- as.data.frame(px)
    ret <- fix_data_frame(px, c("estimate", "std.error", "statistic", "p.value"))
    if (conf.int) {
      # avoid "Waiting for profiling to be done..." message
      # This message doesn't seem to happen with confint.default
      CI <- suppressMessages(stats::confint.default(x, level = conf.level)[rownames(px), ,drop = FALSE])
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
#'   "nobs"
#' )
#' 
#' @details To glance `Gam` objects created by calls to [gam::gam()], see
#'   [glance.Gam()].
#' 
#' @rdname mgcv_glance_gam
#' @export
#' @family mgcv tidiers
#' @seealso [glance()], [mgcv::gam()], [glance.Gam()]
glance.gam <- function(x, ...) {
  ret <- tibble(df = sum(x$edf),
                logLik = as.numeric(stats::logLik(x)),
                AIC = stats::AIC(x),
                BIC = stats::BIC(x),
                deviance = stats::deviance(x),
                df.residual = stats::df.residual(x),
                nobs = stats::nobs(x))
  ret
}
