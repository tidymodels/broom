#' Tidiers for x, y, z lists suitable for persp, image, etc.
#' 
#' Tidies lists with components x, y (vector of coordinates) and z (matrix of
#' values) which are typically used by functions such as
#' \code{\link[graphics]{persp}} or \code{\link[graphics]{image}} and returned
#' by interpolation functions such as \code{\link[akima]{interp}}.
#' 
#' @param x list with components x, y and z
#' @param ... extra arguments
#' 
#' @template boilerplate
#' 
#' @return \code{tidy} returns a data frame with columns x, y and z and one row
#' per value in matrix z.
#' 
#' @examples 
#' 
#' A <- list(x=1:5, y=1:3, z=matrix(runif(5*3), nrow=5))
#' image(A)
#' tidy(A)
#' 
#' @name xyz_tidiers
#' @importFrom reshape2 melt
tidy_xyz <- function(x, ...) {
    # convert to data.frame
    d <- melt(x$z)
    names(d) <- c("x", "y", "z")
    # get coordinates
    d$x <- x$x[d$x]
    d$y <- x$y[d$y]
    return(d)
}
