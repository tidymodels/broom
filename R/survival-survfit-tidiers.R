
#' tidy survival curve fits
#'
#' Construct tidied data frames showing survival curves over time.
#'
#' @param x "survfit" object
#' @param ... extra arguments, not used
#'
#' @details `glance` does not work on multi-state survival curves,
#' since the values `glance` outputs would be calculated for each state.
#' `tidy` does work for multi-state survival objects, and includes a
#' `state` column to distinguish between them.
#'
#' @template boilerplate
#'
#' @examples
#'
#' if (require("survival", quietly = TRUE)) {
#'     cfit <- coxph(Surv(time, status) ~ age + sex, lung)
#'     sfit <- survfit(cfit)
#'
#'     tidy(sfit)
#'     glance(sfit)
#'
#'     library(ggplot2)
#'     ggplot(tidy(sfit), aes(time, estimate)) + geom_line() +
#'         geom_ribbon(aes(ymin=conf.low, ymax=conf.high), alpha=.25)
#'
#'     # multi-state
#'     fitCI <- survfit(Surv(stop, status * as.numeric(event), type = "mstate") ~ 1,
#'                   data = mgus1, subset = (start == 0))
#'     td_multi <- tidy(fitCI)
#'     td_multi
#'     
#'     ggplot(td_multi, aes(time, estimate, group = state)) +
#'         geom_line(aes(color = state)) +
#'         geom_ribbon(aes(ymin = conf.low, ymax = conf.high), alpha = .25)
#'
#' }
#'
#' @name survfit_tidiers


#' @rdname survfit_tidiers
#'
#' @return `tidy` returns a row for each time point, with columns
#'   \item{time}{timepoint}
#'   \item{n.risk}{number of subjects at risk at time t0}
#'   \item{n.event}{number of events at time t}
#'   \item{n.censor}{number of censored events}
#'   \item{estimate}{estimate of survival or cumulative incidence rate when multistate}
#'   \item{std.error}{standard error of estimate}
#'   \item{conf.high}{upper end of confidence interval}
#'   \item{conf.low}{lower end of confidence interval}
#'   \item{state}{state if multistate survfit object inputted}
#'   \item{strata}{strata if stratified survfit object inputted}
#' @export
tidy.survfit <- function(x, ...) {
  if (inherits(x, "survfitms")) {
    
    # c(x$???) when value is a matrix and needs to be stacked
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

#' @rdname survfit_tidiers
#'
#' @return `glance` returns one-row data.frame with the columns
#' displayed by [print.survfit()]
#'   \item{records}{number of observations}
#'   \item{n.max}{n.max}
#'   \item{n.start}{n.start}
#'   \item{events}{number of events}
#'   \item{rmean}{Restricted mean (see [survival::print.survfit()]}
#'   \item{rmean.std.error}{Restricted mean standard error}
#'   \item{median}{median survival}
#'   \item{conf.low}{lower end of confidence interval on median}
#'   \item{conf.high}{upper end of confidence interval on median}
#'
#' @export
glance.survfit <- function(x, ...) {
  if (inherits(x, "survfitms")) {
    stop("Cannot construct a glance of a multi-state survfit object.")
  }
  if (!is.null(x$strata)) {
    stop("Cannot construct a glance of a multi-strata survfit object.")
  }
  
  s <- summary(x)
  ret <- unrowname(as.data.frame(t(s$table)))
  
  colnames(ret) <- plyr::revalue(colnames(ret),
                                 c(
                                   "*rmean" = "rmean",
                                   "*se(rmean)" = "rmean.std.error"
                                 ),
                                 warn_missing = FALSE
  )
  
  colnames(ret)[utils::tail(seq_along(ret), 2)] <- c("conf.low", "conf.high")
  ret
}
