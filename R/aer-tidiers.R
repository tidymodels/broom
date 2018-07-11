#' @templateVar class ivreg
#' @template title_desc_tidy
#' 
#' @param x An `ivreg` object created by a call to [AER::ivreg()].
#' @template param_confint
#' @template param_exponentiate
#' @template param_unused_dots
#' 
#' @template return_tidy_regression
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
#' @template return_augment_columns
#'
#' @export
#' @seealso [augment()], [AER::ivreg()]
#' @family ivreg tidiers
augment.ivreg <- function(x, data = model.frame(x), newdata, ...) {
  augment_columns(x, data, newdata)
}

#' @templateVar class ivreg
#' @template title_desc_glance
#' 
#' @inherit tidy.ivreg params examples
#' @param diagnostics Logical indicating whether to include statistics and
#'   p-values for Sargan, Wu-Hausman and weak instrument tests. Defaults to
#'   `FALSE`.
#' @template param_unused_dots
#'
#' @return A one-row tibble with columns
#'   \item{r.squared}{The percent of variance explained by the model}
#'   \item{adj.r.squared}{r.squared adjusted based on the degrees of freedom}
#'   \item{sigma}{The square root of the estimated residual variance}
#'   \item{statistic}{Wald test statistic}
#'   \item{p.value}{p-value from the Wald test}
#'   \item{df}{Degrees of freedom used by the coefficients}
#'   \item{df.residual}{residual degrees of freedom}
#'   
#' If `diagnostics = TRUE`, will also return the following columns:
#'   \item{statistic.Sargan}{Statistic for Sargan test}
#'   \item{p.value.Sargan}{P-value for Sargan test}
#'   \item{statistic.Wu.Hausman}{Statistic for Wu-Hausman test}
#'   \item{p.value.Wu.Hausman}{P-value for Wu-Hausman test}
#'   \item{statistic.weakinst}{Statistic for Wu-Hausman test}
#'   \item{p.value.weakinst}{P-value for weak instruments test}
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
  
  finish_glance(ret, x)
}
