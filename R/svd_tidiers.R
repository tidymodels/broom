#' Tidying methods for (truncated) singular value decomposition
#'
#' These methods tidy the U, D, and V matrices returned by the
#' \code{\link{svd}} or \code{\link[irlba]{irlba}} functions into a tidy format.
#' Because \code{svd} and \code{irlba} return lists without classes, this function
#' has to be called by \code{\link{tidy.list}} when it recognizes a list as an
#' SVD or \code{irlba} object.
#'
#' Note that SVD is only equivalent to PCA on centered data.
#'
#' @return An SVD object contains a decomposition into u, d, and v matrices, such that
#' \code{u \%\*\% diag(d) \%\*\% t(v)} gives the original matrix. This tidier gives
#' a choice of which matrix to tidy.
#'
#' When \code{matrix = "u"}, each observation represents one pair of row and
#' principal component, with variables:
#'   \item{row}{Number of the row in the original data being described}
#'   \item{PC}{Principal component}
#'   \item{value}{Loading of this principal component for this row}
#'
#' When \code{matrix = "d"}, each observation represents one principal component,
#' with variables:
#'   \item{\code{PC}}{An integer vector indicating the principal component}
#'   \item{\code{std.dev}}{Standard deviation explained by this PC}
#'   \item{\code{percent}}{Percentage of variation explained. This will be
#'     inaccurate for irlba objects due to the SVD truncation.}
#'   \item{\code{cumulative}}{Cumulative percentage of variation explained}
#'
#' When \code{matrix = "v"}, each observation represents a pair of a principal
#' component and a column of the original matrix, with variables:
#'   \item{column}{Column of original matrix described}
#'   \item{PC}{Principal component}
#'   \item{value}{Value of this PC for this column}
#'
#' @seealso \code{\link{svd}}, \code{\link[irlba]{irlba}} \code{\link{tidy.list}}
#'
#' @name svd_tidiers
#'
#' @param x list containing d, u, v components, returned from \code{svd} or
#'   \code{irlba}
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
