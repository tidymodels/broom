#' @templateVar class orcutt
#' @template title_desc_tidy_lm_wrapper
#' 
#' @param x An `orcutt` object returned from [orcutt::cochrane.orcutt()].
#'
#' @evalRd return_tidy(
#'   "term",
#'   "estimate",
#'   "std.error",
#'   "statistic",
#'   "p.value"
#' )
#'
#' @examples
#' 
#' library(orcutt)
#'
#' reg <- lm(mpg ~ wt + qsec + disp, mtcars)
#' tidy(reg)
#'
#' co <- cochrane.orcutt(reg)
#' co
#'
#' tidy(co)
#' glance(co)
#' 
#' @aliases orcutt_tidiers
#' @export
#' @family orcutt tidiers
#' @seealso [orcutt::cochrane.orcutt()]
tidy.orcutt <- function(x, ...) {
  warning("deal with tidy.orcutt conf.int nonsense")
  dots <- enquos(...)
  dots$conf.int <- FALSE

  rlang::exec(tidy.lm, x, !!!dots)
}

#' @templateVar class orcutt
#' @template title_desc_glance
#' 
#' @inherit tidy.orcutt params examples
#' @template param_unused_dots
#'
#' @evalRd return_glance(
#'   "r.squared",
#'   "adj.r.squared",
#'   rho = "Spearman's rho autocorrelation",
#'   "number.interaction",
#'   "dw.original",
#'   "p.value.original",
#'   "dw.transformed",
#'   "p.value.transformed",
#'   "nobs"
#' )
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
    p.value.transformed = x$DW[4],
    nobs = stats::nobs(x)
  )
}
