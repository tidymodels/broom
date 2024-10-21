#' @templateVar class xyz
#' @template title_desc_tidy_list
#'
#' @description xyz lists (lists where `x` and `y` are vectors of coordinates
#'   and `z` is a matrix of values) are typically used by functions such as
#'   [graphics::persp()] or [graphics::image()] and returned
#'   by interpolation functions such as [interp::interp()].
#'
#' @param x A list with component `x`, `y` and `z`, where `x` and `y` are
#'   vectors and `z` is a matrix. The length of `x` must equal the number of
#'   rows in `z` and the length of `y` must equal the number of columns in `z`.
#' @template param_unused_dots
#'
#' @return A [tibble::tibble] with vector columns `x`, `y` and `z`.
#'
#' @examples
#'
#' A <- list(x = 1:5, y = 1:3, z = matrix(runif(5 * 3), nrow = 5))
#' image(A)
#' tidy(A)
#' @aliases xyz_tidiers
#' @family list tidiers
#' @seealso [tidy()], [graphics::persp()], [graphics::image()],
#'   [interp::interp()]
#'
tidy_xyz <- function(x, ...) {
  if (!is.matrix(x$z)) {
    cli::cli_abort("{.arg z} must be a matrix.")
  }

  if (length(x$x) != nrow(x$z) || length(x$y) != ncol(x$z)) {
    cli::cli_abort(c(
      "To tidy an xyz list, the length of element {.code x} must equal the
       number of rows of element {.code z}, and the length of element
       {.code y} must equal the number of columns of element {.code z}."
    ))
  }

  as_tibble(data.frame(
    x = x$x,
    y = rep(x$y, each = length(x$x)),
    z = as.numeric(x$z)
  ))
}
