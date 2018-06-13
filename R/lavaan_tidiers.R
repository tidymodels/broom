#' Tidying methods for lavaan models
#'
#' These methods tidy the coefficients of lavaan CFA and SEM models.
#'
#' @param x An object of class `lavaan`, such as those from [lavaan::cfa()],
#' or [lavaan::sem()]
#' @param ... For `tidy`, additional arguments passed to 
#'   [lavaan::parameterEstimates()]. Ignored for `glance`.`
#' @name lavaan_tidiers
#'
NULL


#' @rdname lavaan_tidiers
#'
#' @param conf.level Confidence level to use. Default is 0.95.
#'
#' @return `tidy` returns a tibble with one row for each estimated parameter
#'   and columns:
#'   \item{term}{The result of paste(lhs, op, rhs)}
#'   \item{op}{The operator in the model syntax (e.g. ~~ for covariances, or ~ for regression parameters)}
#'   \item{estimate}{The parameter estimate (may be standardized)}
#'   \item{std.error}{}
#'   \item{statistic}{The z value returned by [lavaan::parameterEstimates()]
#'   \item{p.value}{}
#'   \item{conf.low}{}
#'   \item{conf.high}{}
#'
#' @export
tidy.lavaan <- function(x, conf.level = 0.95, ...) {
  parameterEstimates(x,
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
      conf.high = ci.upper
    ) %>%
    select(term, op, everything(), -rowname, -lhs, -rhs) %>% 
    as_tibble()
}


#' @rdname lavaan_tidiers
#' 
#' @return `glance` returns statistics measuring model fit. TODO: Document.
#' @export
glance.lavaan <- function(x, ...) {
  x %>%
    fitmeasures(fit.measures = 
                  c("npar",
                    "chisq",
                    "rmsea",
                    "aic",
                    "bic",
                    "cfi",
                    "logl")) %>%
    as_data_frame() %>%
    rownames_to_column(var = "term") %>%
    rename(estimate = value) %>%
    spread("term", "estimate") %>%
    select(
      matches("k^"),
      matches("chisq^"),
      matches("rmsea^"),
      everything()) %>% 
    as_tibble()
}

