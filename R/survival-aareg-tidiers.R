
#' Tidiers for aareg objects
#'
#' These tidy the coefficients of Aalen additive regression objects.
#'
#' @param x an "aareg" object
#' @param ... extra arguments (not used)
#'
#' @template boilerplate
#'
#' @examples
#'
#' if (require("survival", quietly = TRUE)) {
#'     afit <- aareg(Surv(time, status) ~ age + sex + ph.ecog, data=lung,
#'                   dfbeta=TRUE)
#'     summary(afit)
#'     tidy(afit)
#' }
#'
#' @name aareg_tidiers


#' @name aareg_tidiers
#'
#' @return `tidy.aareg` returns one row for each coefficient, with
#' the columns
#'   \item{term}{name of coefficient}
#'   \item{estimate}{estimate of the slope}
#'   \item{statistic}{test statistic for coefficient}
#'   \item{std.error}{standard error of statistic}
#'   \item{robust.se}{robust version of standard error estimate (only when
#'   `x` was called with `dfbeta = TRUE`)}
#'   \item{z}{z score}
#'   \item{p.value}{p-value}
#'
#' @export
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


#' @name aareg_tidiers
#'
#' @return `glance` returns a one-row data frame containing
#'   \item{statistic}{chi-squared statistic}
#'   \item{p.value}{p-value based on chi-squared statistic}
#'   \item{df}{degrees of freedom used by coefficients}
#'
#' @export
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
