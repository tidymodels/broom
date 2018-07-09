#' @templateVar class pyears
#' @template title_desc_tidy
#'
#' @param x A `pyears` object returned from [survival::pyears()].
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with one row for each time point and columns:
#' 
#'   \item{pyears}{person-years of exposure}
#'   \item{n}{number of subjects contributing time}
#'   \item{event}{observed number of events}
#'   \item{expected}{expected number of events (present only if a
#'     `ratetable` term is present)}
#'     
#' If the `data.frame = TRUE` argument is supplied to `pyears`,
#' this is simply the contents of `x$data`.
#'
#' @examples
#' 
#' library(survival)
#' 
#' temp.yr  <- tcut(mgus$dxyr, 55:92, labels=as.character(55:91))
#' temp.age <- tcut(mgus$age, 34:101, labels=as.character(34:100))
#' ptime <- ifelse(is.na(mgus$pctime), mgus$futime, mgus$pctime)
#' pstat <- ifelse(is.na(mgus$pctime), 0, 1)
#' pfit <- pyears(Surv(ptime/365.25, pstat) ~ temp.yr + temp.age + sex,  mgus,
#'                data.frame=TRUE)
#' tidy(pfit)
#' glance(pfit)
#'
#' # if data.frame argument is not given, different information is present in
#' # output
#' pfit2 <- pyears(Surv(ptime/365.25, pstat) ~ temp.yr + temp.age + sex,  mgus)
#' tidy(pfit2)
#' glance(pfit2)
#'
#' @aliases pyears_tidiers
#' @export
#' @seealso [tidy()], [survival::pyears()]
#' @family pyears tidiers
#' @family survival tidiers
#' 
tidy.pyears <- function(x, ...) {
  if (is.null(x$data)) {
    ret <- compact(unclass(x)[c("pyears", "n", "event", "expected")])
  } else {
    ret <- x$data
  }
  as_tibble(as.data.frame(ret)) # allow vector recycling!
}

#' @templateVar class pyears
#' @template title_desc_glance
#' 
#' @inheritParams tidy.pyears
#' 
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{total}{total number of person-years tabulated}
#'   \item{offtable}{total number of person-years off table}
#'
#' @export
#' @seealso [glance()], [survival::pyears()]
#' @family pyears tidiers
#' @family survival tidiers
glance.pyears <- function(x, ...) {
  if (is.null(x$data)) {
    tibble(total = sum(x$pyears), offtable = x$offtable)
  } else {
    tibble(total = sum(x$data$pyears), offtable = x$offtable)
  }
}
