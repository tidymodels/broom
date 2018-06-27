#' tidy a table object
#'
#' A table, typically created by the \link{table} function, contains a
#' contingency table of frequencies across multiple vectors. This directly
#' calls the [as.data.frame.table()] method, which melts it into a
#' data frame with one column for each variable and a `Freq` column.
#'
#' @param x An object of class "table"
#' @param ... Extra arguments (not used)
#'
#' @examples
#'
#' tab <- with(airquality, table(cut(Temp, quantile(Temp)), Month))
#' tidy(tab)
#'
#' @seealso [as.data.frame.table()]
#'
#' @export
tidy.table <- function(x, ...) {
  as_tibble(x)
}
