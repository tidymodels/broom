#' Tidying methods for lavaan models
#'
#' These methods tidy the coefficients of lavaan CFA and SEM models.
#'
#' @param x An object of class \code{lavaan}, such as those from \code{cfa},
#' or \code{sem}
#'
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#'
#' @name lavaan_tidiers
#'
NULL


#' @rdname lavaan_tidiers
#'
#' @param conf.level confidence level for CI
#' @param ... Other parameters passed to lavaan::parameterEstimates
#'
#' @return \code{tidy} returns one row for each estimated parameter
#' It contains the columns
#'   \item{term}{The result of paste(lhs, op, rhs)}
#'   \item{op}{The operator in the model syntax (e.g. ~~ for covariances, or ~ for regression parameters)}
#'   \item{estimate}{The parameter estimate (may be standardized)}
#'   \item{std.error}{}
#'   \item{statistic}{The z value returned by lavaan::parameterEstimates}
#'   \item{p.value}{}
#'   \item{conf.low}{}
#'   \item{conf.high}{}
#'
#' @import dplyr
#'
#' @export
tidy.lavaan <- function(x,
                        conf.level = 0.95,
                        ...) {
  tidyframe <- parameterEstimates(x,
    ci = TRUE,
    level = conf.level,
    standardized = TRUE,
    ...
  ) %>%
    as_data_frame() %>%
    tibble::rownames_to_column() %>%
    mutate(term = paste(lhs, op, rhs)) %>%
    rename(
      estimate = est,
      std.error = se,
      p.value = pvalue,
      statistic = z,
      conf.low = ci.lower,
      conf.hi = ci.upper
    ) %>%
    select(term, op, everything(), -rowname, -lhs, -rhs)
  return(tidyframe)
}


#' @rdname lavaan_tidiers
#'
#' @param long If long=FALSE, return a single row with columns per-fit-statistic.
#' @param ... extra arguments (not used)
#'
#' @return \code{glance} returns the following fit statistics.
#'
#' @export
glance.lavaan <- function(m, long=T, fit.measures = c("npar", "chisq", "rmsea", "aic", "bic", "cfi", "logl"), ...) {
  gl <- m %>%
    fitmeasures(fit.measures = fit.measures) %>%
    as_data_frame() %>%
    rownames_to_column(var = "term") %>%
    rename(estimate = value) %>%
    spread("term", "estimate") %>%
    select(matches("k^"), matches("chisq^"), matches("rmsea^"), everything())

  if (long == T) {
    gl <- gl %>%
      gather(term, estimate)
  }
  return(gl)
}


#' @export
augment.lavaan <- function(...) {
    warning("Not yet implemented")
}
    

