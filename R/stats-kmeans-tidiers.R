#' @templateVar class kmeans
#' @template title_desc_tidy
#'
#' @param x A `kmeans` object created by [stats::kmeans()].
#' @param col.names Dimension names. Defaults to `x1, x2, ...`
#' @template param_unused_dots
#'
#' @return A [tibble::tibble] with one row per cluster, and columns:
#' 
#'   \item{size}{Number of points in cluster}
#'   \item{withinss}{The within-cluster sum of squares}
#'   \item{cluster}{A factor describing the cluster from 1:k}
#'
#' @details For examples, see the kmeans vignette.
#'
#' @aliases kmeans_tidiers
#' @export
#' @seealso [tidy()], [stats::kmeans()]
#' @family kmeans tidiers
tidy.kmeans <- function(x, col.names = paste0("x", 1:ncol(x$centers)), ...) {
  ret <- as.data.frame(x$centers)
  colnames(ret) <- col.names
  ret$size <- x$size
  ret$withinss <- x$withinss
  ret$cluster <- factor(seq_len(nrow(ret)))
  as_tibble(ret)
}


#' @templateVar class kmeans
#' @template title_desc_augment
#' 
#' @inheritParams tidy.kmeans
#' @template param_data
#'
#' @return The original data as a [tibble::tibble] with one extra column:
#' 
#'   \item{.cluster}{The cluster assigned by the k-means algorithm}
#'
#' @export
#' @seealso [augment()], [stats::kmeans()]
#' @family kmeans tidiers
augment.kmeans <- function(x, data, ...) {
  fix_data_frame(data, newcol = ".rownames") %>% 
    mutate(.cluster = factor(x$cluster))
}


#' @templateVar class kmeans
#' @template title_desc_glance
#' 
#' @inheritParams tidy.kmeans
#'
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{totss}{The total sum of squares}
#'   \item{tot.withinss}{The total within-cluster sum of squares}
#'   \item{betweenss}{The total between-cluster sum of squares}
#'   \item{iter}{The numbr of (outer) iterations}
#'
#' @export
#' @seealso [glance()], [stats::kmeans()]
#' @family kmeans tidiers
glance.kmeans <- function(x, ...) {
  as_tibble(x[c("totss", "tot.withinss", "betweenss", "iter")])
}
