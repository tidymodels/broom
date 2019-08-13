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
tidy.orcutt <- function(x, exponentiate = FALSE, ...) {
  s <- summary(x)
  ret <- tidy.summary.orcutt(s)
  
  process_orcutt(ret, x, exponentiate = exponentiate)
}

#' @rdname orcutt
#' @export
tidy.summary.orcutt <- function(x, ...) {
  co <- stats::coef(x)
  nn <- c("estimate", "std.error", "statistic", "p.value")
  
  ret <- fix_data_frame(co, nn[1:ncol(co)])
  
  as_tibble(ret)
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


process_orcutt <- function(ret,
                           x,
                           exponentiate = FALSE) {
  if (exponentiate) {
    # save transformation function for use on confidence interval
    if (is.null(x$family) ||
        (x$family$link != "logit" && x$family$link != "log")) {
      warning(paste(
        "Exponentiating coefficients, but model did not use",
        "a log or logit link function."
      ))
    }
    trans <- exp
  } else {
    trans <- identity
  }
  
  ret$estimate <- trans(ret$estimate)
  
  as_tibble(ret)
}
