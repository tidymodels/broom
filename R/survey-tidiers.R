#' @rdname ordinal_tidiers
#' @export
tidy.svyolr <- tidy.polr

#' @rdname ordinal_tidiers
#' @export
tidy.svyolr

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
glance.svyolr <- function(x, ...) {
  tibble(
    edf = x$edf,
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    logLik = stats::logLik(x),
    df.residual = stats::df.residual(x),
    nobs = stats::nobs(x)
  )
}

