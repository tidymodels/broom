#' tidy an ftable object
#'
#' An ftable contains a "flat" contingency table. This melts it into a
#' data.frame with one column for each variable, then a `Freq`
#' column. It directly uses the `stats:::as.data.frame.ftable` function
#'
#' @param x An object of class "ftable"
#' @param ... Extra arguments (not used)
#'
#' @examples
#'
#' tidy(ftable(Titanic, row.vars = 1:3))
#'
#' @seealso [ftable()]
#'
#' @export
tidy.ftable <- function(x, ...) {
  as_tibble(x)
}


#' tidy a density objet
#'
#' Given a "density" object, returns a tidy data frame with two
#' columns: points x where the density is estimated, points y
#' for the estimate
#'
#' @param x an object of class "density"
#' @param ... extra arguments (not used)
#'
#' @return a data frame with "x" and "y" columns
#'
#' d <- density(faithful$eruptions, bw = "sj")
#' tidy(d)
#'
#' library(ggplot2)
#' ggplot(tidy(d), aes(x, y)) + geom_line()
#'
#' @seealso [density()]
#'
#' @export
tidy.density <- function(x, ...) {
  as_tibble(x[c("x", "y")])
}


#' Tidy a distance matrix
#'
#' Tidy a distance matrix, such as that computed by the \link{dist}
#' function, into a one-row-per-pair table. If the distance matrix
#' does not include an upper triangle and/or diagonal, this will
#' not either.
#'
#' @param x A "dist" object
#' @param diagonal Whether to include the diagonal of the distance
#' matrix. Defaults to whether the distance matrix includes it
#' @param upper Whether to include the upper right triangle of
#' the distance matrix. Defaults to whether the distance matrix
#' includes it
#' @param ... Extra arguments, not used
#'
#' @return A data frame with one row for each pair of
#' item distances, with columns:
#' \describe{
#'   \item{item1}{First item}
#'   \item{item2}{Second item}
#'   \item{distance}{Distance between items}
#' }
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
    # filter out the diagonal
    ret <- filter(ret, item1 != item2)
  }
  as_tibble(ret)
}




