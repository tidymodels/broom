#' Tidiers for return values from functions that aren't S3 objects
#' 
#' This method handles the return values of functions that return lists
#' rather than S3 objects, such as \code{optim}, \code{svd}, or
#' \code{\link[akima]{interp}}, and therefore cannot be handled by
#' S3 dispatch.
#' 
#' @param x list object
#' @param ... extra arguments, passed to the tidying function
#' 
#' @details Those tiders themselves are implemented as functions of the
#' form tidy_<function> or glance_<function> that are not exported.
#' 
#' @seealso \link{optim_tidiers}, \link{xyz_tidiers},
#' \link{svd_tidiers}, \link{orcutt_tidiers}
#' 
#' @name list_tidiers
#' 
#' @export
tidy.list <- function(x, ...) {
    if (all(c("par", "value", "counts", "convergence", "message")
                   %in% names(x))) {
        # returned from optim
        tidy_optim(x, ...)
    } else if (all(c("x", "y", "z") %in% names(x)) & is.matrix(x$z)) {
        if ( length(x$x) != nrow(x$z) ) {
            stop("The list looks like an x,y,z list but is not. Element x of the list needs to be the same length as the number of rows of element z")
        }
        if ( length(x$y) != ncol(x$z) ) {
            stop("The list looks like an x,y,z list but is not. Element y of the list needs to be the same length as the number of columns of element z")
        }
        # xyz list suitable for persp, image, etc.
        tidy_xyz(x, ...)
    } else if (all(sort(names(x)) == c("d", "u", "v"))) {
        tidy_svd(x, ...)
    } else if ("Cochrane.Orcutt" %in% names(x)) {
        tidy_orcutt(x, ...)
    } else {
        stop("No tidying method recognized for this list")
    }
}


#' @rdname list_tidiers
#' 
#' @export
glance.list <- function(x, ...) {
    if (all(c("par", "value", "counts", "convergence", "message") %in% names(x))) {
        glance_optim(x, ...)
    } else if ("Cochrane.Orcutt" %in% names(x)) {
        glance_orcutt(x, ...)
    } else {
        stop("No glance method recognized for this list")
    }
}
