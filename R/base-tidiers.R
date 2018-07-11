#' @templateVar class table
#' @template title_desc_tidy
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
#' @examples
#'
#' tab <- with(airquality, table(cut(Temp, quantile(Temp)), Month))
#' tidy(tab)
#'
#' @seealso [as_tibble.table()]
#' @export
tidy.table <- function(x, ...) {
  as_tibble(x)
}
