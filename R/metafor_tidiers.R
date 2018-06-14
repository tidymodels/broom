#' Tidying methods for meta-analysis models (via the metafor package)
#'
#' These methods include a tidy and a glance for a meta-analytic fixed- and
#' random/mixed-effects models with or without moderators via linear
#' (mixed-effects) models. See the documentation of the metafor-package
#' for more details on these models.
#'
#' @template boilerplate
#'
#' @name metafor_tidiers
#'
#' @param x model object returned by [metafor::rma()]
#' @param ... Additional arguments (not used).
#'
NULL

#' @rdname metafor_tidiers
#'
#' @return `tidy` returns a [tibble::tibble()` frame with one row for each
#'   coefficient. The columns are the same as for [broom::tidy.lm()]
#'
#' @export
#' @examples
#'
#' TODO
#'
tidy.rma <- function(x, ...) {
  with(
    x,
    tibble(
      term = TODO,
      estimate = b,
      std.error = se,
      statistic = zval,
      p.value = pval,
      conf.low = ci.lb,
      conf.high = ci.ub
    )
  )
}
# tidy.rma(a)
# tidy.rma(fit_AR_3)
# tidy.rma(fit_AR_3)


#' @rdname metafor_tidiers
#'
#' @return `glance`` returns a tibble with columns:
#'
#' * tau2 - estimated amount of (residual) heterogeneity. Always 0 when method="FE".
#' * se.tau2 - estimated standard error of the estimated amount of (residual) heterogeneity.
#' * k - number of outcomes included in the model fitting.
#' * p - number of coefficients in the model (including the intercept).
#' * m - number of coefficients included in the omnibus test of coefficients.
#' * QE - test statistic for the test of (residual) heterogeneity.
#' * QEp - p-value for the test of (residual) heterogeneity.
#' * QM - test statistic for the omnibus test of coefficients.
#' * QMp - p-value for the omnibus test of coefficients.
#' * I2 - value of I^2. See print.rma.uni for more details.
#' * H2 - value of H^2. See print.rma.uni for more details.
#' * R2 - value of R^2. See print.rma.uni for more details.
#' * int.only - logical that indicates whether the model is an intercept-only model.
#'
#' @export
#' @examples
#'
#' TODO
glance.rma <- function(x, ...) {
  with(
    x,
    tibble(
      tau2 = tau2,
      se.tau2 = se.tau2,
      k = k,
      p = p,
      m = m,
      QE = QE,
      QEp = QEp,
      QM = QM,
      QMp = QMp,
      I2 = I2,
      H2 = H2,
      # R2 = R2,
      int.only = int.only
    )
  )
}
