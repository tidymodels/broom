#' @templateVar class Mclust
#' @template title_desc_tidy
#'
#' @param x An `Mclust` object return from [mclust::Mclust()].
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with one row per component:
#'   \item{component}{Cluster id as a factor. For a model `k` clusters, these
#'     will be `as.factor(1:k)`, or `as.factor(0:k)` if there's a noise term.}
#'   \item{size}{Number of observations assigned to component}
#'   \item{proportion}{The mixing proportion of each component}
#'   \item{variance}{In case of one-dimensional and spherical models,
#'     the variance for each component, omitted otherwise. NA for noise
#'     component}
#'   \item{mean}{The mean for each component. In case of 2+ dimensional models,
#'     a column with the mean is added for each dimension. NA for noise
#'     component}
#'
#' @examples
#'
#' library(dplyr) 
#' library(mclust)
#' set.seed(27)
#' 
#' centers <- tibble::tibble(
#'   cluster = factor(1:3), 
#'   num_points = c(100, 150, 50),  # number points in each cluster
#'   x1 = c(5, 0, -3),              # x1 coordinate of cluster center
#'   x2 = c(-1, 1, -2)              # x2 coordinate of cluster center
#' )
#' 
#' points <- centers %>%
#'   mutate(
#'     x1 = purrr::map2(num_points, x1, rnorm),
#'     x2 = purrr::map2(num_points, x2, rnorm)
#'   ) %>% 
#'   select(-num_points, -cluster) %>%
#'   tidyr::unnest(x1, x2)
#'
#' m <- mclust::Mclust(points)
#'
#' tidy(m)
#' augment(m, points)
#' glance(m)
#' 
#' @export
#' @aliases mclust_tidiers
#' @seealso [tidy()], [mclust::Mclust()]
#' @family mclust tidiers
#' 
tidy.Mclust <- function(x, ...) {
  np <- max(x$G, length(table(x$classification)))
  ret <- data.frame(seq_len(np))
  colnames(ret) <- c("component")
  if (x$G < np) ret$component <- ret$component - 1
  ret$size <- sapply(seq(1, np), function(c) {
    sum(x$classification == c)
  })
  ret$proportion <- x$parameters$pro
  if (x$modelName %in% c("E", "V", "EII", "VII")) {
    ret$variance <- rep_len(x$parameters$variance$sigmasq, length.out = x$G)
  }
  if (dim(as.matrix(x$parameters$mean))[2] > 1) {
    mean <- t(x$parameters$mean)
  } else {
    mean <- t(as.matrix(x$parameters$mean))
  }
  ret <- cbind(ret, mean = rbind(matrix(, np - nrow(mean), ncol(mean)), mean))
  as_tibble(ret)
}


#' @templateVar class Mclust
#' @template title_desc_augment
#' 
#' @inheritParams tidy.Mclust
#' @template param_data
#'
#' @return A [tibble::tibble] of the original data with two extra columns:
#'   \item{.class}{The class assigned by the Mclust algorithm}
#'   \item{.uncertainty}{The uncertainty associated with the classification.
#'     If a point has a probability of 0.9 of being in its assigned class
#'     under the model, then the uncertainty is 0.1.}
#'
#' @export
#' @seealso [augment()], [mclust::Mclust()]
#' @family mclust tidiers
#' 
augment.Mclust <- function(x, data, ...) {
  fix_data_frame(data, newcol = ".rownames") %>% 
    mutate(
      .class = factor(x$classification),
      .uncertainty = x$uncertainty
    )
}


#' @templateVar class Mclust
#' @template title_desc_glance
#' 
#' @inheritParams tidy.Mclust
#'
#' @return A one-row [tibble::tibble] with columns:
#'   \item{model}{A character string denoting the model at which the optimal
#'     BIC occurs}
#'   \item{n}{The number of observations in the data}
#'   \item{G}{The optimal number of mixture components}
#'   \item{BIC}{The optimal BIC value}
#'   \item{logLik}{The log-likelihood corresponding to the optimal BIC}
#'   \item{df}{The number of estimated parameters}
#'   \item{hypvol}{If the other model contains a noise component, the 
#'     value of the hypervolume parameter. Otherwise `NA`.}
#'
#' @export
glance.Mclust <- function(x, ...) {
  with(
    x,
    tibble(
      model = modelName,
      n,
      G,
      BIC = bic, 
      logLik = loglik,
      df,
      hypvol
    )
  )
}
