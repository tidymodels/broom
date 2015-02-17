#' Tidiers for matrix objects
#' 
#' These perform tidying operations on matrix objects. \code{tidy} turns the
#' matrix into a data.frame while bringing rownames, if they exist, in as
#' a column called \code{.rownames} (since results of tidying operations never
#' contain rownames). \code{glance} simply reports the number of rows and
#' columns. Note that no augment method exists for matrices.
#' 
#' @param x A matrix
#' @param ... extra arguments, not used
#' 
#' @examples
#' 
#' mat <- as.matrix(mtcars)
#' tidy(mat)
#' glance(mat)
#' 
#' @name matrix_tidiers


#' @rdname matrix_tidiers
#' 
#' @return \code{tidy.matrix} returns the original matrix converted into
#' a data.frame, except that it incorporates rownames (if they exist)
#' into a column called \code{.rownames}.
#' 
#' @export
tidy.matrix <- function(x, ...) {
  fix_data_frame(x, newcol = ".rownames")
}


#' @rdname matrix_tidiers
#' 
#' @return \code{glance} returns a one-row data.frame with
#'   \item{nrow}{number of rows}
#'   \item{ncol}{number of columns}
#'   \item{complete.obs}{number of rows that have no missing values}
#'   \item{na.fraction}{fraction of values across all rows and columns that
#'   are missing}
#' 
#' @export
glance.matrix <- function(x, ...) {
    glance.data.frame(x)
}
