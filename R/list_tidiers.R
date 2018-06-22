#' Tidiers for return values from functions that aren't S3 objects
#'
#' This method handles the return values of functions that return lists
#' rather than S3 objects, such as `optim`, `svd`, or
#' [akima::interp()], and therefore cannot be handled by
#' S3 dispatch.
#'
#' @param x list object
#' @param ... extra arguments, passed to the tidying function
#'
#' @details Those tidiers themselves are implemented as functions of the
#' form tidy_<function> or glance_<function> that are not exported.
#'
#' @seealso \link{optim_tidiers}, \link{xyz_tidiers},
#' \link{svd_tidiers}, \link{orcutt_tidiers}
#'
#' @name list_tidiers
#'
#' @export
tidy.list <- function(x, ...) {
  
  optim_elems <- c("par", "value", "counts", "convergence", "message")
  xyz_elems <- c("x", "y", "z")
  svd_elems <- c("d", "u", "v")
  orcutt_elems <- "Cochrane.Orcutt"
  
  if (all(optim_elems %in% names(x))) {
    tidy_optim(x, ...)
  } else if (all(xyz_elems %in% names(x))) {
    tidy_xyz(x, ...)
  } else if (all(svd_elems %in% names(x))) {
    tidy_svd(x, ...)
  } else if (all(orcutt_elems %in% names(x))) {
    tidy.orcutt(x, ...)
  } else {
    stop("No tidy method recognized for this list.", call. = FALSE)
  }
}

#' @rdname list_tidiers
#'
#' @export
glance.list <- function(x, ...) {
  
  optim_elems <- c("par", "value", "counts", "convergence", "message")
  orcutt_elms <- "Cochrane.Orcutt"
  
  if (all(optim_elems %in% names(x))) {
    glance_optim(x, ...)
  } else if (orcutt_elms %in% names(x)) {
    glance.orcutt(x, ...)
  } else {
    stop("No glance method recognized for this list.", call. = FALSE)
  }
}
