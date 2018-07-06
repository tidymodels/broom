#' @templateVar class orcutt
#' @template title_desc_tidy_lm_wrapper
#' 
#' @param x An `orcutt` object returned from [orcutt::cochrane.orcutt()].
#'
#' @return `tidy` returns the same information as [tidy.lm()], 
#' though without confidence interval options.
#'
#' @examples
#'
#' reg <- lm(mpg ~ wt + qsec + disp, mtcars)
#' tidy(reg)
#'
#' if (require("orcutt", quietly = TRUE)) {
#'   co <- cochrane.orcutt(reg)
#'   co
#'
#'   tidy(co)
#'   glance(co)
#' }
#' 
#' @aliases orcutt_tidiers
#' @export
#' @family orcutt tidiers
#' @seealso [orcutt::cochrane.orcutt()]
tidy.orcutt <- function(x, ...) {
  warning("deal with tidy.orcutt conf.int nonsense")
  tidy.lm(x, ...)
}


#' @templateVar class orcutt
#' @template title_desc_glance
#' 
#' @param x An `orcutt` object returned from [orcutt::cochrane.orcutt()].
#' @template param_unused_dots
#'
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{r.squared}{R-squared}
#'   \item{adj.r.squared}{Adjusted R-squared}
#'   \item{rho}{Spearman's rho autocorrelation}
#'   \item{number.interaction}{Number of interactions}
#'   \item{dw.original}{Durbin-Watson statistic of original fit}
#'   \item{p.value.original}{P-value of original Durbin-Watson statistic}
#'   \item{dw.transformed}{Durbin-Watson statistic of transformed fit}
#'   \item{p.value.transformed}{P-value of autocorrelation after transformation}
#'
#' @export
#' @family orcutt tidiers
#' @seealso [glance()], [orcutt::cochrane.orcutt()]
glance.orcutt <- function(x, ...) {
  tibble(
    r.squared = x$r.squared,
    adj.r.squared = x$adj.r.squared,
    rho = x$rho,
    number.interaction = x$number.interaction,
    dw.original = x$DW[1],
    p.value.original = x$DW[2],
    dw.transformed = x$DW[3],
    p.value.transformed = x$DW[4]
  )
}
