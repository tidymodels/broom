#' @templateVar class pam
#' @template title_desc_tidy
#'
#' @param x An `pam` object returned from [cluster::pam()]
#' @param col.names Column names in the input data frame.
#'   Defaults to the names of the variables in x.
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   size = "Size of each cluster.",
#'   max.diss = "Maximal dissimilarity between the observations in the 
#'     cluster and that cluster's medoid.",
#'   avg.diss = "Average dissimilarity between the observations in the 
#'     cluster and that cluster's medoid.",
#'   diameter = "Diameter of the cluster.",
#'   separation = "Separation of the cluster.",
#'   avg.width = "Average silhouette width of the cluster.",
#'   cluster = "A factor describing the cluster from 1:k."
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
#' \dontrun{
#' library(dplyr)
#' library(ggplot2)
#' library(cluster)
#' library(modeldata)
#' data(hpc_data)
#' 
#' x <- hpc_data[, 2:5]
#' p <- pam(x, k = 4)
#'
#' tidy(p)
#' glance(p)
#' augment(p, x)
#'
#' augment(p, x) %>%
#'   ggplot(aes(compounds, input_fields)) +
#'   geom_point(aes(color = .cluster)) +
#'   geom_text(aes(label = cluster), data = tidy(p), size = 10)
#' }   
#'   
tidy.pam <- function(x, col.names = paste0("x", 1:ncol(x$medoids)), ...) {
  as_tibble(x$clusinfo) %>%
    mutate(
      avg.width = x$silinfo$clus.avg.widths,
      cluster = as.factor(row_number())
    ) %>%
    bind_cols(as_tibble(x$medoids)) %>%
    rename(
      "max.diss" = "max_diss",
      "avg.diss" = "av_diss"
    )
}

#' @templateVar class pam
#' @template title_desc_augment
#'
#' @inherit tidy.pam params examples
#' @template param_data
#'
#' @evalRd return_augment(".cluster")
#'
#' @export
#' @seealso [augment()], [cluster::pam()]
#' @family pam tidiers
#'
augment.pam <- function(x, data = NULL, ...) {
  if (is.null(data)) {
    data <- x$data
  }

  as_augment_tibble(data) %>%
    mutate(.cluster = as.factor(!!x$clustering))
}


#' @templateVar class pam
#' @template title_desc_glance
#'
#' @inherit tidy.pam params examples
#'
#' @evalRd return_glance("avg.silhouette.width")
#'
#' @export
#' @seealso [glance()], [cluster::pam()]
#' @family pam tidiers
glance.pam <- function(x, ...) {
  as_glance_tibble(
    avg.silhouette.width = x$silinfo$avg.width,
    na_types = "r"
  )
}
