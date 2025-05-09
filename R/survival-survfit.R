#' @templateVar class survfit
#' @template title_desc_tidy
#'
#' @param x An `survfit` object returned from [survival::survfit()].
#' @param ... For `glance.survfit()`, additional arguments passed
#' to [summary()]. Otherwise ignored.
#'
#' @evalRd return_tidy(
#'   "time",
#'   "n.risk",
#'   "n.event",
#'   "n.censor",
#'   estimate = "estimate of survival or cumulative incidence rate when
#'     multistate",
#'   "std.error",
#'   "conf.low",
#'   "conf.high",
#'   state = "state if multistate survfit object input",
#'   strata = "strata if stratified survfit object input"
#' )
#'
#' @examplesIf rlang::is_installed(c("survival", "ggplot2"))
#'
#' # load libraries for models and data
#' library(survival)
#'
#' # fit model
#' cfit <- coxph(Surv(time, status) ~ age + sex, lung)
#' sfit <- survfit(cfit)
#'
#' # summarize model fit with tidiers + visualization
#' tidy(sfit)
#' glance(sfit)
#'
#' library(ggplot2)
#'
#' ggplot(tidy(sfit), aes(time, estimate)) +
#'   geom_line() +
#'   geom_ribbon(aes(ymin = conf.low, ymax = conf.high), alpha = .25)
#'
#' # multi-state
#' fitCI <- survfit(Surv(stop, status * as.numeric(event), type = "mstate") ~ 1,
#'   data = mgus1, subset = (start == 0)
#' )
#'
#' td_multi <- tidy(fitCI)
#'
#' td_multi
#'
#' ggplot(td_multi, aes(time, estimate, group = state)) +
#'   geom_line(aes(color = state)) +
#'   geom_ribbon(aes(ymin = conf.low, ymax = conf.high), alpha = .25)
#'
#' @aliases survfit_tidiers
#' @export
#' @seealso [tidy()], [survival::survfit()]
#' @family survfit tidiers
#' @family survival tidiers
#'
tidy.survfit <- function(x, ...) {
  if (inherits(x, "survfitms")) {
    # c() coerces to vector
    ret <- data.frame(
      time = x$time,
      n.risk = c(x$n.risk),
      n.event = c(x$n.event),
      n.censor = c(x$n.censor),
      estimate = c(x$pstate),
      std.error = c(x$std.err),
      conf.high = c(x$upper),
      conf.low = c(x$lower),
      state = rep(x$states, each = nrow(x$pstate))
    )

    ret <- ret[ret$state != "", ]
  } else {
    ret <- data.frame(
      time = x$time,
      n.risk = x$n.risk,
      n.event = x$n.event,
      n.censor = x$n.censor,
      estimate = x$surv,
      std.error = x$std.err,
      conf.high = x$upper,
      conf.low = x$lower
    )
  }
  # strata are automatically recycled if there are multiple states
  if (!is.null(x$strata)) {
    ret$strata <- rep(names(x$strata), x$strata)
  }
  as_tibble(ret)
}

#' @templateVar class survfit
#' @template title_desc_glance
#'
#' @param ... Additional arguments passed to [survival::summary.survfit()]. Important
#'   arguments include `rmean`.
#'
#' @inherit tidy.survfit params examples
#'
#' @evalRd return_glance(
#'   "records",
#'   "n.max",
#'   "n.start",
#'   "events",
#'   "rmean",
#'   "rmean.std.error",
#'   conf.low = "lower end of confidence interval on median",
#'   conf.high = "upper end of confidence interval on median",
#'   median = "median survival",
#'   "nobs"
#' )
#'
#' @export
#' @seealso [glance()], [survival::survfit()]
#' @family cch tidiers
#' @family survival tidiers
#'
glance.survfit <- function(x, ...) {
  if (inherits(x, "survfitms")) {
    cli::cli_abort("Cannot {.fn glance} a multi-state {.cls survfit} object.")
  }
  if (!is.null(x$strata)) {
    cli::cli_abort("Cannot {.fn glance} a multi-strata {.cls survfit} object.")
  }

  s <- summary(x, ...)
  ret <- unrowname(as.data.frame(t(s$table)))

  colnames(ret) <- dplyr::recode(
    colnames(ret),
    "*rmean" = "rmean",
    "*se(rmean)" = "rmean.std.error",
    "se(rmean)" = "rmean.std.error"
  )

  colnames(ret)[utils::tail(seq_along(ret), 2)] <- c("conf.low", "conf.high")

  ret$nobs <- stats::nobs(x)

  as_tibble(ret)
}
