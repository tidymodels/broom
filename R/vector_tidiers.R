#' Tidy atomic vectors
#'
#' Vector tidiers are deprecated and will be removed from an upcoming release
#' of broom.
#'
#' Turn atomic vectors into data frames, where the names of the vector (if they
#' exist) are a column and the values of the vector are a column.
#'
#' @param x An object of class "numeric", "integer", "character", or "logical".
#'   Most likely a named vector
#' @param ... Extra arguments (not used)
#'
#' @examples
#'
#' \dontrun{
#' x <- 1:5
#' names(x) <- letters[1:5]
#' tidy(x)
#' }
#' 
#' @export
#' @rdname vector_tidiers
tidy.numeric <- function(x, ...) {
  .Deprecated()
  if (!is.null(names(x))) {
    dplyr::data_frame(names = names(x), x = unname(x))
  } else {
    dplyr::data_frame(x = x)
  }
}

#' @export
#' @rdname vector_tidiers
tidy.character <- function(x, ...) {
  .Deprecated()
  if (!is.null(names(x))) {
    dplyr::data_frame(names = names(x), x = unname(x))
  } else {
    dplyr::data_frame(x = x)
  }
}

#' @export
#' @rdname vector_tidiers
tidy.logical <- function(x, ...) {
  .Deprecated()
  if (!is.null(names(x))) {
    dplyr::data_frame(names = names(x), x = unname(x))
  } else {
    dplyr::data_frame(x = x)
  }
}
