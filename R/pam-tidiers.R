' Tidying methods for pam objects
#' 
#' These methods summarize the results of Partitioning Around Medoids (PAM) clustering into three
#' tidy forms. \code{tidy} describes the medoid and size of each cluster,
#' \code{augment} adds the cluster assignments to the original data, and
#' \code{glance} summarizes the average silhouette with of the clustering.
#'
#' @param x pam object
#' @param data Original data (required for \code{augment})
#' @param col.names The names to call each dimension of the data in \code{tidy}.
#' Defaults to \code{x1, x2...}
#' @param ... extra arguments, not used
#'
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#'
#' @seealso \code{\link{pam}}
#'
#' @examples
#' 
library(dplyr)
library(ggplot2)
library(cluster)

set.seed(2014)
centers <- data.frame(cluster=factor(1:3), size=c(100, 150, 50),
                      x1=c(5, 0, -3), x2=c(-1, 1, -2))
points <- centers %>% group_by(cluster) %>%
 do(data.frame(x1=rnorm(.$size[1], .$x1[1]),
               x2=rnorm(.$size[1], .$x2[1])))

p <- pam(points[,c("x1","x2")], 3)
tidy(p)
head(augment(p, points))
glance(p)

ggplot(augment(p, points), aes(x1, x2)) +
    geom_point(aes(color = .cluster)) +
    geom_text(aes(label = cluster), data = tidy(p), size = 10)

#@name pam_tidiers

NULL


#' @rdname pam_tidiers
#' 
#' @return \code{tidy} returns one row per cluster, with one column for each
#' dimension in the data describing the center, followed by
#'   \item{size}{The size of each cluster}
#'   \item{max_diss}{The maximal dissimilarity between the observations in the cluster and the cluster's medoid}
#'   \item{av_diss}{The average dissimilarity between the observations in the cluster and the cluster's medoid}
#'   \item{diamter}{The diameter of the cluster}
#'   \item{separation}{The separation of the cluster}
#'   \item{avg.width}{The average silhouette width of the cluster}
#'   \item{cluster}{A factor describing the cluster from 1:k}
#' 
#' @export
tidy.pam <- function(x, col.names=paste0("x", 1:ncol(x$medoids)), ...) {
  ret <- bind_cols(as_broom_tibble(p$medoids), as_broom_tibble(p$clusinfo))
  ret %>% mutate(avg.width = x$silinf$clus.avg.widths,
                 cluster = factor(seq_len(nrow(ret))))
}



#' @rdname pam_tidiers
#' 
#' @return \code{augment} returns the original data with one extra column:
#'   \item{.cluster}{The cluster assigned by the pam algorithm}
#' 
#' @export
augment.pam <- function(x, data, ...) {
  # move rownames if necessary
  data <- rownames_to_column(as_broom_tibble(data))
  
  # show cluster assignment as a factor (it's not numeric)
  add_column(data, .cluster = factor(x$clustering))
}


#' @rdname pam_tidiers
#' 
#' @return \code{glance} returns a one-row data.frame with the columns
#'   \item{avg.width}{The average silhouette width for the dataset}
#' 
#' @export
glance.pam <- function(x, ...) {
  ret <- tibble(avg.width = x$silinfo$avg.width)
  ret
}
