#' Tidying methods for joint models for time-to-event data and multivariate longitudinal data
#'
#' These methods tidy the coefficients of joint models for time-to-event data and multivariate longitudinal data of the \code{mjoint} class from the \code{joineRML} package.
#'
#' @param x An object of class \code{mjoint}.
#'
#' @return All tidying methods return a \code{data.frame} without rownames. The structure depends on the method chosen.
#'
#' @name mjoint_tidiers
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
#' # Extract the survival fixed effects with confidence intervals based on bootstrapped standard errors
#' bSE <- bootSE(fit, nboot = 5, safe.boot = TRUE)
#' tidy(fit, bootSE = bSE, ci = TRUE)
#'
#' # Augment original data with fitted longitudinal values and residuals
#' hvd2 <- augment(fit)
#'
#' # Extract model statistics
#' glance(fit)
#' }
#'
#' @rdname mjoint_tidiers
#'
#' @param component Either \code{survival} (the survival component of the model, default) or \code{longitudinal} (the longitudinal component).
#'
#' @param bootSE An object of class \code{bootSE} for the corresponding model. If \code{bootSE = NULL} (the default), the function will use approximate standard error estimates calculated from the empirical information matrix.
#'
#' @param ci Include (\code{1 - level})\% confidence intervals? Defaults to \code{FALSE}.
#'
#' @param level The confidence level required.
#'
#' @return \code{tidy} returns one row for each estimated fixed effect depending on the \code{component} parameter. It contains the following  columns:
#'   \item{term}{The term being estimated}
#'   \item{estimate}{Estimated value}
#'   \item{std.error}{Standard error}
#'   \item{statistic}{Z-statistic}
#'   \item{p.value}{P-value computed from Z-statistic}
#'   \item{conf.low}{The low end of a confidence interval on \code{estimate}, if required}
#'   \item{conf.high}{The high end of a confidence interval on \code{estimate}, if required}
#'
#' @export
tidy.mjoint <- function(x, component = "survival", bootSE = NULL, ci = FALSE, level = 0.95, ...) {
  component <- match.arg(component, c("survival", "longitudinal"))
  if (!is.null(bootSE)) {
    if (!inherits(x = bootSE, what = "bootSE")) stop("'bootSE' object not of class 'bootSE'")
  }

  # make summary object
  if (is.null(bootSE)) {
    smr <- summary(x)
  } else {
    smr <- summary(x, bootSE = bootSE)
  }

  # extract appropriate component
  if (component == "survival") {
    out <- data.frame(smr$coefs.surv)
  } else {
    out <- data.frame(smr$coefs.long)
  }

  # fix names
  names(out) <- c("estimate", "std.error", "statistic", "p.value")

  # turn rownames into a 'term' column
  out$term <- rownames(out)
  rownames(out) <- NULL
  out <- out[, c(5, 1:4)]

  # make confidence intervals (if required)
  if (ci) {
    cv <- qnorm(1 - (1 - level) / 2)
    out$conf.low <- out$estimate - cv * out$std.error
    out$conf.high <- out$estimate + cv * out$std.error
  }

  # turn out into a tibble object
  out <- tibble::as_tibble(out)

  # return tidy object
  return(out)
}

#' @rdname mjoint_tidiers
#'
#' @param data Original data this was fitted on, in a list (e.g. \code{list(data)}). This will be extracted from \code{x} if not given.
#'
#' @return \code{augment} returns one row for each original observation, with columns (each prepended by a .) added. Included are the columns:
#'   \item{.fitted_j_0}{population-level fitted values for the j-th longitudinal process}
#'   \item{.fitted_j_1}{individuals-level fitted values for the j-th longitudinal process}
#'   \item{.resid_j_0}{population-level residuals for the j-th longitudinal process}
#'   \item{.resid_j_1}{individual-level residuals for the j-th longitudinal process}
#' See \code{\link[joineRML]{fitted.mjoint}} and \code{\link[joineRML]{residuals.mjoint}} for more information on the difference between population-level and individual-level fitted values and residuals.
#'
#' @note If fitting a joint model with a single longitudinal process, please make sure you are using a named \code{list} to define the formula for the fixed and random effects of the longitudinal submodel.
#'
#' @export
augment.mjoint <- function(x, data = x$data, ...) {
  # checks on 'data'
  if (is.null(data)) {
    stop("It was not possible to extract 'data' from 'x'. Please provide 'data' manually.")
  }

  if (length(data) > 1) {
    if (!do.call(all.equal, data)) {
      stop("List of 'data' extracted from 'x' does not include equal data frames.")
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

  # return augmented 'data'
  out <- cbind(data, fit0, fit1, res0, res1)
  out <- tibble::as_tibble(out)
  return(out)
}

#' @rdname mjoint_tidiers
#'
#' @param ... extra arguments (not used)
#'
#' @return \code{glance} returns one row with the columns
#'   \item{sigma2_j}{the square root of the estimated residual variance for the j-th longitudinal process}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'   \item{logLik}{the data's log-likelihood under the model}
#'
#' @export
glance.mjoint <- function(x, ...) {
  smr <- summary(x)
  out <- data.frame(t(smr$sigma))
  out$AIC <- smr$AIC
  out$BIC <- smr$BIC
  out$logLik <- smr$logLik
  rownames(out) <- NULL
  out <- tibble::as_tibble(out)
  return(out)
}
