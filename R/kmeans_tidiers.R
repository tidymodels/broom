#' Tidying methods for kmeans objects
#' 
#' These methods summarize the results of k-means clustering into three
#' tidy forms. \code{tidy} describes the center and size of each cluster,
#' \code{augment} adds the cluster assignments to the original data, and
#' \code{glance} summarizes the total within and between sum of squares
#' of the clustering.
#'
#' @param x kmeans object
#' @param data Original data (required for \code{augment})
#' @param col.names The names to call each dimension of the data in \code{tidy}.
#' Defaults to \code{x1, x2...}
#' @param ... extra arguments, not used
#'
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#'
#' @seealso \code{\link{kmeans}}
#'
#' @examples
#' 
#' library(dplyr)
#' library(ggplot2)
#' 
#' set.seed(2014)
#' centers <- data.frame(cluster=factor(1:3), size=c(100, 150, 50),
#'                       x1=c(5, 0, -3), x2=c(-1, 1, -2))
#' points <- centers %>% group_by(cluster) %>%
#'  do(data.frame(x1=rnorm(.$size[1], .$x1[1]),
#'                x2=rnorm(.$size[1], .$x2[1])))
#'
#' k <- kmeans(points %>% dplyr::select(x1, x2), 3)
#' tidy(k)
#' head(augment(k, points))
#' glance(k)
#' 
#' ggplot(augment(k, points), aes(x1, x2)) +
#'     geom_point(aes(color = .cluster)) +
#'     geom_text(aes(label = cluster), data = tidy(k), size = 10)
#'
#' @name kmeans_tidiers
#' 
NULL


#' @rdname kmeans_tidiers
#' 
#' @return \code{tidy} returns one row per cluster, with one column for each
#' dimension in the data describing the center, followed by
#'   \item{size}{The size of each cluster}
#'   \item{withinss}{The within-cluster sum of squares}
#'   \item{cluster}{A factor describing the cluster from 1:k}
#' 
#' @export
tidy.kmeans <- function(x, col.names=paste0("x", 1:ncol(x$centers)), ...) {
    ret <- data.frame(x$centers)
    colnames(ret) <- col.names
    ret$size <- x$size
    ret$withinss <- x$withinss
    ret$cluster <- factor(seq_len(nrow(ret)))
    ret
}


#' @rdname kmeans_tidiers
#' 
#' @return \code{augment} returns the original data with one extra column:
#'   \item{.cluster}{The cluster assigned by the k-means algorithm}
#' 
#' @export
augment.kmeans <- function(x, data, ...) {
    # move rownames if necessary
    data <- fix_data_frame(data, newcol = ".rownames")
    
    # show cluster assignment as a factor (it's not numeric)
    cbind(as.data.frame(data), .cluster = factor(x$cluster))
}


#' @rdname kmeans_tidiers
#' 
#' @return \code{glance} returns a one-row data.frame with the columns
#'   \item{totss}{The total sum of squares}
#'   \item{tot.withinss}{The total within-cluster sum of squares}
#'   \item{betweenss}{The total between-cluster sum of squares}
#'   \item{iter}{The numbr of (outer) iterations}
#' 
#' @export
glance.kmeans <- function(x, ...) {
    ret <- as.data.frame(x[c("totss", "tot.withinss", "betweenss", "iter")])
    ret
}
