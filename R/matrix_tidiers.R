#' Tidiers for matrix objects
#'
#' Matrix tidiers are deprecated and will be removed from an upcoming release
#' of broom.
#'
#' These perform tidying operations on matrix objects. `tidy` turns the
#' matrix into a data.frame while bringing rownames, if they exist, in as
#' a column called `.rownames` (since results of tidying operations never
#' contain rownames). `glance` simply reports the number of rows and
#' columns. Note that no augment method exists for matrices.
#'
#' @param x A matrix
#' @param ... extra arguments, not used
#'
#' @examples
#'
#' \dontrun{
#' mat <- as.matrix(mtcars)
#' tidy(mat)
#' glance(mat)
#' }
#'
#' @name matrix_tidiers


#' @rdname matrix_tidiers
#'
#' @return `tidy.matrix` returns the original matrix converted into
#' a data.frame, except that it incorporates rownames (if they exist)
#' into a column called `.rownames`.
#'
#' @export
tidy.matrix <- function(x, ...) {
  .Deprecated()
  fix_data_frame(x, newcol = ".rownames")
}


#' @rdname matrix_tidiers
#'
#' @return `glance` returns a one-row data.frame with
#'   \item{nrow}{number of rows}
#'   \item{ncol}{number of columns}
#'   \item{complete.obs}{number of rows that have no missing values}
#'   \item{na.fraction}{fraction of values across all rows and columns that
#'   are missing}
#'
#' @export
glance.matrix <- function(x, ...) {
  .Deprecated()
  glance.data.frame(x)
}
