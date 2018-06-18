#' Turn a model object into a tidy tibble
#'
#' TODO: Flesh out this documentation.
#'
#' @param x An object to be converted into a tidy [tibble::tibble()].
#' @param ... Additional arguments to tidying method.
#' @return A tibble.
#'
#' @export
tidy <- function(x, ...) UseMethod("tidy")


#' Tidy a NULL input
#'
#' When `tidy` is called on a `NULL` input, it returns an empty `tibble`. This
#' is treated as an empty tibble which can be combined with other tibbles.
#'
#' @param x A value `NULL`.
#' @param ... Additional arguments (not used).
#' @return An empty tibble.
#'
#' @export
tidy.NULL <- function(x, ...) {
  tibble()
}

#' @export
tidy.default <- function(x, ...) {
  stop("No tidy method for S3 objects of class", class(x)[1], call. = FALSE)
}
