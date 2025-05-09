#' @templateVar class mjoint
#' @template title_desc_tidy
#'
#' @param x An `mjoint` object returned from [joineRML::mjoint()].
#' @template param_confint
#' @param component Character specifying whether to tidy the survival or
#'   the longitudinal component of the model. Must be either `"survival"` or
#'   `"longitudinal"`. Defaults to `"survival"`.
#' @param boot_se Optionally a `bootSE` object from [joineRML::bootSE()]. If
#'   specified, calculates confidence intervals via the bootstrap. Defaults to
#'   `NULL`, in which case standard errors are calculated from the
#'   empirical information matrix.
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @examplesIf rlang::is_installed("joineRML")
#'
#' # broom only skips running these examples because the example models take a
#' # while to generate—they should run just fine, though!
#' \dontrun{
#'
#'
#' # load libraries for models and data
#' library(joineRML)
#'
#' # fit a joint model with bivariate longitudinal outcomes
#' data(heart.valve)
#'
#' hvd <- heart.valve[!is.na(heart.valve$log.grad) &
#'   !is.na(heart.valve$log.lvmi) &
#'   heart.valve$num <= 50, ]
#'
#' fit <- mjoint(
#'   formLongFixed = list(
#'     "grad" = log.grad ~ time + sex + hs,
#'     "lvmi" = log.lvmi ~ time + sex
#'   ),
#'   formLongRandom = list(
#'     "grad" = ~ 1 | num,
#'     "lvmi" = ~ time | num
#'   ),
#'   formSurv = Surv(fuyrs, status) ~ age,
#'   data = hvd,
#'   inits = list("gamma" = c(0.11, 1.51, 0.80)),
#'   timeVar = "time"
#' )
#'
#' # extract the survival fixed effects
#' tidy(fit)
#'
#' # extract the longitudinal fixed effects
#' tidy(fit, component = "longitudinal")
#'
#' # extract the survival fixed effects with confidence intervals
#' tidy(fit, ci = TRUE)
#'
#' # extract the survival fixed effects with confidence intervals based
#' # on bootstrapped standard errors
#' bSE <- bootSE(fit, nboot = 5, safe.boot = TRUE)
#' tidy(fit, boot_se = bSE, ci = TRUE)
#'
#' # augment original data with fitted longitudinal values and residuals
#' hvd2 <- augment(fit)
#'
#' # extract model statistics
#' glance(fit)
#' }
#'
#' @export
#' @aliases mjoint_tidiers joinerml_tidiers
#' @family mjoint tidiers
#' @seealso [tidy()], [joineRML::mjoint()], [joineRML::bootSE()]
#'
tidy.mjoint <- function(
  x,
  component = "survival",
  conf.int = FALSE,
  conf.level = 0.95,
  boot_se = NULL,
  ...
) {
  check_ellipses("exponentiate", "tidy", "mjoint", ...)

  component <- rlang::arg_match(component, c("survival", "longitudinal"))
  if (!is.null(boot_se)) {
    if (!inherits(x = boot_se, "bootSE")) {
      cli::cli_abort("{.arg boot_se} must be a {.cls bootSE} object.")
    }
  }

  if (is.null(boot_se)) {
    smr <- summary(x)
  } else {
    smr <- summary(x, bootSE = boot_se)
  }

  if (component == "survival") {
    out <- data.frame(smr$coefs.surv)
  } else {
    out <- data.frame(smr$coefs.long)
  }

  names(out) <- c("estimate", "std.error", "statistic", "p.value")

  out$term <- rownames(out)
  rownames(out) <- NULL
  out <- out[, c(5, 1:4)]

  if (conf.int) {
    cv <- qnorm(1 - (1 - conf.level) / 2)
    out$conf.low <- out$estimate - cv * out$std.error
    out$conf.high <- out$estimate + cv * out$std.error
  }

  # turn out into a tibble object
  as_tibble(out)
}

#' @templateVar class mjoint
#' @template title_desc_augment
#'
#' @inherit tidy.mjoint params examples
#' @template param_data
#'
#' @return A [tibble::tibble()] with one row for each original observation
#'   with addition columns:
#'   \item{.fitted_j_0}{population-level fitted values for the
#'     j-th longitudinal process}
#'   \item{.fitted_j_1}{individuals-level fitted values for the j-th
#'     longitudinal process}
#'   \item{.resid_j_0}{population-level residuals for the j-th
#'     longitudinal process}
#'   \item{.resid_j_1}{individual-level residuals for the j-th
#'     longitudinal process}
#'
#' @details See [joineRML::fitted.mjoint()] and [joineRML::residuals.mjoint()] for
#'   more information on the difference between population-level and
#'   individual-level fitted values and residuals.
#'
#'   If fitting a joint model with a single longitudinal process,
#'   make sure you are using a named `list` to define the formula
#'   for the fixed and random effects of the longitudinal submodel.
#'
#' @export
augment.mjoint <- function(x, data = x$data, ...) {
  check_ellipses("newdata", "augment", "mjoint", ...)

  if (is.null(data)) {
    cli::cli_abort(
      c(
        "{.arg data} argument is {.code NULL}.",
        "i" = "Try specifying {.arg data} manually."
      )
    )
  }

  if (length(data) > 1) {
    if (!do.call(all.equal, data)) {
      cli::cli_abort(
        c(
          "List of {.arg data} extracted from {.arg x} does not include equal
           data frames."
        )
      )
    }
    data <- data[[1]]
  }

  # longitudinal fitted values
  fit0 <- fitted(x, level = 0)
  names(fit0) <- paste0(".fitted_", names(fit0), "_0")
  fit0 <- do.call(cbind.data.frame, fit0)
  fit1 <- fitted(x, level = 1)
  names(fit1) <- paste0(".fitted_", names(fit1), "_1")
  fit1 <- do.call(cbind.data.frame, fit1)

  # longitudinal residuals
  res0 <- residuals(x, level = 0)
  names(res0) <- paste0(".resid_", names(res0), "_0")
  res0 <- do.call(cbind.data.frame, res0)
  res1 <- residuals(x, level = 1)
  names(res1) <- paste0(".resid_", names(res1), "_1")
  res1 <- do.call(cbind.data.frame, res1)

  as_tibble(bind_cols(data, fit0, fit1, res0, res1))
}

#' @templateVar class mjoint
#' @template title_desc_glance
#'
#' @inherit tidy.mjoint params examples
#'
#' @evalRd return_glance("AIC", "BIC", "logLik",
#'   sigma2_j = "The square root of the estimated residual variance for
#'     the j-th longitudinal process"
#' )
#'
#' @export
#' @family mjoint tidiers
#' @seealso [glance()], [joineRML::mjoint()]
glance.mjoint <- function(x, ...) {
  smr <- summary(x)
  out <- as_tibble(t(smr$sigma))
  out$AIC <- smr$AIC
  out$BIC <- smr$BIC
  out$logLik <- smr$logLik
  out
}
