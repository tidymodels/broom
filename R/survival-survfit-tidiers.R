#' @templateVar class survfit
#' @template title_desc_tidy
#'
#' @param x A `survfit` object returned from [survival::survfit()].
#' @template param_unused_dots
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
#' @examples 
#' 
#' library(survival)
#' cfit <- coxph(Surv(time, status) ~ age + sex, lung)
#' sfit <- survfit(cfit)
#'
#' tidy(sfit)
#' glance(sfit)
#'
#' library(ggplot2)
#' ggplot(tidy(sfit), aes(time, estimate)) + geom_line() +
#'     geom_ribbon(aes(ymin=conf.low, ymax=conf.high), alpha=.25)
#'
#' # multi-state
#' fitCI <- survfit(Surv(stop, status * as.numeric(event), type = "mstate") ~ 1,
#'               data = mgus1, subset = (start == 0))
#' td_multi <- tidy(fitCI)
#' td_multi
#' 
#' ggplot(td_multi, aes(time, estimate, group = state)) +
#'     geom_line(aes(color = state)) +
#'     geom_ribbon(aes(ymin = conf.low, ymax = conf.high), alpha = .25)
#'
#' @aliases survfit_tidiers
#' @export
#' @seealso [tidy()], [survival::survfit()]
#' @family survfit tidiers
#' @family survival tidiers
#' 
tidy.survfit <- function(x, ...) {
  
  ret <- tibble(
    time = x$time,
    n.risk = x$n.risk,
    n.event = x$n.event,
    n.censor = x$n.censor,
    estimate = x$surv,
    std.error = x$std.err
  )
  
  # TODO: when is std.err present?
  
  # add confidence intervals (only) if present
  if (!is.null(x$lower)) {
    ret$conf.low <- c(x$lower)
    ret$conf.high <- c(x$upper)
  }
  
  
  # strata are automatically recycled if there are multiple states
  if (!is.null(x$strata)) {
    ret$strata <- rep(names(x$strata), x$strata)
  }
  
  ret
}

#' @templateVar class survfitms
#' @template title_desc_tidy
#'
#' @param x A `survfitms` object returned from [survival::survfit()].
#' @template param_unused_dots
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
#' @inherit tidy.survfit examples
#' 
#' @export
#' @seealso [tidy()], [survival::survfit()]
#' @family survfit tidiers
#' @family survival tidiers
#' 
tidy.survfitms <- function(x, ...) {
  
  # c() coerces to vector
  ret <- tibble(
    time = x$time,
    n.risk = c(x$n.risk),
    n.event = c(x$n.event),
    n.censor = c(x$n.censor),
    estimate = c(x$pstate),
    std.error = c(x$std.err),
    state = rep(x$states, each = nrow(x$pstate)) # distinct from tidy.survfit()
  )
  
  # TODO: when is std.err present?
  
  # add confidence intervals (only) if present
  if (!is.null(x$lower)) {
    ret$conf.low <- c(x$lower)
    ret$conf.high <- c(x$upper)
  }
  
  ret <- ret[ret$state != "", ]
  
  # strata are automatically recycled if there are multiple states
  if (!is.null(x$strata)) {
    ret$strata <- rep(names(x$strata), x$strata)
  }
  
  ret
}

#' @templateVar class survfit
#' @template title_desc_glance
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
  if (inherits(x, "survfitms"))
    stop("No glance method exists for multi-state survfit objects.",
         call. = FALSE)
  
  if (!is.null(x$strata)) 
    stop("No glance method exists for multi-strata survfit objects.",
         call. = FALSE)
  
  s <- summary(x)
  
  # TODO: as_tibble?
  ret <- unrowname(as.data.frame(t(s$table)))
  
  colnames(ret) <- dplyr::recode(
    colnames(ret),
    "*rmean" = "rmean",
    "*se(rmean)" = "rmean.std.error"
  )

  # if a CI was calculated, the last two elements
  # contain the CI, but with auto-generated names
  # (e.g. 0.95LCL and 0.95UCL), so we rename them
  
  # TODO: use rename2?
  
  if (!is.null(x$lower)) {
    colnames(ret)[utils::tail(seq_along(ret), 2)] <-
      c("conf.low", "conf.high")
  }
  
  ret$nobs <- stats::nobs(x)

  as_tibble(ret)
}
