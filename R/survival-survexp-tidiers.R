#' @templateVar class survexp
#' @template title_desc_tidy
#'
#' @param x An `survexp` object returned from [survival::survexp()].
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with one row for each time point and columns:
#' 
#'   \item{time}{time point}
#'   \item{estimate}{estimated survival}
#'   \item{n.risk}{number of individuals at risk}
#'
#' @examples
#'
#' library(survival)
#' sexpfit <- survexp(
#'   futime ~ 1,
#'   rmap = list(
#'     sex = "male",
#'     year = accept.dt,
#'     age = (accept.dt - birth.dt)
#'   ),
#'   method = 'conditional',
#'   data = jasa
#' )
#'
#' tidy(sexpfit)
#' glance(sexpfit)
#'
#' @aliases sexpfit_tidiers survexp_tidiers
#' @export
#' @seealso [tidy()], [survival::survexp()]
#' @family survexp tidiers
#' @family survival tidiers
tidy.survexp <- function(x, ...) {
  ret <- as_tibble(summary(x)[c("time", "surv", "n.risk")])
  rename(ret, "estimate" = "surv")
}


#' @templateVar class survexp
#' @template title_desc_glance
#' 
#' @inheritParams tidy.survexp
#' 
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{n.max}{maximum number of subjects at risk}
#'   \item{n.start}{starting number of subjects at risk}
#'   \item{timepoints}{number of timepoints}
#'
#' @export
#' @seealso [glance()], [survival::survexp()]
#' @family survexp tidiers
#' @family survival tidiers
glance.survexp <- function(x, ...) {
  tibble(
    n.max = max(x$n.risk), n.start = x$n.risk[1],
    timepoints = length(x$n.risk)
  )
}
