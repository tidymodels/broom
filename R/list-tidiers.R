#' Tidying methods for lists / returned values that are not S3 objects
#' 
#' Broom tidies a number of lists that are effectively S3 objects without
#' a class attribute. For example, [stats::optim()], [svd()] and 
#' [akima::interp()] produce consistent output, but because they do not
#' have a class attribute, they cannot be handled by S3 dispatch.
#' 
#' These functions look at the elements of a list and determine if there is
#' an appropriate tidying method to apply to the list. Those tidiers are
#' themselves are implemented as functions of the form `tidy_<function>`
#' or `glance_<function>` and are not exported (but they are documented!).
#' 
#' If no appropriate tidying method is found, throws an error.
#'
#' @param x A list, potentially representing an object that can be tidied.
#' @param ... Additionally arguments passed to the tidying function.
#' 
#' @name list_tidiers
#' @export
#' @family list tidiers
tidy.list <- function(x, ...) {
  
  optim_elems <- c("par", "value", "counts", "convergence", "message")
  xyz_elems <- c("x", "y", "z")
  svd_elems <- c("d", "u", "v")
  irlba_elems <- c(svd_elems, "iter", "mprod")
  
  if (all(optim_elems %in% names(x))) {
    tidy_optim(x, ...)
  } else if (all(xyz_elems %in% names(x))) {
    tidy_xyz(x, ...)
  } else if (all(irlba_elems %in% names(x))) {
    tidy_irlba(x, ...)
  } else if (all(svd_elems %in% names(x))) {
    tidy_svd(x, ...)
  } else {
    stop("No tidy method recognized for this list.", call. = FALSE)
  }
}

#' @rdname list_tidiers
#' @export
glance.list <- function(x, ...) {
  
  optim_elems <- c("par", "value", "counts", "convergence", "message")
  
  if (all(optim_elems %in% names(x))) {
    glance_optim(x, ...)
  } else {
    stop("No glance method recognized for this list.", call. = FALSE)
  }
}
