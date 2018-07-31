#' @templateVar class aareg
#' @template title_desc_tidy
#'
#' @param x An `aareg` object returned from [survival::aareg()].
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with one row for each coefficient and columns:
#' 
#'   \item{term}{name of coefficient}
#'   \item{estimate}{estimate of the slope}
#'   \item{statistic}{test statistic for coefficient}
#'   \item{std.error}{standard error of statistic}
#'   \item{robust.se}{robust version of standard error estimate (only when
#'     `x` was called with `dfbeta = TRUE`)}
#'   \item{z}{z score}
#'   \item{p.value}{p-value}
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
#' @inheritParams tidy.aareg
#' 
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{statistic}{chi-squared statistic}
#'   \item{p.value}{p-value based on chi-squared statistic}
#'   \item{df}{degrees of freedom used by coefficients}
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
    df = df
  )
}
