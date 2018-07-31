#' @templateVar class table
#' @template title_desc_tidy
#' 
#' @description Deprecated. Please use [tibble::as_tibble()] instead.
#'
#' @param x A [table] object.
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] in long-form containing frequency information
#'   for the table in a `Freq` column. The result is much like what you get
#'   from [tidyr::gather()].
#'   
#' @details Directly calls [tibble::as_tibble()] on a [table] object, which
#'   does the same things as [as.data.frame.table()] but also gives the
#'   returned object [tibble::tibble] class.
#'
#' @seealso [as_tibble.table()]
#' @export
tidy.table <- function(x, ...) {
  .Deprecated()
  as_tibble(x)
}
