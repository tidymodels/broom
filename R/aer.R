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
#' @details This tidier currently only supports `ivreg`-classed objects
#' outputted by the `AER` package. The `ivreg` package also outputs
#' objects of class `ivreg`, and will be supported in a later release.
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
#' @examplesIf rlang::is_installed("AER")
#'
#' # load libraries for models and data
#' library(AER)
#'
#' # load data
#' data("CigarettesSW", package = "AER")
#'
#' # fit model
#' ivr <- ivreg(
#'   log(packs) ~ income | population,
#'   data = CigarettesSW,
#'   subset = year == "1995"
#' )
#'
#' # summarize model fit with tidiers
#' tidy(ivr)
#' tidy(ivr, conf.int = TRUE)
#' tidy(ivr, conf.int = TRUE, instruments = TRUE)
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
tidy.ivreg <- function(
  x,
  conf.int = FALSE,
  conf.level = 0.95,
  instruments = FALSE,
  ...
) {
  check_ellipses("exponentiate", "tidy", "ivreg", ...)

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

  end_vars <- names(coef(x))[-1] # subtract off the intercept
  d <- summary(x, diagnostics = TRUE)$diagnostics

  # drop last two rows, the Wu-Hausman and Sargan diagnostics
  last_two_rows <- c(nrow(d) - 1, nrow(d))
  d <- as_tibble(d)[-last_two_rows, ]
  tibble::add_column(d, term = end_vars, .before = TRUE) |>
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
#' @details This tidier currently only supports `ivreg`-classed objects
#' outputted by the `AER` package. The `ivreg` package also outputs
#' objects of class `ivreg`, and will be supported in a later release.
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
#' @details This tidier currently only supports `ivreg`-classed objects
#' outputted by the `AER` package. The `ivreg` package also outputs
#' objects of class `ivreg`, and will be supported in a later release.
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

  ret <- as_glance_tibble(
    r.squared = s$r.squared,
    adj.r.squared = s$adj.r.squared,
    sigma = s$sigma,
    statistic = s$waldtest[1],
    p.value = s$waldtest[2],
    df = s$df[1],
    df.residual = df.residual(x),
    nobs = stats::nobs(x),
    na_types = "rrrrriii"
  )

  if (diagnostics) {
    s_ <- summary(x, diagnostics = TRUE)

    diags <- as_glance_tibble(
      statistic.Sargan = s_$diagnostics["Sargan", "statistic"],
      p.value.Sargan = s_$diagnostics["Sargan", "p-value"],
      statistic.Wu.Hausman = s_$diagnostics["Wu-Hausman", "statistic"],
      p.value.Wu.Hausman = s_$diagnostics["Wu-Hausman", "p-value"],
      na_types = "rrrr"
    )

    return(bind_cols(ret, diags))
  }

  ret
}

#' @include null-and-default.R
#' @export
tidy.tobit <- tidy.default
