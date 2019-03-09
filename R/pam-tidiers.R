' Tidying methods for pam objects
#' 
#' These methods summarize the results of Partitioning Around Medoids (PAM) clustering into three
#' tidy forms. `tidy` describes the medoid and size of each cluster,
#' `augment` adds the cluster assignments to the original data, and
#' `glance` summarizes the average silhouette with of the clustering.
#'
#' @templateVar class pam
#' @template title_desc_tidy
#' 
#' @param x An `pam` object returned from [cluster::pam()]
#' @param col.names Dimension names. Defaults to the names of the variables in x.  Set to NULL to get names `x1, x2, ...`.
#' @template param_unused_dots
#' 
#' @evalRd return_tidy(
#'   size = "The size of each cluster",
#'   max_diss ="The maximal dissimilarity between the observations in the cluster and the cluster's medoid",
#'   av_diss= "The average dissimilarity between the observations in the cluster and the cluster's medoid", 
#'   diameter="The diameter of the cluster",
#'   separation="The separation of the cluster",
#'   avg.width="The average silhouette width of the cluster",
#'   cluster= "A factor describing the cluster from 1:k"
#'
#' )
#'
#' @details For examples, see the pam vignette.
#'
#' @aliases pam_tidiers
#' @export
#' @seealso [tidy()], [cluster::pam()]
#' @family pam tidiers
#' @examples
#' 
#' library(dplyr)
#' library(ggplot2)
#' library(cluster)
#' 
#' x<- iris %>%select(-Species)
#' p<-pam(x, k = 3)
#' 
#' tidy(p)
#' glance(p)
#'augment(p,x)
#'ggplot(augment(p,x), aes(Sepal.Length, Sepal.Width)) + geom_point(aes(color = .cluster)) +geom_text(aes(label = cluster), data = tidy(p), size = 10)

tidy.pam <- function(x, col.names=paste0("x", 1:ncol(x$medoids)), ...) {
  ret <- bind_cols(as_broom_tibble(p$medoids), as_broom_tibble(p$clusinfo))
  ret %>% mutate(avg.width = x$silinf$clus.avg.widths,
                 cluster = factor(seq_len(nrow(ret))))
}



#' @templateVar class pam
#' @template title_desc_augment
#' 
#' @inherit tidy.pam params examples
#' @template param_data
#'
#' @evalRd return_augment(
#'   .cluster= "cluster"
#' )
#'
#' @export
#' @seealso [augment()], [cluster::pam()]
#' @family pam tidiers
#' 
augment.pam <- function(x, data, ...) {
  # move rownames if necessary
  data <- as_broom_tibble(data)
  
  # show cluster assignment as a factor (it's not numeric)
  add_column(data, .cluster = as.factor(!!x$clustering))
}


#' @templateVar class kmeans
#' @template title_desc_glance
#' 
#' @inherit tidy.kmeans params examples
#'
#' @evalRd return_glance(avg.width = "average width of a cluster")
#'
#' @export
#' @seealso [glance()], [cluster::pam()]
#' @family pam tidiers
glance.pam <- function(x, ...) {
  ret <- tibble(avg.width = x$silinfo$avg.width)
  ret
}
