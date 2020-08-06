#' @templateVar class table
#' @template title_desc_tidy
#'
#' @description Deprecated. Please use [tibble::as_tibble()] instead.
#'
#' @param x A [base::table] object.
#' @template param_unused_dots
#'
#' @return A [tibble::tibble] in long-form containing frequency information
#'   for the table in a `Freq` column. The result is much like what you get
#'   from [tidyr::pivot_longer()].
#'
#' @details Directly calls [tibble::as_tibble()] on a [base::table] object, which
#'   does the same things as [base::as.data.frame.table()] but also gives the
#'   returned object [tibble::tibble] class.
#'
#' @seealso [tibble::as_tibble.table()]
#' @export
tidy.table <- function(x, ...) {
  .Deprecated()
  as_tibble(x)
}
