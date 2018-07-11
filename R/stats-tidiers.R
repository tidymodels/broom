#' @templateVar class ftable
#' @template title_desc_tidy
#'
#' @param x An `ftable` object returned from [stats::ftable()].
#' @template param_unused_dots
#' 
#' @return An ftable contains a "flat" contingency table. This melts it into a
#'   [tibble::tibble] with one column for each variable, then a `Freq`
#'   column.
#'
#' @examples
#'
#' tidy(ftable(Titanic, row.vars = 1:3))
#'
#' @export
#' @seealso [tidy()], [stats::ftable()]
#' @family stats tidiers
tidy.ftable <- function(x, ...) {
  as_tibble(x)
}

#' @templateVar class density
#' @template title_desc_tidy
#'
#' @param x A `density` object returned from [stats::density()].
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with two columns: points `x` where the density
#'   is estimated, and estimated density `y`.
#'
#' @export
#' @seealso [tidy()], [stats::density()]
#' @family stats tidiers
tidy.density <- function(x, ...) {
  
  # TODO: what happens when `x` has more than one dimension??
  
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
#' @return A [tibble::tibble] with one row for each pair of items in the 
#'   distance matrix, with columns:
#' 
#'   \item{item1}{First item}
#'   \item{item2}{Second item}
#'   \item{distance}{Distance between items}
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

  ret <- reshape2::melt(m,
    varnames = c("item1", "item2"),
    value.name = "distance"
  )

  if (!upper) {
    ret <- ret[!upper.tri(m), ]
  }

  if (!diagonal) {
    ret <- filter(ret, item1 != item2)
  }
  as_tibble(ret)
}




