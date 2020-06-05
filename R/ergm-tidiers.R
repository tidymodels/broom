#' @templateVar class ergm
#' @template title_desc_tidy
#'
#' @description The methods should work with any model that conforms to
#' the \pkg{ergm} class, such as those produced from weighted networks by the
#' \pkg{ergm.count} package.
#'
#' @param x An `ergm` object returned from a call to [ergm::ergm()].
#' @template param_confint
#' @template param_exponentiate
#' @param ... Additional arguments to pass to [ergm::summary()].
#'   **Cautionary note**: Mispecified arguments may be silently ignored.
#'
#'
#' @return A [tibble::tibble] with one row for each coefficient in the
#'   exponential random graph model, with columns:
#'   \item{term}{The term in the model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error}
#'   \item{mcmc.error}{The MCMC error}
#'   \item{p.value}{The two-sided p-value}
#'
#' @examples
#'
#' library(ergm)
#' # Using the same example as the ergm package
#' # Load the Florentine marriage network data
#' data(florentine)
#'
#' # Fit a model where the propensity to form ties between
#' # families depends on the absolute difference in wealth
#' gest <- ergm(flomarriage ~ edges + absdiff("wealth"))
#'
#' # Show terms, coefficient estimates and errors
#' tidy(gest)
#'
#' # Show coefficients as odds ratios with a 99% CI
#' tidy(gest, exponentiate = TRUE, conf.int = TRUE, conf.level = 0.99)
#'
#' # Take a look at likelihood measures and other
#' # control parameters used during MCMC estimation
#' glance(gest)
#' glance(gest, deviance = TRUE)
#' glance(gest, mcmc = TRUE)
#' @references Hunter DR, Handcock MS, Butts CT, Goodreau SM, Morris M (2008b).
#'   \pkg{ergm}: A Package to Fit, Simulate and Diagnose Exponential-Family
#'   Models for Networks. *Journal of Statistical Software*, 24(3).
#'   <http://www.jstatsoft.org/v24/i03/>.
#'
#' @export
#' @aliases ergm_tidiers
#' @seealso [tidy()], [ergm::ergm()], [ergm::control.ergm()],
#'   [ergm::summary()]
#' @family ergm tidiers
tidy.ergm <- function(x, conf.int = FALSE, conf.level = 0.95,
                      exponentiate = FALSE, ...) {

  # in ergm 3.9 summary(x, ...)$coefs has columns:
  #   Estimate, Std. Error, MCMC %, Pr(>|Z|)

  # in ergm 3.10 summary(x, ...)$coefs has columns:
  #   Estimate, Std. Error, MCMC %, z value, Pr(>|Z|)

  ret <- summary(x, ...)$coefs %>%
    tibble::rownames_to_column() %>%
    rename2(
      term = "rowname",
      estimate = "Estimate",
      std.error = "Std. Error",
      mcmc.error = "MCMC %",
      statistic = "z value",
      p.value = "Pr(>|z|)"
    )

  if (conf.int) {
    z <- stats::qnorm(1 - (1 - conf.level) / 2)
    ret$conf.low <- ret$estimate - z * ret$std.error
    ret$conf.high <- ret$estimate + z * ret$std.error
  }

  if (exponentiate) {
    if (is.null(x$glm) ||
      (x$glm$family$link != "logit" && x$glm$family$link != "log")) {
      warning("Exponentiating but model didn't use log or logit link.")
    }

    ret$estimate <- exp(ret$estimate)

    if (conf.int) {
      ret$conf.low <- exp(ret$conf.low)
      ret$conf.high <- exp(ret$conf.high)
    }
  }

  as_tibble(ret)
}

#' @templateVar class ergm
#' @template title_desc_glance
#'
#' @inheritParams tidy.ergm
#' @param deviance Logical indicating whether or not to report null and
#'   residual deviance for the model, as well as degrees of freedom. Defaults
#'   to `FALSE`.
#' @param mcmc Logical indicating whether or not to report MCMC interval,
#'   burn-in and sample size used to estimate the model. Defaults to `FALSE`.
#'
#' @return `glance.ergm` returns a one-row tibble with the columns
#'   \item{independence}{Whether the model assumed dyadic independence}
#'   \item{iterations}{The number of MCMLE iterations performed before convergence}
#'   \item{logLik}{If applicable, the log-likelihood associated with the model}
#'   \item{AIC}{The Akaike Information Criterion}
#'   \item{BIC}{The Bayesian Information Criterion}
#'
#' If `deviance = TRUE`, and if the model supports it, the
#' tibble will also contain the columns
#'   \item{null.deviance}{The null deviance of the model}
#'   \item{df.null}{The degrees of freedom of the null deviance}
#'   \item{residual.deviance}{The residual deviance of the model}
#'   \item{df.residual}{The degrees of freedom of the residual deviance}
#'
#' @export
#' @seealso [glance()], [ergm::ergm()], [ergm::summary.ergm()]
#' @family ergm tidiers
glance.ergm <- function(x, deviance = FALSE, mcmc = FALSE, ...) {
  s <- summary(x, ...) # produces lots of messages

  ret <- as_glance_tibble(
    independence = s$independence,
    iterations = x$iterations,
    logLik = as.numeric(logLik(x)),
    na_types = "lir"
  )

  if (deviance & !is.null(ret$logLik)) {

    # see #567 for details on the following

    if (utils::packageVersion("ergm") < "3.10") {
      dyads <- sum(
        ergm::as.rlebdm(x$constrained, x$constrained.obs, which = "informative")
      )
    } else {
      dyads <- stats::nobs(x)
    }

    lln <- ergm::logLikNull(x)
    ret$null.deviance <- if (is.na(lln)) 0 else -2 * lln
    ret$df.null <- dyads

    ret$residual.deviance <- -2 * ret$logLik
    ret$df.residual <- dyads - length(x$coefs)
  }

  ret$AIC <- stats::AIC(x)
  ret$BIC <- stats::BIC(x)

  if (mcmc) {
    ret$MCMC.interval <- x$control$MCMC.interval
    ret$MCMC.burnin <- x$control$MCMC.burnin
    ret$MCMC.samplesize <- x$control$MCMC.samplesize
  }

  ret
}
