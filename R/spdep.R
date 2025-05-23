#' Tidying methods for spatially autoregressive models
#'
#' These methods tidy the coefficients of spatial autoregression
#' models generated by functions in the `spatialreg` package.
#'
#' @param x An object returned from [spatialreg::lagsarlm()]
#' or [spatialreg::errorsarlm()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
# skip running examples - occasionally over CRAN check time limit
#' @examplesIf rlang::is_installed(c("spdep", "spatialreg")) && identical(Sys.getenv("NOT_CRAN"), "true")
#'
#'
#' # load libraries for models and data
#' library(spatialreg)
#' library(spdep)
#'
#' # load data
#' data(oldcol, package = "spdep")
#'
#' listw <- nb2listw(COL.nb, style = "W")
#'
#' # fit model
#' crime_sar <-
#'   lagsarlm(CRIME ~ INC + HOVAL,
#'     data = COL.OLD,
#'     listw = listw,
#'     method = "eigen"
#'   )
#'
#' # summarize model fit with tidiers
#' tidy(crime_sar)
#' tidy(crime_sar, conf.int = TRUE)
#' glance(crime_sar)
#' augment(crime_sar)
#'
#' # fit another model
#' crime_sem <- errorsarlm(CRIME ~ INC + HOVAL, data = COL.OLD, listw)
#'
#' # summarize model fit with tidiers
#' tidy(crime_sem)
#' tidy(crime_sem, conf.int = TRUE)
#' glance(crime_sem)
#' augment(crime_sem)
#'
#' # fit another model
#' crime_sac <- sacsarlm(CRIME ~ INC + HOVAL, data = COL.OLD, listw)
#'
#' # summarize model fit with tidiers
#' tidy(crime_sac)
#' tidy(crime_sac, conf.int = TRUE)
#' glance(crime_sac)
#' augment(crime_sac)
#'
#' @aliases spatialreg_tidiers
#' @export
#' @family spatialreg tidiers
#' @seealso [tidy()], [spatialreg::lagsarlm()], [spatialreg::errorsarlm()],
#' [spatialreg::sacsarlm()]
tidy.sarlm <- function(x, conf.int = FALSE, conf.level = .95, ...) {
  check_ellipses("exponentiate", "tidy", "sarlm", ...)

  # construct parameter table
  s <- summary(x)
  ret <- as_tidy_tibble(
    coef(s),
    new_names = c("estimate", "std.error", "statistic", "p.value")
  )

  # append spatial autoregression coefficient to parameter table if it exists
  if (!is.null(s$rho)) {
    rho <- tibble(
      term = "rho",
      estimate = as.numeric(s$rho),
      std.error = as.numeric(s$rho.se),
      statistic = as.numeric(estimate / std.error),
      p.value = as.numeric(2 * (1 - pnorm(abs(statistic))))
    )
    ret <- bind_rows(rho, ret)
  }

  # append spatial error coefficient to parameter table if it exists
  if (!is.null(s$lambda)) {
    lambda <- tibble(
      term = "lambda",
      estimate = as.numeric(s$lambda),
      std.error = as.numeric(s$lambda.se),
      statistic = as.numeric(estimate / std.error),
      p.value = as.numeric(2 * (1 - pnorm(abs(statistic))))
    )
    ret <- bind_rows(ret, lambda)
  }

  # Calculate confidence interval
  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }

  ret
}

#' @templateVar class spatialreg
#' @template title_desc_augment
#'
#' @evalRd return_augment(".fitted", ".resid")
#'
#' @inherit tidy.sarlm params examples
#' @param data Ignored, but included for internal consistency. See the details
#' below.
#'
#' @details
#' The predict method for sarlm objects assumes that the response is
#' known. See ?predict.sarlm for more discussion. As a result, since the
#' original data can be recovered from the fit object, this method
#' currently does not take in `data` or `newdata` arguments.
#'
#' @export
#' @seealso [augment()]
#' @family spatialreg tidiers
augment.sarlm <- function(x, data = x$X, ...) {
  observed_name <- all.vars(x$call$formula)[1]

  reg <- x$X |>
    as_augment_tibble() |>
    dplyr::select(-.rownames) |>
    dplyr::mutate(
      !!observed_name := x$y,
      .fitted = x$fitted.values,
      .resid = x$residuals
    )

  reg
}


#' @templateVar class spatialreg
#' @template title_desc_glance
#'
#' @inherit tidy.sarlm params examples
#'
#' @evalRd return_glance(
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "deviance",
#'   "logLik",
#'   "nobs"
#' )
#' @export
#' @family spatialreg tidiers
#' @seealso [glance()], [spatialreg::lagsarlm()], [spatialreg::errorsarlm()],
#' [spatialreg::sacsarlm()]
glance.sarlm <- function(x, ...) {
  res <- as_glance_tibble(
    # Using Pseudo R squared.
    r.squared = stats::cor(x$fitted.values, x$y)^2,
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    deviance = stats::deviance(x),
    logLik = as.numeric(x$LL),
    nobs = length(x$fitted.values),
    na_types = "rrrrri"
  )

  res
}

# re-export each of them following the change in class sarlm -> Sarlm --------

#' @export
#' @family spatialreg tidiers
tidy.Sarlm <- tidy.sarlm

#' @export
#' @family spatialreg tidiers
glance.Sarlm <- glance.sarlm

#' @export
#' @family spatialreg tidiers
augment.Sarlm <- augment.sarlm
