#' @templateVar class mjoint
#' @template title_desc_tidy
#' 
#' @param x An `mjoint` object returned from [joineRML::mjoint()].
#' @template param_confint
#' @param component Character specifying whether to tidy the survival or
#'   the longitudinal component of the model. Must be either `"survival"` or
#'   `"longitudinal"`. Defaults to `"survival"`.
#' @param boot_se Optionally a `bootSE` object from [joineRML::bootSE()]. If
#'   specified, calcalutes confidence intervals via the bootstrap. Defaults to
#'   `NULL`, in which case standard errors are calculated from the 
#'   empirical information matrix.
#' @template param_unused_dots
#'
#' @template return_tidy_regression
#'
#' @examples
#' \dontrun{
#' # Fit a joint model with bivariate longitudinal outcomes
#' library(joineRML)
#' data(heart.valve)
#' hvd <- heart.valve[!is.na(heart.valve$log.grad) &
#'                        !is.na(heart.valve$log.lvmi) &
#'                        heart.valve$num <= 50, ]
#' fit <- mjoint(
#'     formLongFixed = list(
#'         "grad" = log.grad ~ time + sex + hs,
#'         "lvmi" = log.lvmi ~ time + sex
#'     ),
#'     formLongRandom = list(
#'         "grad" = ~ 1 | num,
#'         "lvmi" = ~ time | num
#'     ),
#'     formSurv = Surv(fuyrs, status) ~ age,
#'     data = hvd,
#'     inits = list("gamma" = c(0.11, 1.51, 0.80)),
#'     timeVar = "time"
#' )
#'
#' # Extract the survival fixed effects
#' tidy(fit)
#'
#' # Extract the longitudinal fixed effects
#' tidy(fit, component = "longitudinal")
#'
#' # Extract the survival fixed effects with confidence intervals
#' tidy(fit, ci = TRUE)
#'
#' # Extract the survival fixed effects with confidence intervals based
#' # on bootstrapped standard errors
#' bSE <- bootSE(fit, nboot = 5, safe.boot = TRUE)
#' tidy(fit, boot_se = bSE, ci = TRUE)
#'
#' # Augment original data with fitted longitudinal values and residuals
#' hvd2 <- augment(fit)
#'
#' # Extract model statistics
#' glance(fit)
#' }
#'
#' @export
#' @aliases mjoint_tidiers joinerml_tidiers
#' @family mjoint tidiers
#' @seealso [tidy()], [joineRML::mjoint()], [joineRML::bootSE()]
#' 
tidy.mjoint <- function(x, component = "survival", conf.int = FALSE,
                        conf.level = 0.95,  boot_se = NULL, ...) {
  component <- match.arg(component, c("survival", "longitudinal"))
  if (!is.null(boot_se)) {
    if (!inherits(x = boot_se, "bootSE")) 
      stop("`boot_se` argument must be a `bootSE` object.", call. = FALSE)
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
#' @inheritParams tidy.mjoint
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
#' more information on the difference between population-level and
#' individual-level fitted values and residuals.
#'
#' If fitting a joint model with a single longitudinal process,
#'   make sure you are using a named `list` to define the formula
#'   for the fixed and random effects of the longitudinal submodel.
#'
#' @export
augment.mjoint <- function(x, data = x$data, ...) {
  
  if (is.null(data)) {
    stop(
      "`data` argument is NULL. Try specifying `data` manually.",
      call. = FALSE
    )
  }

  if (length(data) > 1) {
    if (!do.call(all.equal, data)) {
      stop("List of 'data' extracted from 'x' does not",
           "include equal data frames.")
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
#' @inheritParams tidy.mjoint
#'
#' @return A one-row [tibble::tibble] with columns:
#'   \item{sigma2_j}{the square root of the estimated residual variance for
#'     the j-th longitudinal process}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'   \item{logLik}{the data's log-likelihood under the model}
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
