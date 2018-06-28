#' Tidy a sparseMatrix object from the Matrix package
#' 
#' sparseMatrix tidiers are deprecated and will be removed from an upcoming
#' version of broom.
#'
#' Tidy a sparseMatrix object from the Matrix package into
#' a three-column data frame, row, column, and value (with
#' zeros missing). If there are row names or column names,
#' use those, otherwise use indices
#'
#' @param x A Matrix object
#' @param ... Extra arguments, not used
#'
#' @name sparse_tidiers
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
