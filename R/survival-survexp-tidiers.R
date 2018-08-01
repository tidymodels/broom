#' @templateVar class survexp
#' @template title_desc_tidy
#'
#' @param x An `survexp` object returned from [survival::survexp()].
#' @template param_unused_dots
#' 
#' @evalRd return_tidy("time", "n.risk",
#'   estimate = "Estimate survival"
#' )
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
#' @inherit tidy.survexp params examples
#' 
#' @evalRd return_glance("n.max", "n.start", "timepoints")
#'
#' @export
#' @seealso [glance()], [survival::survexp()]
#' @family survexp tidiers
#' @family survival tidiers
glance.survexp <- function(x, ...) {
  tibble(
    n.max = max(x$n.risk),
    n.start = x$n.risk[1],
    timepoints = length(x$n.risk)
  )
}
