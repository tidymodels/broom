#' Tidying methods for singular value decomposition
#'
#' These methods tidy the U, D, and V matrices returned by the
#' \code{\link{svd}} function into a tidy format. Because
#' \code{svd} returns a list without a class, this function has to be
#' called by \code{\link{tidy.list}} when it recognizes a list as an
#' SVD object.
#' 
#' @return An SVD object contains a decomposition into u, d, and v matrices, such that
#' \code{u \%\*\% diag(d) \%\*\% t(v)} gives the original matrix. This tidier gives
#' a choice of which matrix to tidy.
#' 
#' When \code{matrix = "u"}, each observation represents one pair of row and
#' principal component, with variables:
#'   \item{row}{Number of the row in the original data being described}
#'   \item{PC}{Principal component}
#'   \item{loading}{Loading of this principal component for this row}
#' 
#' When \code{matrix = "d"}, each observation represents one principal component,
#' with variables:
#'   \item{PC}{Principal component}
#'   \item{d}{Value in the \code{d} vector}
#'   \item{percent}{Percent of variance explained by this PC, which is
#'   proportional to $d^2$}
#' 
#' When \code{matrix = "v"}, each observation represents a pair of a principal
#' component and a column of the original matrix, with variables:
#'   \item{column}{Column of original matrix described}
#'   \item{PC}{Principal component}
#'   \item{value}{Value of this PC for this column}
#'
#' @seealso \code{\link{svd}}, \code{\link{tidy.list}}
#'
#' @name svd_tidiers
#'
#' @param x list containing d, u, v components, returned from \code{svd}
#' @param matrix which of the u, d or v matrix to tidy
#' @param ... Extra arguments (not used)
#' 
#' @examples 
#' 
#' mat <- as.matrix(iris[, 1:4])
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
#'     ggplot(aes(Species, loading)) +
#'     geom_boxplot() +
#'     facet_wrap(~ PC, scale = "free_y")
tidy_svd <- function(x, matrix = "u", ...) {
    if (matrix == "u") {
        # change into a format with three columns:
        # row, column, loading
        ret <- x$u %>%
            reshape2::melt(varnames = c("row", "PC"), value.name = "loading")
        ret
    } else if (matrix == "d") {
        # return as a data.frame
        data.frame(PC = seq_along(x$d),
                   d = x$d,
                   percent = x$d ^ 2 / sum(x$d ^ 2))
    } else if (matrix == "v") {
        ret <- x$v %>%
            reshape2::melt(varnames = c("column", "PC"),
                           value.name = "loading")
        ret
    }
}
