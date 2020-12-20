#' @templateVar class Rchoice
#' @template title_desc_tidy
#'
#' @param x A `Rchoice` object returned from [Rchoice::Rchoice()].
#' @template param_unused_dots
#' @template param_confint
#'
#' @evalRd return_tidy(regression = TRUE)
#' 
#' @details The `Rchoice` package provides "an implementation of simulated
#' maximum likelihood method for the estimation of Binary (Probit and Logit),
#' Ordered (Probit and Logit) and Poisson models with random parameters for
#' cross-sectional and longitudinal data."
#'
#' @examples
#' library(Rchoice)
#'
#' mod <- Rchoice(vs ~ mpg + hp + factor(cyl),
#'                data = mtcars,
#'                family = binomial("probit"))
#' tidy(mod)
#' glance(mod)
#' @export
#' @aliases rchoice_tidiers
#' @family rchoice tidiers
#' @seealso [tidy()], [Rchoice::Rchoice()]
tidy.Rchoice <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
  s <- summary(x, ...)

  ret <- 
    as_tidy_tibble(
      s$CoefTable, 
      c("estimate", "std.error", "statistic", "p.value")
    )
  
  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }

  ret
}


#' @templateVar class Rchoice
#' @template title_desc_glance
#'
#' @inherit tidy.Rchoice params examples
#'
#' @evalRd return_glance(
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "df",
#'   "nobs"
#' )
#'
#' @export
glance.Rchoice <- function(x, ...) {
  s <- Rchoice::getSummary.Rchoice(x, ...)
  
  ret <- as_glance_tibble(
    logLik = s$sumstat['logLik'],
    AIC    = s$sumstat['AIC'],
    BIC    = s$sumstat['BIC'],
    df     = s$sumstat['df'],
    nobs   = s$sumstat['N'],
    na_types = "rrrii")
  ret
}
