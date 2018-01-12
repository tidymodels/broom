#' Tidying methods for joint models for time-to-event data and multivariate longitudinal data
#'
#' These methods tidy the coefficients of joint models for time-to-event data and multivariate
#' longitudinal data of the \code{mjoint} class from the \code{joineRML} package.
#'
#' @param x An object of class \code{mjoint}.
#'
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#'
#' @name mjoint_tidiers
#'
#' @examples
#' \dontrun{
#' # Fit a joint model with bivariate longitudinal outcomes
#' library(joineRML)
#' data(heart.valve)
#' hvd <- heart.valve[!is.na(heart.valve$log.grad) & !is.na(heart.valve$log.lvmi) & heart.valve$Num <= 50, ]
#' fit <- mjoint(
#'   formLongFixed = list("grad" = log.grad ~ time + sex + hs,
#'                        "lvmi" = log.lvmi ~ time + sex),
#'   formLongRandom = list("grad" = ~ 1 | num,
#'                         "lvmi" = ~ time | num),
#'   formSurv = Surv(fuyrs, status) ~ age,
#'   data = hvd,
#'   inits = list("gamma" = c(0.11, 1.51, 0.80)),
#'   timeVar = "time")
#'
#' # Extract the survival fixed effects
#' tidy(fit)
#'
#' # Extract the longitudinal fixed effects
#' tidy(fit, component = "longitudinal")
#'
#' # Extract model statistics
#' glimpse(fit)
#' }
#'
#' @rdname mjoint_tidiers
#'
#' @param component Either \code{survival} (the survival component of the model, default) or \code{longitudinal} (the longitudinal component).
#'
#' @param bootSE An object of class \code{bootSE} for the corresponding model. If \code{bootSE = NULL} (the default), the function will attempt to utilize approximate standard error estimates (if available) calculated from the empirical information matrix.
#'
#' @return \code{tidy} returns one row for each estimated fixed effect depending on the \code{component} parameter. It contains the following  columns:
#'   \item{term}{The term being estimated}
#'   \item{estimate}{Estimated value}
#'   \item{std.error}{Standard error}
#'   \item{statistic}{Z-statistic}
#'   \item{p.value}{P-value computed from Z-statistic}
#'
#' @export
tidy.mjoint <- function(x, component = "survival", bootSE = NULL, ...) {
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

  # return tidy object
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
  return(out)
}
