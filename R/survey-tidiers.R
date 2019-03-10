#' @templateVar class svyolr
#' @template title_desc_tidy
#' 
#' @param x A `svyolr` object returned from [survey::svyolr()].
#' @inherit tidy.polr params details
#' 
#' @export
#' 
#' @examples
#' 
#' library(MASS)
#' 
#' fit <- polr(Sat ~ Infl + Type + Cont, weights = Freq, data = housing)
#' 
#' tidy(fit, exponentiate = TRUE, conf.int = TRUE)
#' glance(fit)
#' 
#' @evalRd return_tidy(regression = TRUE)
#'
#' @aliases svyolr_tidiers
#' @export
#' @seealso [tidy], [survey::svyolr()]
#' @family ordinal tidiers
tidy.svyolr <- tidy.polr

#' @templateVar class svyolr
#' @template title_desc_glance
#' 
#' @inherit tidy.svyolr params examples
#'
#' @evalRd return_glance(
#'   "edf",
#'   "df.residual",
#'   "nobs"
#' )
#'
#' @export
#' @seealso [tidy], [survey::svyolr()]
#' @family ordinal tidiers
glance.svyolr <- function(x, ...) {
  tibble(
    edf = x$edf,
    df.residual = stats::df.residual(x),
    nobs = stats::nobs(x)
  )
}

