#' @templateVar class lavaan
#' @template title_desc_tidy
#' 
#' @param x A `lavaan` object, such as those return from [lavaan::cfa()],
#'   and [lavaan::sem()].
#' 
#' @template param_confint
#' @param ... Additional arguments passed to [lavaan::parameterEstimates()].
#'   **Cautionary note**: Misspecified arguments may be silently ignored.
#'
#' @return A [tibble::tibble] with one row for each estimated parameter and
#'   columns:
#'  
#'   \item{term}{The result of paste(lhs, op, rhs)}
#'   \item{op}{The operator in the model syntax (e.g. `~~` for covariances, or
#'     `~` for regression parameters)}
#'   \item{group}{The group (if specified) in the lavaan model}
#'   \item{estimate}{The parameter estimate (may be standardized)}
#'   \item{std.error}{}
#'   \item{statistic}{The z value returned by [lavaan::parameterEstimates()]}
#'   \item{p.value}{}
#'   \item{conf.low}{}
#'   \item{conf.high}{}
#'   \item{std.lv}{Standardized estimates based on the variances of the
#'     (continuous) latent variables only}
#'   \item{std.all}{Standardized estimates based on both the variances
#'     of both (continuous) observed and latent variables.}
#'   \item{std.nox}{Standardized estimates based on both the variances
#'     of both (continuous) observed and latent variables, but not the
#'     variances of exogenous covariates.}
#'   
#' @examples
#' 
#' if (require("lavaan")) {
#' 
#'  library(lavaan)
#'  
#'  cfa.fit <- cfa('F =~ x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9',
#'                 data = HolzingerSwineford1939, group = "school")
#'  tidy(cfa.fit)
#' }
#' 
#' @export
#' @aliases lavaan_tidiers sem_tidiers cfa_tidiers
#' @family lavaan tidiers
#' @seealso [tidy()], [lavaan::cfa()], [lavaan::sem()], 
#'   [lavaan::parameterEstimates()]
tidy.lavaan <- function(x, conf.int = TRUE, conf.level = 0.95, ...) {
  lavaan::parameterEstimates(x,
    ci = conf.int,
    level = conf.level,
    standardized = TRUE,
    ...
  ) %>%
    as_tibble() %>%
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


#' @templateVar class lavaan
#' @template title_desc_glance
#' 
#' @inheritParams tidy.lavaan
#' @template param_unused_dots
#' 
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{chisq}{Model chi squared}
#'   \item{npar}{Number of parameters in the model}
#'   \item{rmsea}{Root mean square error of approximation}
#'   \item{rmsea.conf.high}{95 percent upper bound on RMSEA}
#'   \item{srmr}{Standardised root mean residual}
#'   \item{agfi}{Adjusted goodness of fit}
#'   \item{cfi}{Comparative fit index}
#'   \item{tli}{Tucker Lewis index}
#'   \item{aic}{Akaike information criterion}
#'   \item{bic}{Bayesian information criterion}
#'   \item{ngroups}{Number of groups in model}
#'   \item{nobs}{Number of observations included}
#'   \item{norig}{Number of observation in the original dataset}
#'   \item{nexcluded}{Number of excluded observations}
#'   \item{converged}{Logical - Did the model converge}
#'   \item{estimator}{Estimator used}
#'   \item{missing_method}{Method for eliminating missing data}
#'
#' For further recommendations on reporting SEM and CFA models see Schreiber, J. B. (2017). Update to core reporting practices in structural equation modeling. Research in Social and Administrative Pharmacy, 13(3), 634-643. https://doi.org/10.1016/j.sapharm.2016.06.006
#'   
#' @examples
#'
#' if (require("lavaan", quietly = TRUE)) {
#' 
#'  library(lavaan)
#'
#'  cfa.fit <- cfa(
#'    'F =~ x1 + x2 + x3 + x4 + x5',
#'    data = HolzingerSwineford1939, group = "school"
#'  )
#'  glance(cfa.fit)
#'
#' }
#'
#' @export
#' @family lavaan tidiers
#' @seealso [glance()], [lavaan::cfa()], [lavaan::sem()],
#'   [lavaan::fitmeasures()]
#' 
glance.lavaan <- function(x, ...) {
  x %>%
    lavaan::fitmeasures(
      fit.measures =
        c(
          "npar",
          "chisq",
          "rmsea",
          "rmsea.ci.upper",
          "srmr",
          "aic",
          "bic",
          "tli",
          "agfi",
          "cfi"
        )
    ) %>%
    as_tibble() %>%
    tibble::rownames_to_column(var = "term") %>%
    spread(., term, value) %>%
    bind_cols(
      tibble(
        converged = x@Fit@converged,
        estimator = x@Options$estimator,
        ngroups = x@Data@ngroups,
        missing_method = x@Data@missing,
        nobs = sum(purrr::accumulate(x@Data@nobs, sum)),
        norig = sum(purrr::accumulate(x@Data@norig, sum)),
        nexcluded = norig - nobs
      )
    ) %>%
    rename(rmsea.conf.high = rmsea.ci.upper)
}
