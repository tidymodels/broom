#' @templateVar class coeftest
#' @template title_desc_tidy
#'
#' @param x A `coeftest` object returned from [lmtest::coeftest()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @examplesIf rlang::is_installed("lmtest")
#'
#' # load libraries for models and data
#' library(lmtest)
#'
#' m <- lm(dist ~ speed, data = cars)
#'
#' coeftest(m)
#' tidy(coeftest(m))
#' tidy(coeftest(m, conf.int = TRUE))
#'
#' # a very common workflow is to combine lmtest::coeftest with alternate
#' # variance-covariance matrices via the sandwich package. The lmtest
#' # tidiers support this workflow too, enabling you to adjust the standard
#' # errors of your tidied models on the fly.
#' library(sandwich)
#'
#' # "HC3" (default) robust SEs
#' tidy(coeftest(m, vcov = vcovHC))
#'
#' # "HC2" robust SEs
#' tidy(coeftest(m, vcov = vcovHC, type = "HC2"))
#'
#' # N-W HAC robust SEs
#' tidy(coeftest(m, vcov = NeweyWest))
#'
#' # the columns of the returned tibble for glance.coeftest() will vary
#' # depending on whether the coeftest object retains the underlying model.
#' # Users can control this with the "save = TRUE" argument of coeftest().
#' glance(coeftest(m))
#' glance(coeftest(m, save = TRUE))
#'
#' @export
#' @seealso [tidy()], [lmtest::coeftest()]
#' @aliases lmtest_tidiers coeftest_tidiers
#' @family coeftest tidiers
tidy.coeftest <- function(x, conf.int = FALSE, conf.level = .95, ...) {
  check_ellipses("exponentiate", "tidy", "coeftest", ...)

  co <- as.data.frame(unclass(x))
  ret <- as_tidy_tibble(
    co,
    new_names = c("estimate", "std.error", "statistic", "p.value")[1:ncol(co)]
  )

  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)

    # handle one-dimensional case (#1227)
    if (identical(dim(ci), c(1L, 3L))) {
      ci[["term"]] <- rownames(x)
    }

    ret <- dplyr::left_join(ret, ci, by = "term")
  }
  ret
}


#' @templateVar class coeftest
#' @template title_desc_glance
#'
#' @inherit tidy.coeftest params examples
#'
#' @evalRd return_glance(
#'   "r.squared",
#'   "adj.r.squared",
#'   "sigma",
#'   "statistic",
#'   "p.value",
#'   "df",
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "deviance",
#'   "df.residual",
#'   "nobs"
#' )
#' @note Because of the way that lmtest::coeftest() retains information about
#' the underlying model object, the returned columns for glance.coeftest() will
#' vary depending on the arguments. Specifically, four columns are returned
#' regardless: "Loglik", "AIC", "BIC", and "nobs". Users can obtain additional
#' columns (e.g. "r.squared", "df") by invoking the "save = TRUE" argument as
#' part of lmtest::coeftest(). See examples.
#'
#' As an aside, goodness-of-fit measures such as R-squared are unaffected by the
#' presence of heteroskedasticity. For further discussion see, e.g. chapter 8.1
#' of Wooldridge (2016).
#' @references Wooldridge, Jeffrey M. (2016) \cite{Introductory econometrics: A
#' modern approach.} (6th edition). Nelson Education.
#'
#'
#' @export
#' @seealso [glance()], [lmtest::coeftest()]
#' @family coeftest_tidiers
glance.coeftest <- function(x, ...) {
  # check whether the underlying model object was saved as an attribute of the
  # coeftest object; i.e. with coeftest(x, save = TRUE). If so, we'll use that
  # for our glance function.
  if (!is.null(attr(x, "object"))) {
    ret <- glance(attr(x, "object"), ...)
  } else {
    # If model has not been saved, extract from retained attributes and notify user.
    ret <- tibble::tibble(
      logLik = sprintf("%.3f", logLik(x)), AIC = AIC(x),
      BIC = BIC(x), nobs = nobs(x)
    )
    cli::cli_inform(
      c(
        "Original model not retained as part of coeftest object.",
        "i" = "For additional model summary information (r.squared, df, etc.),
           consider passing {.fn glance.coeftest} an object where the 
           underlying model has been saved, i.e. 
           {.code lmtest::coeftest(..., save = TRUE)}."
      ),
      .frequency = "once",
      .frequency_id = "glance_coeftest_inform"
    )
  }

  ret
}
