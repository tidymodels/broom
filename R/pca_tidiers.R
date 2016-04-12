#' Tidying methods for PCA objects
#' 
#' These methods summarize the results of principal component analysis into three
#' tidy forms. \code{tidy} describes the principal components,
#' \code{augment} adds the principal component scores to the original data, and
#' \code{glance} summarizes the standard deviation and propotions.
#'
#' @param x prcomp object
#' @param data Original data (required for \code{augment})
#' @param ... extra arguments, not used
#'
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#'
#' @seealso \code{\link{prcomp}}
#'
#' @examples
#' 
#' library(dplyr)
#' library(ggplot2)
#' 
#' pca <- prcomp(iris[-5])
#' tidy(pca)
#' head(augment(pca, iris[-5]))
#' glance(pca)
#' 
#' @name pca_tidiers
#' 
NULL


#' @rdname pca_tidiers
#' 
#' @return \code{tidy} returns principal components
#' 
#' @export
tidy.prcomp <- function(x, ...) {
    ret <- as.data.frame(x$rotation)
    fix_data_frame(ret, newcol = ".rownames")
}


#' @rdname pca_tidiers
#' 
#' @return \code{augment} returns the original data with principal component scores
#' 
#' @export
augment.prcomp <- function(x, data, ...) {
    # move rownames if necessary
    data <- fix_data_frame(data, newcol = ".rownames")
    components <- as.data.frame(x$x)
    cbind(as.data.frame(data), components)
}


#' @rdname pca_tidiers
#' 
#' @return \code{glance} returns a one-row data.frame with the columns
#'   \item{Standard deviation}
#'   \item{Proportion of Variance}
#'   \item{Cumulative Proportion}
#' 
#' @export
glance.prcomp <- function(x, ...) {
    vars <- x$sdev^2
    vars <- vars / sum(vars)
    ret <- data.frame(c1 = colnames(x$x), c2 = x$sdev, c3 = vars, c4 = cumsum(vars),
                      stringsAsFactors = FALSE)
    colnames(ret) = c('.rownames', 'Standard deviation', 'Proportion of Variance', 'Cumulative Proportion')
    ret
}
