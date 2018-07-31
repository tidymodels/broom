#' @templateVar class muhaz
#' @template title_desc_tidy
#'
#' @param x A `muhaz` object returned by [muhaz::muhaz()].
#' @template param_unused_dots
#'
#' @return A [tibble::tibble] with two columns:
#' 
#'   \item{time}{The time at which the hazard rate was estimated.}
#'   \item{estimate}{The estimated hazard rate.}
#'
#' @examples
#' if (require("muhaz", quietly = TRUE)) {
#'   data(ovarian, package="survival")
#'   x <- muhaz::muhaz(ovarian$futime, ovarian$fustat)
#'   tidy(x)
#'   glance(x)
#' }
#'
#' @aliases muhaz_tidiers
#' @export
#' @seealso [tidy()], [muhaz::muhaz()]
#' @family muhaz tidiers
tidy.muhaz <- function(x, ...) {
  bind_cols(x[c("est.grid", "haz.est")]) %>%
    rename("time" = "est.grid", "estimate" = "haz.est")
}

#' @templateVar class muhaz
#' @template title_desc_glance
#'
#' @inheritParams tidy.muhaz
#'
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{nobs}{Number of observations used for estimation}
#'   \item{min.time}{The minimum observed event or censoring time}
#'   \item{max.time}{The maximum observed event or censoring time}
#'   \item{min.harzard}{Minimal estimated hazard}
#'   \item{max.hazard}{Maximal estimated hazard}
#'
#' @export
#' @seealso [glance()], [muhaz::muhaz()]
#' @family muhaz tidiers
glance.muhaz <- function(x, ...) {
  bind_cols(x$pin[c("nobs", "min.time", "max.time")]) %>%
    mutate(
      min.hazard = min(x$haz.est),
      max.hazard = max(x$haz.est)
    )
}
