#' @templateVar class ftable
#' @template title_desc_tidy
#' 
#' @description This function is deprecated. Please use [tibble::as_tibble()] instead.
#'
#' @param x An `ftable` object returned from [stats::ftable()].
#' @template param_unused_dots
#' 
#' @return An ftable contains a "flat" contingency table. This melts it into a
#'   [tibble::tibble] with one column for each variable, then a `Freq`
#'   column.
#'
#' @export
#' @seealso [tidy()], [stats::ftable()]
#' @family stats tidiers
tidy.ftable <- function(x, ...) {
  .Deprecated()
  as_tibble(x)
}

#' @templateVar class density
#' @template title_desc_tidy
#'
#' @param x A `density` object returned from [stats::density()].
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with two columns: points `x` where the density
#'   is estimated, and estimated density `y`. When the input to the [stats::density()]
#' function is an `nXm` matrix, as opposed to a `1Xm` vector, the input matrix is first flattened into a `1X(m*n)` vector
#' and then the density function is applied as usual.

#' @export
#' @seealso [tidy()], [stats::density()]
#' @family stats tidiers
tidy.density <- function(x, ...) {
  as_tibble(x[c("x", "y")])
}

#' @templateVar class dist
#' @template title_desc_tidy
#' 
#' @param x A `dist` object returned from [stats::dist()].
#' @param diagonal Logical indicating whether or not to tidy the diagonal 
#'   elements of the distance matrix. Defaults to whatever was based to the
#'   `diag` argument of [stats::dist()].
#' @param upper Logical indicating whether or not to tidy the upper half of
#'   the distance matrix. Defaults to whatever was based to the
#'   `upper` argument of [stats::dist()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy("item1", "item2", "distance")
#' 
#' @details If the distance matrix does not include an upper triangle and/or
#'   diagonal, the tidied version will not either.
#' 
#' @examples
#'
#' iris_dist <- dist(t(iris[, 1:4]))
#' iris_dist
#'
#' tidy(iris_dist)
#' tidy(iris_dist, upper = TRUE)
#' tidy(iris_dist, diagonal = TRUE)
#'
#' @export
#' @seealso [tidy()], [stats::dist()]
#' @family stats tidiers
#' 
tidy.dist <- function(x, diagonal = attr(x, "Diag"),
                      upper = attr(x, "Upper"), ...) {
  m <- as.matrix(x)

  ret <- as_tibble(m, rownames = 'item1')
  ret <- tidyr::gather(ret, item2, distance, -item1)
  
  if (!upper) {
    ret <- ret[!upper.tri(m), ]
  }

  if (!diagonal) {
    ret <- dplyr::filter(ret, item1 != item2)
  }
  
  ret

}




