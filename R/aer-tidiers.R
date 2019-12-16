#' @templateVar class ivreg
#' @template title_desc_tidy
#'
#' @param x An `ivreg` object created by a call to [AER::ivreg()].
#' @template param_confint
#' @param instruments Logical indicating whether to return
#'   coefficients from the second-stage or diagnostics tests for
#'   each endogenous regressor (F-statistics). Defaults to `FALSE`.
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "statistic.Sargan",
#'   "p.value.Sargan",
#'   "statistic.Wu.Hausman",
#'   "p.value.Wu.Hausman",
#'   "statistic.weakinst",
#'   "p.value.weakinst",
#'   regression = TRUE
#' )
#'
#' @examples
#'
#' library(AER)
#'
#' data("CigarettesSW", package = "AER")
#'
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
#' tidy(ivr, conf.int = TRUE, instruments = TRUE)
#'
#' augment(ivr)
#' augment(ivr, data = CigarettesSW)
#' augment(ivr, newdata = CigarettesSW)
#'
#' glance(ivr)
#' @export
#' @seealso [tidy()], [AER::ivreg()]
#' @family ivreg tidiers
#' @aliases ivreg_tidiers aer_tidiers
tidy.ivreg <- function(x,
                       conf.int = FALSE,
                       conf.level = 0.95,
                       instruments = FALSE,
                       ...) {

  # TODO: documentation on when you get what needs to be updated !!!

  # case 1: user does not ask for instruments
  
  if (!instruments) {
    
    ret <- as_tibble(summary(x)$coefficients, rownames = "term")
    colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")
    
    if (conf.int) {
      ci <- broom_confint_terms(x, level = conf.level)
      ret <- dplyr::left_join(ret, ci, by = "term")
    }
    
    return(ret)
  }

  # case 2: user asks for instruments
  
  end_vars <- names(coef(x))[-1]  # subtract off the intercept
  d <- summary(x, diagnostics = TRUE)$diagnostics
  
  # drop last two rows, the Wu-Hausman and Sargan diagnostics
  last_two_rows <- c(nrow(d) - 1, nrow(d))
  d <- as_tibble(d)[-last_two_rows, ]
  tibble::add_column(d, term = end_vars, .before = TRUE) %>% 
    rename2("p.value" = "p-value", "num.df" = "df1", "den.df" = "df2")
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
#' @param diagnostics Logical indicating whether or not to return the
#'   Wu-Hausman and Sargan diagnostic information.
#'
#' @note Beginning 0.7.0, `glance.ivreg` returns statistics for the
#' Wu-Hausman test for endogeneity and the Sargan test of
#' overidentifying restrictions. Sargan test values are returned as `NA`
#' if the number of instruments is not greater than the number of
#' endogenous regressors.
#'
#' @evalRd return_glance(
#'   "r.squared",
#'   "adj.r.squared",
#'   "sigma",
#'   "df",
#'   "df.residual",
#'   "nobs",
#'   statistic = "Wald test statistic.",
#'   p.value = "P-value for the Wald test."
#' )
#'
#' @export
#' @seealso [glance()], [AER::ivreg()]
#' @family ivreg tidiers
glance.ivreg <- function(x, diagnostics = FALSE, ...) {
  s <- summary(x, diagnostics = FALSE)

  ret <- with(
    s,
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
    ret <- with(
      summary(x, diagnostics = TRUE),
      tibble(
        statistic.Sargan = diagnostics["Sargan", "statistic"],
        p.value.Sargan = diagnostics["Sargan", "p-value"],
        statistic.Wu.Hausman = diagnostics["Wu-Hausman", "statistic"],
        p.value.Wu.Hausman = diagnostics["Wu-Hausman", "p-value"]
      )
    )
  }

  as_tibble(ret, rownames = NULL)
}

#' @include null-and-default-tidiers.R
#' @export
tidy.tobit <- tidy.default
