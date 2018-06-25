#' Tidiers for x, y, z lists suitable for persp, image, etc.
#'
#' Tidies lists with components x, y (vector of coordinates) and z (matrix of
#' values) which are typically used by functions such as
#' [graphics::persp()] or [graphics::image()] and returned
#' by interpolation functions such as [akima::interp()].
#'
#' @param x list with components x, y and z
#' @param ... extra arguments
#'
#' @template boilerplate
#'
#' @return `tidy` returns a data frame with columns x, y and z and one row
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
  
  if (!is.matrix(x$z)) {
    stop("To tidy an xyz list, `z` must be a matrix.", call. = FALSE)
  }
  
  if (length(x$x) != nrow(x$z) || length(x$y) != ncol(x$z)) {
    stop(
      "To tidy an xyz list, the length of element `x` must equal the number ",
      "the number of rows of element `z`, and the length of element `y` must ",
      "equal the number of columns of element `z`.",
      call. = FALSE
    )
  }
  
  # convert to data.frame
  d <- melt(x$z)
  names(d) <- c("x", "y", "z")
  # get coordinates
  d$x <- x$x[d$x]
  d$y <- x$y[d$y]
  as_tibble(d)
}
