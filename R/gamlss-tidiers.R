#' @templateVar class gamlss
#' @template title_desc_tidy
#'
#' @param x A `gamlss` object returned from [gamlss::gamlss()].
#' @template param_quick
#' @template param_unused_dots
#' 
#' @evalRd return_tidy(
#'   parameter = "Type of coefficient being estimated: `mu`, `sigma`,
#'     `nu`, or `tau`.",
#'   "term",
#'   "estimate",
#'   "std.error",
#'   "statistic",
#'   "p.value"
#' )
#' 
#' @examples
#' 
#' library(gamlss)
#' 
#' g <- gamlss(
#'   y ~ pb(x),
#'   sigma.fo = ~ pb(x),
#'   family = BCT,
#'   data = abdom,
#'   method = mixed(1, 20)
#' )
#'
#' tidy(g)
#'
#' @export
tidy.gamlss <- function(x, quick = FALSE, ...) {
  if (quick) {
    co <- stats::coef(x)
    return(tibble(term = names(co), estimate = unname(co)))
  }

  # use capture.output to prevent summary from being printed to screen
  utils::capture.output(s <- summary(x, type = "qr"))

  # tidy the coefficients much as would be done for a linear model
  nn <- c("estimate", "std.error", "statistic", "p.value")
  ret <- fix_data_frame(s, nn)

  # add parameter types. This assumes each coefficient table starts
  # with "(Intercept)": unclear if this is guaranteed
  parameters <- x$parameters[cumsum(ret$term == "(Intercept)")]
  bind_cols(parameter = parameters, ret)
}
