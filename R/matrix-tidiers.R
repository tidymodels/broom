#' Tidy a sparseMatrix object from the Matrix package
#'
#' Tidy a sparseMatrix object from the Matrix package into
#' a three-column data frame, row, column, and value (with
#' zeros missing). If there are row names or column names,
#' use those, otherwise use indices
#'
#' @param x A Matrix object
#' @template param_unused_dots
#'
#' @name sparse_tidiers
#'
#' @evalRd return_tidy(
#'   "row",
#'   column = "Column name in the original matrix.",
#'   "value"
#' )
#'
#'
#' @export
tidy.dgTMatrix <- function(x, ...) {
  .Deprecated()
  s <- Matrix::summary(x)

  row <- s$i
  if (!is.null(rownames(x))) {
    row <- rownames(x)[row]
  }
  col <- s$j
  if (!is.null(colnames(x))) {
    col <- colnames(x)[col]
  }

  ret <- data.frame(
    row = row, column = col, value = s$x,
    stringsAsFactors = FALSE
  )
  ret
}


#' @rdname sparse_tidiers
#' @export
tidy.dgCMatrix <- function(x, ...) {
  .Deprecated()
  tidy(methods::as(x, "dgTMatrix"))
}


#' @rdname sparse_tidiers
#' @export
tidy.sparseMatrix <- function(x, ...) {
  .Deprecated()
  tidy(methods::as(x, "dgTMatrix"))
}
