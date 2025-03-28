#' @templateVar class kmeans
#' @template title_desc_tidy
#'
#' @param x A `kmeans` object created by [stats::kmeans()].
#' @param col.names Dimension names. Defaults to the names of the variables
#'   in x.  Set to NULL to get names `x1, x2, ...`.
#' @template param_unused_dots
#'
#' @evalRd return_tidy("size", "withinss", "cluster")
#'
# skip running examples - occasionally over CRAN check time limit
#' @examplesIf FALSE
#'
#' library(cluster)
#' library(modeldata)
#' library(dplyr)
#'
#' data(hpc_data)
#'
#' x <- hpc_data[, 2:5]
#'
#' fit <- pam(x, k = 4)
#'
#' tidy(fit)
#' glance(fit)
#' augment(fit, x)
#'
#' @aliases kmeans_tidiers
#' @export
#' @seealso [tidy()], [stats::kmeans()]
#' @family kmeans tidiers
tidy.kmeans <- function(x, col.names = colnames(x$centers), ...) {
  if (is.null(col.names)) {
    col.names <- paste0("x", 1:ncol(x$centers))
  }
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
#' @inherit tidy.kmeans params examples
#' @template param_data
#'
#' @evalRd return_augment(
#'   ".cluster",
#'   .fitted = FALSE,
#'   .resid = FALSE
#' )
#'
#' @export
#' @seealso [augment()], [stats::kmeans()]
#' @family kmeans tidiers
augment.kmeans <- function(x, data, ...) {
  check_ellipses("newdata", "augment", "kmeans", ...)

  # kmeans allows for input matrices without column names,
  # so add them in the same way that fix_data_frame() would have
  if (inherits(data, "matrix") & is.null(colnames(data))) {
    colnames(data) <- paste0("X", 1:ncol(data))
  }

  as_augment_tibble(data) %>%
    mutate(.cluster = as.factor(!!x$cluster))
}


#' @templateVar class kmeans
#' @template title_desc_glance
#'
#' @inherit tidy.kmeans params examples
#'
#' @evalRd return_glance("totss","tot.withinss", "betweenss", "iter")
#'
#' @export
#' @seealso [glance()], [stats::kmeans()]
#' @family kmeans tidiers
glance.kmeans <- function(x, ...) {
  as_tibble(x[c("totss", "tot.withinss", "betweenss", "iter")])
}
