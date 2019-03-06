#' @templateVar class Gam
#' @template title_desc_tidy
#' 
#' @param x A `Gam` object returned from a call to [gam::gam()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "term",
#'   "df",
#'   "sumsq",
#'   "meansq",
#'   "statistic",
#'   "p.value"
#' )
#'   
#' @details Tidy `gam` objects created by calls to [mgcv::gam()] with
#'   [tidy.gam()].
#'
#' @examples
#'
#' library(gam)
#' g <- gam(mpg ~ s(hp, 4) + am + qsec, data = mtcars)
#'   
#' tidy(g)
#' glance(g)
#' 
#' @export
#' @family gam tidiers
#' @aliases Gam_tidiers
#' @seealso [tidy()], [gam::gam()], [tidy.anova()], [tidy.gam()]
tidy.Gam <- function(x, ...) {
  tidy(summary(x)$parametric.anova)
}

#' @templateVar class Gam
#' @template title_desc_glance
#' 
#' @inheritParams tidy.Gam
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
#' @details Glance at `gam` objects created by calls to [mgcv::gam()] with
#'   [glance.gam()].
#' 
#' @family gam tidiers
#' @export
#' @seealso [glance()], [gam::gam()]
glance.Gam <- function(x, ...) {
  s <- summary(x)
  ret <- tibble(df = s$df[1],
                logLik = as.numeric(stats::logLik(x)),
                AIC = stats::AIC(x),
                BIC = stats::BIC(x),
                deviance = stats::deviance(x),
                df.residual = stats::df.residual(x),
                nobs = stats::nobs(x))
  ret
}
