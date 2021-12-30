#' @templateVar class muhaz
#' @template title_desc_tidy
#'
#' @param x A `muhaz` object returned by [muhaz::muhaz()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "time",
#'   estimate = "Estimated hazard rate."
#' )
#'
#' @examples
#' 
#' if (requireNamespace("muhaz", quietly = TRUE)) {
#'   if (requireNamespace("survival", quietly = TRUE)) {
#' 
#' library(muhaz)
#' library(survival)
#'
#' x <- muhaz(ovarian$futime, ovarian$fustat)
#' tidy(x)
#' glance(x)
#' 
#'   }
#' }
#' 
#' @aliases muhaz_tidiers
#' @export
#' @seealso [tidy()], [muhaz::muhaz()]
#' @family muhaz tidiers
tidy.muhaz <- function(x, ...) {
  bind_cols(x[c("est.grid", "haz.est")]) %>%
    rename("time" = "est.grid", "estimate" = "haz.est") %>%
    as_tibble()
}

#' @templateVar class muhaz
#' @template title_desc_glance
#'
#' @inherit tidy.muhaz params examples
#'
#' @evalRd return_glance(
#'   "nobs",
#'   "min.time",
#'   "max.time",
#'   "min.hazard",
#'   "max.hazard"
#' )
#'
#' @export
#' @seealso [glance()], [muhaz::muhaz()]
#' @family muhaz tidiers
glance.muhaz <- function(x, ...) {
  bind_cols(x$pin[c("nobs", "min.time", "max.time")]) %>%
    mutate(
      min.hazard = min(x$haz.est),
      max.hazard = max(x$haz.est)
    ) %>%
    as_tibble()
}
