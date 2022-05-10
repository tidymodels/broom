#' @templateVar class orcutt
#' @template title_desc_tidy
#'
#' @param x An `orcutt` object returned from [orcutt::cochrane.orcutt()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "term",
#'   "estimate",
#'   "std.error",
#'   "statistic",
#'   "p.value"
#' )
#'
#' @examplesIf rlang::is_installed("orcutt")
#'
#' # load libraries for models and data
#' library(orcutt)
#'
#' # fit model and summarize results
#' reg <- lm(mpg ~ wt + qsec + disp, mtcars)
#' tidy(reg)
#'
#'
#' co <- cochrane.orcutt(reg)
#' tidy(co)
#' glance(co)
#' 
#' @aliases orcutt_tidiers
#' @export
#' @family orcutt tidiers
#' @seealso [orcutt::cochrane.orcutt()]
tidy.orcutt <- function(x, ...) {
  s <- summary(x)
  co <- stats::coef(s)
  ret <- as_tibble(co, rownames = "term")
  names(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")
  ret
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
  as_glance_tibble(
    r.squared = unname(x$r.squared),
    adj.r.squared = unname(x$adj.r.squared),
    rho = unname(x$rho),
    number.interaction = unname(x$number.interaction),
    dw.original = unname(x$DW[1]),
    p.value.original = unname(x$DW[2]),
    dw.transformed = unname(x$DW[3]),
    p.value.transformed = unname(x$DW[4]),
    nobs = stats::nobs(x),
    na_types = "rrrirrrri"
  )
}
