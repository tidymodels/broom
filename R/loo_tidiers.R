#' Tidying methods for a LOO object
#' 
#' These methods tidy the estimates from \code{\link[loo]{loo-package}}
#' into a summary.
#' 
#'
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#'
#' @seealso \code{\link[loo]{loo}}, \code{\link[loo]{waic}}
#'
#' @name loo_tidiers
#' 
#' @param x Estimated object from the \pkg{loo} package. See 
#'   \code{\link[loo]{loo}}.
#' @param data Data frame to bind the 
#' @param ... Extra arugments (not used).
#' @examples
#' 
#' \dontrun{
#' # From: vignette("loo-example", package = "loo")
#' 
#' library("rstan")
#' 
#' # Prepare data 
#' url <- "http://stat.columbia.edu/~gelman/arm/examples/arsenic/wells.dat"
#' wells <- read.table(url)
#' wells$dist100 <- with(wells, dist / 100)
#' X <- model.matrix(~ dist100 + arsenic, wells)
#' standata <- list(y = wells$switch, X = X, N = nrow(X), P = ncol(X))
#' 
#' # Fit model
#' fit_1 <- stan("logistic.stan", data = standata)
#' 
#' library("loo")
#' 
#' # Extract pointwise log-likelihood and compute LOO
#' log_lik_1 <- extract_log_lik(fit_1)
#' loo_1 <- loo(log_lik_1)
#' 
#' tidy(loo_1)
#' 
#' # glance method
#' glance(loo_1)
#' }
#'  
NULL


#' @rdname loo_tidiers
#' 
#' @return 
#' A data frame with three rows and three columns:
#' \item{param}{Expected log posterior density, estimated effective number of
#' parameters, and information criterion (expected log posterior density
#' converted to deviance scale).}
#' \item{estimate}{The estimate of the parameter.}
#' \item{std.err}{The standard error of the estimate for the parameter.}
#' 
#' @export
tidy.loo <- function(x, ...) {
    elpd <- grep("^elpd_(loo|waic)$", names(x), value = TRUE)
    p <- grep("^p_(loo|waic)$", names(x), value = TRUE)
    ic <- grep("^(waic|looic)$", names(x), value = TRUE)
    data.frame(
        param = c(elpd, p, ic),
        estimate = c(x[[elpd]], x[[p]], x[[ic]]),
        std.err = c(
            x[[paste0("se_", elpd)]],
            x[[paste0("se_", p)]],
            x[[paste0("se_", ic)]]
        )
    )
}


#' @rdname loo_tidiers
#' 
#' @return 
#' augment returns a data frame with one row for each observation in data set
#' that was used to estimate the model. When \code{x} comes from
#' \code{\link[loo]{loo}}, \code{augment.loo} returns one row for each
#' observation of the data that was used to estimate the model,
#' with four columns (see \code{\link[loo]{loo}} for more details):
#' \item{.elpd_loo}{Pointwise contributions to the expected log pointwise
#' predicitve density.}
#' \item{.p_loo}{Pointwise contributions to the estimated effective number of
#' parameters.}
#' \item{.looic}{Pointwise contributions to the LOO information criterion.}
#' \item{.pareto_k}{Pointwise contributions to the shape parameter \emph{k}
#' for the generalized Pareto fit to the importance ratios for each
#' leave-one-out distirbution.}
#' 
#' When \code{x} comes from \code{\link[loo]{waic}}, \code{augment.loo} returns
#' one row for each observation of the data that was used to estimate the model,
#' with three columns (see \code{\link[loo]{waic}} for more details):
#' \item{.elpd_waic}{Pointwise contributions to the expected log pointwise
#' predictive density.}
#' \item{.p_waic}{Pointwise contributions to the estimated effective number of
#' parameters.}
#' \item{.waic}{Pointwise contributions to the widely applicable information
#' criterion (WAIC)}
#' 
#' @export
augment.loo <- function(x, data = NULL, ...) {
    out <- as.data.frame(x$pointwise)
    names(out) <- paste0(".", names(out))
    out$.pareto_k <- x$pareto_k
    if (!is.null(data)) {
        dplyr::bind_cols(data, out)
    } else {
        out
    }
}


#' @rdname loo_tidiers
#' 
#' @return 
#' glance returns one row and eight columns (column names will depend on
#' whether the object comes from \code{\link[loo]{loo}}, or
#' \code{\link[loo]{waic}}):
#' \item{elpd_(loo/waic)}{Expected log pointwise predictive density.}
#' \item{p_(loo/waic)}{Estimated effective number of parameters.}
#' \item{(looic/waic)}{Information criterion (converted to deviance scale).}
#' \item{se_elpd_(loo/waic)}{Standard error of expected log pointwise predictive
#' density.}
#' \item{se_p_(loo/waic)}{Standard error of estimated effective number of
#' parameters.}
#' \item{se_(looic/waic)}{Standard error of information criterion.}
#' \item{n}{Number of observations.}
#' \item{n_sims}{Number of retained iterations.}
#' 
#' @export
glance.loo <- function(x, ...) {
    out <- as.data.frame(unclass(x[setdiff(names(x), c("pointwise",
        "pareto_k"))]))
    
    out$n <- attr(x, "log_lik_dim")[2]
    out$n_sims <- attr(x, "log_lik_dim")[1]
    out
}
