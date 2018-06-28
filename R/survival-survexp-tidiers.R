

#' Tidy an expected survival curve
#'
#' This constructs a summary across time points or overall of an expected survival
#' curve. Note that this contains less information than most survfit objects.
#'
#' @param x "survexp" object
#' @param ... extra arguments (not used)
#'
#' @template boilerplate
#'
#' @examples
#'
#' if (require("survival", quietly = TRUE)) {
#'     sexpfit <- survexp(futime ~ 1, rmap=list(sex="male", year=accept.dt,
#'                                              age=(accept.dt-birth.dt)),
#'                        method='conditional', data=jasa)
#'
#'     tidy(sexpfit)
#'     glance(sexpfit)
#' }
#'
#' @name sexpfit_tidiers


#' @rdname sexpfit_tidiers
#'
#' @return `tidy` returns a one row for each time point, with columns
#'   \item{time}{time point}
#'   \item{estimate}{estimated survival}
#'   \item{n.risk}{number of individuals at risk}
#'
#' @export
tidy.survexp <- function(x, ...) {
  ret <- as_tibble(summary(x)[c("time", "surv", "n.risk")])
  rename(ret, estimate = surv)
}


#' @rdname sexpfit_tidiers
#'
#' @return `glance` returns a one-row data.frame with the columns:
#'   \item{n.max}{maximum number of subjects at risk}
#'   \item{n.start}{starting number of subjects at risk}
#'   \item{timepoints}{number of timepoints}
#'
#' @export
glance.survexp <- function(x, ...) {
  tibble(
    n.max = max(x$n.risk), n.start = x$n.risk[1],
    timepoints = length(x$n.risk)
  )
}
