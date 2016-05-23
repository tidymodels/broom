#' Tidying methods for Mclust objects
#' 
#' These methods summarize the results of Mclust clustering into three
#' tidy forms. \code{tidy} describes the size, mixing probability, mean
#' and variabilty of each class, \code{augment} adds the class assignments and
#' their probabilities to the original data, and
#' \code{glance} summarizes the model parameters of the clustering.
#'
#' @param x Mclust object
#' @param data Original data (required for \code{augment})
#' @param ... extra arguments, not used
#'
#' @template boilerplate
#'
#' @seealso \code{\link[mclust]{Mclust}}
#'
#' @examples
#' 
#' library(dplyr)
#' library(ggplot2)
#' library(mclust)
#' 
#' set.seed(2016)
#' centers <- data.frame(cluster=factor(1:3), size=c(100, 150, 50),
#'                       x1=c(5, 0, -3), x2=c(-1, 1, -2))
#' points <- centers %>% group_by(cluster) %>%
#'  do(data.frame(x1=rnorm(.$size[1], .$x1[1]),
#'                x2=rnorm(.$size[1], .$x2[1]))) %>%
#'  ungroup()
#' 
#' m = Mclust(points %>% dplyr::select(x1, x2))
#' 
#' tidy(m)
#' head(augment(m, points))
#' glance(m)
#'
#' @name mclust_tidiers
#' 
NULL


#' @rdname mclust_tidiers
#' 
#' @return \code{tidy} returns one row per component, with 
#'   \item{component}{A factor describing the cluster from 1:k
#'   (or 0:k in presence of a noise term in x)}
#'   \item{size}{The size of each component}
#'   \item{proportion}{The mixing proportion of each component}
#'   \item{variance}{In case of one-dimensional and spherical models,
#'   the variance for each component, omitted otherwise. NA for noise component}
#'   \item{mean}{The mean for each component. In case of two- or more dimensional models,
#'   a column with the mean is added for each dimension. NA for noise component}
#' 
#' @export
tidy.Mclust <- function(x, ...) {
    np = max(x$G,length(table(x$classification)))
    ret = data.frame(seq_len(np))
    colnames(ret) = c("component")
    if(x$G < np) ret$component = ret$component-1
    ret$size = sapply(seq(1,np), function(c) { sum(x$classification == c)})
    ret$proportion = x$parameters$pro
    if(x$modelName %in% c("E","V","EII","VII")) {
        ret$variance = rep_len(x$parameters$variance$sigmasq, length.out = x$G)
    }
    if(dim(as.matrix(x$parameters$mean))[2] > 1) {
        mean = t(x$parameters$mean)
    }else{
        mean = as.matrix(x$parameters$mean)
    }
    cbind(ret, mean = rbind(matrix(, np-nrow(mean), ncol(mean)), mean))
}


#' @rdname mclust_tidiers
#' 
#' @return \code{augment} returns the original data with two extra columns:
#'   \item{.class}{The class assigned by the Mclust algorithm}
#'   \item{.uncertainty}{The uncertainty associated with the classification}
#' 
#' @export
augment.Mclust <- function(x, data, ...) {
    # move rownames if necessary
    data <- fix_data_frame(data, newcol = ".rownames")
    
    # show cluster assignment as a factor (it's not numeric)
    cbind(as.data.frame(data), .class = factor(x$classification),
          .uncertainty = x$uncertainty)
}


#' @rdname mclust_tidiers
#' 
#' @return \code{glance} returns a one-row data.frame with the columns
#'   \item{model}{A character string denoting the model at which the optimal BIC occurs}
#'   \item{n}{The number of observations in the data}
#'   \item{G}{The optimal number of mixture components}
#'   \item{BIC}{The optimal BIC value}
#'   \item{logLik}{The log-likelihood corresponding to the optimal BIC}
#'   \item{df}{The number of estimated parameters}
#'   \item{hypvol}{The hypervolume parameter for the noise component if required,
#'   otherwise set to NA}
#' 
#' @export
glance.Mclust <- function(x, ...) {
    ret <- with(x, data.frame(model = modelName, n, G,
                              BIC = bic, logLik = loglik,
                              df, hypvol))
    ret
}
