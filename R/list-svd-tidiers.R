#' Tidying methods for singular value decomposition lists
#'
#' These methods tidy the U, D, and V matrices returned by the
#' [svd()] functions into a tidy format. Because `svd` returns
#' lists without classes, this function has to be called by
#' [tidy.list()] when it recognizes a list as an SVD.
#'
#' Note that SVD is only equivalent to PCA on centered data.
#'
#' @return An SVD object contains a decomposition into u, d, and v matrices,
#'  such that
#'  ```
#'  u %*% diag(d) %*% t(v)
#'  ```
#'  gives the original matrix. This tidier gives a choice of which matrix
#'  to tidy.
#'
#' When `matrix = "u"`, each observation represents one pair of row and
#' principal component, with variables:
#'   \item{row}{Number of the row in the original data being described}
#'   \item{PC}{Principal component}
#'   \item{value}{Loading of this principal component for this row}
#'
#' When `matrix = "d"`, each observation represents one principal component,
#' with variables:
#'   \item{`PC`}{An integer vector indicating the principal component}
#'   \item{`std.dev`}{Standard deviation explained by this PC}
#'   \item{`percent`}{Percentage of variation explained. This will be
#'     inaccurate for irlba objects due to the SVD truncation.}
#'   \item{`cumulative`}{Cumulative percentage of variation explained}
#'
#' When `matrix = "v"`, each observation represents a pair of a principal
#' component and a column of the original matrix, with variables:
#'   \item{column}{Column of original matrix described}
#'   \item{PC}{Principal component}
#'   \item{value}{Value of this PC for this column}
#'
#' @seealso [svd()], [irlba::irlba()], [tidy.list()], [tidy_irlba()]
#'
#' @name svd_tidiers
#'
#' @param x list containing d, u, v components, returned from `svd`
#' @param matrix which of the u, d or v matrix to tidy
#' @param ... Extra arguments (not used)
#'
#' @examples
#'
#' mat <- scale(as.matrix(iris[, 1:4]))
#' s <- svd(mat)
#'
#' tidy_u <- tidy(s, matrix = "u")
#' head(tidy_u)
#'
#' tidy_d <- tidy(s, matrix = "d")
#' tidy_d
#'
#' tidy_v <- tidy(s, matrix = "v")
#' head(tidy_v)
#'
#' library(ggplot2)
#' library(dplyr)
#'
#' ggplot(tidy_d, aes(PC, percent)) +
#'     geom_point() +
#'     ylab("% of variance explained")
#'
#' tidy_u %>%
#'     mutate(Species = iris$Species[row]) %>%
#'     ggplot(aes(Species, value)) +
#'     geom_boxplot() +
#'     facet_wrap(~ PC, scale = "free_y")
tidy_svd <- function(x, matrix = "u", ...) {
  if (length(matrix) > 1) {
    stop("Must specify a single matrix to tidy.")
  }

  if (matrix == "u") {
    ret <- reshape2::melt(x$u,
      varnames = c("row", "PC"),
      value.name = "value"
    )
  } else if (matrix == "d") {
    ret <- tibble(PC = seq_along(x$d), std.dev = x$d) %>%
      mutate(
        percent = std.dev^2 / sum(std.dev^2),
        cumulative = cumsum(percent)
      )
  } else if (matrix == "v") {
    ret <- reshape2::melt(x$v,
      varnames = c("column", "PC"),
      value.name = "value"
    )
  }
  as_tibble(ret)
}
