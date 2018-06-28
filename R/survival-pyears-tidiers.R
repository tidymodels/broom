


#' Tidy person-year summaries
#'
#' These tidy the output of `pyears`, a calculation of the person-years
#' of follow-up time contributed by a cohort of subject. Since the output of
#' `pyears$data` is already tidy (if the `data.frame = TRUE` argument
#' is given), this does only a little work and should rarely be necessary.
#'
#' @param x a "pyears" object
#' @param ... extra arguments (not used)
#'
#' @examples
#'
#' if (require("survival", quietly = TRUE)) {
#'     temp.yr  <- tcut(mgus$dxyr, 55:92, labels=as.character(55:91))
#'     temp.age <- tcut(mgus$age, 34:101, labels=as.character(34:100))
#'     ptime <- ifelse(is.na(mgus$pctime), mgus$futime, mgus$pctime)
#'     pstat <- ifelse(is.na(mgus$pctime), 0, 1)
#'     pfit <- pyears(Surv(ptime/365.25, pstat) ~ temp.yr + temp.age + sex,  mgus,
#'                    data.frame=TRUE)
#'     head(tidy(pfit))
#'     glance(pfit)
#'
#'     # if data.frame argument is not given, different information is present in
#'     # output
#'     pfit2 <- pyears(Surv(ptime/365.25, pstat) ~ temp.yr + temp.age + sex,  mgus)
#'     head(tidy(pfit2))
#'     glance(pfit2)
#' }
#'
#' @seealso \link{pyears}
#'
#' @name pyears_tidiers


#' @rdname pyears_tidiers
#'
#' @return `tidy` returns a data.frame with the columns
#'   \item{pyears}{person-years of exposure}
#'   \item{n}{number of subjects contributing time}
#'   \item{event}{observed number of events}
#'   \item{expected}{expected number of events (present only if a
#'   `ratetable` term is present)}
#'
#' If the `data.frame = TRUE` argument is supplied to `pyears`,
#' this is simply the contents of `x$data`.
#'
#' @export
tidy.pyears <- function(x, ...) {
  if (is.null(x$data)) {
    ret <- compact(unclass(x)[c("pyears", "n", "event", "expected")])
  } else {
    ret <- x$data
  }
  as_tibble(as.data.frame(ret)) # hacky to allow vector recycling
}


#' @rdname pyears_tidiers
#'
#' @return `glance` returns a one-row data frame with
#'   \item{total}{total number of person-years tabulated}
#'   \item{offtable}{total number of person-years off table}
#'
#' This contains the values printed by `summary.pyears`.
#'
#' @export
glance.pyears <- function(x, ...) {
  if (is.null(x$data)) {
    tibble(total = sum(x$pyears), offtable = x$offtable)
  } else {
    tibble(total = sum(x$data$pyears), offtable = x$offtable)
  }
}
