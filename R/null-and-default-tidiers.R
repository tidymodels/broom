#' Tidiers for NULL inputs
#'
#' `tidy(NULL)`, `glance(NULL)` and `augment(NULL)` all return an empty 
#' [tibble::tibble]. This empty tibble can be treated a tibble with zero
#' rows, making it convenient to combine with other tibbles using
#' functions like [purrr::map_df()] on lists of potentially `NULL` objects.
#'
#' @param x The value `NULL`.
#' @param ... Additional arguments (not used).
#' 
#' @return An empty [tibble::tibble].
#' 
#' @name null_tidiers
#' @export
#' @seealso [tibble::tibble]
tidy.NULL <- function(x, ...) {
  tibble()
}

#' @rdname null_tidiers
#' @export
glance.NULL <- function(x, ...) tibble()

#' @rdname null_tidiers
#' @export
augment.NULL <- function(x, ...) tibble()



#' @export
tidy.default <- function(x, ...) {
  stop("No tidy method for objects of class ", class(x)[1], call. = FALSE)
}

#' @export
glance.default <- function(x, ...) {
  stop("No glance method for objects of class ", class(x)[1], call. = FALSE)
}

#' @export
augment.default <- function(x, ...) {
  stop("No augment method for objects of class ", class(x)[1], call. = FALSE)
}
