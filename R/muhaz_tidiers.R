#' Tidying methods for kernel based hazard rate estimates
#'
#' These methods tidy the output of \code{muhaz} objects as returned by the
#' \code{\link[muhaz]{muhaz}} function, which provides kernel based
#' non-parametric hazard rate estimators.
#'
#' The "augment" method is not useful and therefore not
#' available for \code{muhaz} objects.
#'
#' @param x \code{muhaz} object
#'
#' @template boilerplate
#'
#' @return \code{tidy.muhaz} returns a tibble containing two columns:
#' \code{time} at which the hazard rate was estimated and \code{estimate}.
#'
#' @name muhaz_tidiers
#'
#' @examples
#' if (require("muhaz", quietly = TRUE)) {
#'   data(ovarian, package="survival")
#'   x <- muhaz(ovarian$futime, ovarian$fustat)
#'   tidy(x)
#'   glance(x)
#' }
#'
#' @export
tidy.muhaz <- function(x, ...) {

  bind_cols(x[c("est.grid", "haz.est")]) %>%
    rename("time"="est.grid", "estimate"="haz.est")

}

#' @rdname muhaz_tidiers
#'
#' @param ... extra arguments (not used)
#'
#' @return \code{glance.muhaz} returns a one-row data.frame with the columns
#'   \item{nobs}{Number of observations used for estimation}
#'   \item{min.time}{The minimum observed event or censoring time}
#'   \item{max.time}{The maximum observed event or censoring time}
#'   \item{min.harzard}{Minimal estimated hazard}
#'   \item{max.hazard}{Maximal estimated hazard}
#'
#' @export
glance.muhaz <- function(x, ...) {

  bind_cols(x$pin[c("nobs", "min.time", "max.time")]) %>%
    mutate(
      min.hazard = min(x$haz.est),
      max.hazard = max(x$haz.est))

}
