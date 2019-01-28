#' @templateVar class ivreg
#' @template title_desc_tidy
#' 
#' @param x An `ivreg` object created by a call to [AER::ivreg()].
#' @template param_confint
#' @template param_exponentiate
#' @template param_unused_dots
#' 
#' @evalRd return_tidy(regression = TRUE)
#' 
#' @examples
#' 
#' library(AER)
#'
#' data("CigarettesSW", package = "AER")
#' ivr <- ivreg(
#'   log(packs) ~ income | population,
#'   data = CigarettesSW,
#'   subset = year == "1995"
#' )
#'
#' summary(ivr)
#'
#' tidy(ivr)
#' tidy(ivr, conf.int = TRUE)
#' tidy(ivr, conf.int = TRUE, exponentiate = TRUE)
#'
#' augment(ivr)
#' augment(ivr, data = CigarettesSW)
#' augment(ivr, newdata = CigarettesSW)
#'
#' glance(ivr)
#' 
#' @export
#' @seealso [tidy()], [AER::ivreg()]
#' @family ivreg tidiers
#' @aliases ivreg_tidiers aer_tidiers
tidy.ivreg <- function(x,
  conf.int = FALSE,
  conf.level = .95, 
  exponentiate = FALSE,
  ...) {
  
  co <- stats::coef(summary(x))
  nn <- c("estimate", "std.error", "statistic", "p.value")
  ret <- fix_data_frame(co, nn[1:ncol(co)])

  process_lm(
    ret,
    x,
    conf.int = conf.int,
    conf.level = conf.level,
    exponentiate = exponentiate
  )
}

#' @templateVar class ivreg
#' @template title_desc_augment
#' 
#' @inherit tidy.ivreg params examples
#' @template param_data
#' @template param_newdata
#' @template param_unused_dots
#' 
#' @evalRd return_augment()
#'
#' @export
#' @seealso [augment()], [AER::ivreg()]
#' @family ivreg tidiers
augment.ivreg <- function(x, data = model.frame(x), newdata = NULL, ...) {
  augment_columns(x, data, newdata)
}

#' @templateVar class ivreg
#' @template title_desc_glance
#' 
#' @inherit tidy.ivreg params examples
#' @param diagnostics Logical indicating whether to include statistics and
#'   p-values for Sargan, Wu-Hausman and weak instrument tests. Defaults to
#'   `FALSE`.
#' 
#' @evalRd return_glance(
#'   "r.squared",
#'   "adj.r.squared",
#'   "sigma",
#'   "df",
#'   "df.residual",
#'   "nobs",
#'   "statistic.Sargan",
#'   "p.value.Sargan",
#'   "statistic.Wu.Hausman",
#'   "p.value.Wu.Hausman",
#'   "statistic.weakinst",
#'   "p.value.weakinst",
#'   statistic = "Wald test statistic.",
#'   p.value = "P-value for the Wald test."
#' )
#'
#' @export
#' @seealso [glance()], [AER::ivreg()]
#' @family ivreg tidiers
glance.ivreg <- function(x, diagnostics = FALSE, ...) {
  
  s <- summary(x, diagnostics = diagnostics)
  
  ret <- with(s, 
    tibble(
      r.squared = r.squared,
      adj.r.squared = adj.r.squared,
      sigma = sigma,
      statistic = waldtest[1],
      p.value = waldtest[2],
      df = df[1]
    )
  )
  ret$df.residual <- df.residual(x)
  ret$nobs <- stats::nobs(x)
  
  if (diagnostics) {
    diag <- with(s,
      tibble(
        statistic.Sargan = diagnostics["Sargan", "statistic"],
        p.value.Sargan = diagnostics["Sargan", "p-value"],
        statistic.Wu.Hausman = diagnostics["Wu-Hausman", "statistic"],
        p.value.Wu.Hausman = diagnostics["Wu-Hausman", "p-value"],
        statistic.weakinst = diagnostics["Weak instruments", "statistic"],
        p.value.weakinst = diagnostics["Weak instruments", "p-value"]
      )
    )
    ret <- bind_cols(ret, diag)
  }

  as_tibble(ret, rownames = NULL)
  
}
