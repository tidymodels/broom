#' Tidying methods for Mclust objects
#' 
#' These methods summarize the results of Mclust clustering into three
#' tidy forms. \code{tidy} describes the size, mixing probability, mean and variabilty of each class,
#' \code{augment} adds the class assignments and their probabilities to the original data, and
#' \code{glance} summarizes the model parameters of the clustering.
#'
#' @param x Mclust object
#' @param data Original data (required for \code{augment})
#' @param ... extra arguments, not used
#'
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#'
#' @seealso \code{\link{Mclust}}
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
#' ggplot(augment(mod, iris[,1:4]), aes(Sepal.Length, Sepal.Width)) +
#'     geom_point(aes(color = .class)) +
#'     geom_text(aes(x = mean.x1, y = mean.x2, label = component), data = tidy(m), size = 10)
#'
#' @name Mclust_tidiers
#' 
NULL


#' @rdname Mclust_tidiers
#' 
#' @return \code{tidy} returns one row per component, with 
#'   \item{component}{A factor describing the cluster from 1:k or 0:k in presence of a noise term in x}
#'   \item{size}{The size of each component}
#'   \item{pro}{The mixing proportion of each component}
#'   \item{variance}{In case of one-dimensional and spherical models, the variance for each component, omitted otherwise. NA for noise component}
#'   \item{mean}{The mean for each component. In case of two- or more dimensional models, a column with the mean is added for each dimension. NA for noise component}
#' 
#' @export
tidy.Mclust <- function(x, ...) {
    np = max(x$G,length(table(x$classification)))
    ret = data.frame(seq_len(np))
    colnames(ret) = c("component")
    if(x$G < np) ret$component = ret$component-1
    ret$size = sapply(seq(1,np), function(c) { sum(x$classification == c)})
    ret$pro = x$parameters$pro
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


#' @rdname Mclust_tidiers
#' 
#' @return \code{augment} returns the original data with two extra columns
#'   \item{.class}{The class assigned by the Mclust algorithm}
#'   \item{.uncertainty}{The uncertainty associated with the classification}
#'   followed by one column for each class k giving the probability that observation i in the data belongs to the kth class.
#' 
#' @export
augment.Mclust <- function(x, data, ...) {
    # move rownames if necessary
    #data <- fix_data_frame(data, newcol = ".rownames")
    
    z = x$z
    colnames(z) = paste(".prob.",1:ncol(z),sep="")
    # show cluster assignment as a factor (it's not numeric)
    cbind(as.data.frame(data), .class = factor(x$classification), .uncertainty = x$uncertainty, z)
}


#' @rdname Mclust_tidiers
#' 
#' @return \code{glance} returns a one-row data.frame with the columns
#'   \item{modelName}{A character string denoting the model at which the optimal BIC occurs}
#'   \item{n}{The number of observations in the data}
#'   \item{d}{The dimension of the data}
#'   \item{G}{The optimal number of mixture components}
#'   \item{bic}{The optimal BIC value}
#'   \item{loglik}{The log-likelihood corresponding to the optimal BIC}
#'   \item{df}{The number of estimated parameters}
#'   \item{hypvol}{The hypervolume parameter for the noise component if required, otherwise set to NULL (see \code{\link{hypvol}}).}
#' 
#' @export
glance.Mclust <- function(x, ...) {
    ret <- as.data.frame(x[c("modelName", "n", "d", "G","bic","loglik","df","hypvol")])
    ret
}
