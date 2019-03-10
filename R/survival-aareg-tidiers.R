#' @templateVar class aareg
#' @template title_desc_tidy
#'
#' @param x An `aareg` object returned from [survival::aareg()].
#' @template param_unused_dots
#' 
#' @evalRd return_tidy(
#'   "term",
#'   "estimate",
#'   "statistic",
#'   "std.error",
#'   "robust.se",
#'   "z",
#'   "p.value"
#' )
#' 
#' @details `robust.se` is only present when `x` was created with 
#'   `dfbeta = TRUE`.
#'
#' @examples
#'
#' library(survival)
#' 
#' afit <- aareg(
#'   Surv(time, status) ~ age + sex + ph.ecog,
#'   data = lung,
#'   dfbeta = TRUE
#' )
#' 
#' tidy(afit) 
#'
#' @aliases aareg_tidiers
#' @export
#' @seealso [tidy()], [survival::aareg()]
#' @family aareg tidiers
#' @family survival tidiers
#' 
tidy.aareg <- function(x, ...) {
  if (is.null(x$dfbeta)) {
    nn <- c("estimate", "statistic", "std.error", "statistic.z", "p.value")
  } else {
    nn <- c(
      "estimate", "statistic", "std.error", "robust.se",
      "statistic.z", "p.value"
    )
  }
  fix_data_frame(summary(x)$table, nn)
}

#' @templateVar class aareg
#' @template title_desc_glance
#' 
#' @inherit tidy.aareg params examples
#' 
#' @evalRd return_glance("statistic", "p.value", "df", "nobs")
#'
#' @export
#' @seealso [glance()], [survival::aareg()]
#' @family aareg tidiers
#' @family survival tidiers
glance.aareg <- function(x, ...) {
  s <- summary(x)
  chi <- as.numeric(s$chisq)
  df <- length(s$test.statistic) - 1
  
  tibble(
    statistic = chi,
    p.value = as.numeric(1 - stats::pchisq(chi, df)),
    df = df,
    nobs = stats::nobs(x)
  )
}
