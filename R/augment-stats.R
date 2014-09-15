### augment methods for S3 classes used by the built-in stats package

#' Supplement the data fitted to a linear model with model fit statistics.
#'
#' If you have missing values in your model data, you may need to refit
#' the model with \code{na.action = na.exclude}.
#' 
#' @details This code and documentation originated in the ggplot2 package, where it was
#' called \code{fortify.lm}
#'
#' @return The original data with extra columns:
#'   \item{.hat}{Diagonal of the hat matrix}
#'   \item{.sigma}{Estimate of residual standard deviation when
#'     corresponding observation is dropped from model}
#'   \item{.cooksd}{Cooks distance, \code{\link{cooks.distance}}}
#'   \item{.fitted}{Fitted values of model}
#'   \item{.resid}{Residuals}
#'   \item{.stdresid}{Standardised residuals}
#' @param model linear model
#' @param data data set, defaults to data used to fit model
#' @param ... not used by this method
#' @export
#' @examples
#'
#' library(ggplot2)
#'
#' mod <- lm(mpg ~ wt, data = mtcars)
#' head(augment(mod))
#' head(augment(mod, mtcars))
#'
#' plot(mod, which = 1)
#' qplot(.fitted, .resid, data = mod) +
#'   geom_hline(yintercept = 0) +
#'   geom_smooth(se = FALSE)
#' qplot(.fitted, .stdresid, data = mod) +
#'   geom_hline(yintercept = 0) +
#'   geom_smooth(se = FALSE)
#' qplot(.fitted, .stdresid, data = augment(mod, mtcars),
#'   colour = factor(cyl))
#' qplot(mpg, .stdresid, data = augment(mod, mtcars), colour = factor(cyl))
#'
#' plot(mod, which = 2)
#' # qplot(sample =.stdresid, data = mod, stat = "qq") + geom_abline()
#'
#' plot(mod, which = 3)
#' qplot(.fitted, sqrt(abs(.stdresid)), data = mod) + geom_smooth(se = FALSE)
#'
#' plot(mod, which = 4)
#' qplot(seq_along(.cooksd), .cooksd, data = mod, geom = "bar",
#'  stat="identity")
#'
#' plot(mod, which = 5)
#' qplot(.hat, .stdresid, data = mod) + geom_smooth(se = FALSE)
#' ggplot(mod, aes(.hat, .stdresid)) +
#'   geom_vline(size = 2, colour = "white", xintercept = 0) +
#'   geom_hline(size = 2, colour = "white", yintercept = 0) +
#'   geom_point() + geom_smooth(se = FALSE)
#'
#' qplot(.hat, .stdresid, data = mod, size = .cooksd) +
#'   geom_smooth(se = FALSE, size = 0.5)
#'
#' plot(mod, which = 6)
#' ggplot(mod, aes(.hat, .cooksd)) +
#'   geom_vline(xintercept = 0, colour = NA) +
#'   geom_abline(slope = seq(0, 3, by = 0.5), colour = "white") +
#'   geom_smooth(se = FALSE) +
#'   geom_point()
#' qplot(.hat, .cooksd, size = .cooksd / .hat, data = mod) + scale_size_area()
augment.lm <- function(model, data = model$model, ...) {
    # move rownames if necessary
    data <- fix_data_frame(data, newcol=".rownames")

    infl <- influence(model, do.coef = FALSE)
    data$.hat <- infl$hat
    data$.sigma <- infl$sigma
    data$.cooksd <- cooks.distance(model, infl)
    
    data$.fitted <- predict(model)
    data$.resid <- resid(model)
    data$.stdresid <- rstandard(model, infl)
    
    data
}


#' augment method for nls objects
#' 
#' This combines the original data given to smooth.spline with the
#' fit and residuals
#' 
#' @param model a fitted nls object
#' @param data original data this was fitted on; if not given this will
#' attempt to be reconstructed from nls (may not be successful)
#' @param ... not used by this method
#' 
#' @return The original data with extra columns:
#'   \item{.fitted}{Fitted values of model}
#'   \item{.resid}{Residuals}
#'   
#' @return The original data 
#' 
#' @export
augment.nls <- function(model, data=NULL, ...) {
    # move rownames if necessary
    data <- fix_data_frame(data, newcol=".rownames")

    if (is.null(data)) {
        pars <- names(model$m$getPars())
        env <- as.list(model$m$getEnv())
        data <- as.data.frame(env[!(names(env) %in% pars)])
    }
    data$.fitted <- predict(model)
    data$.resid <- resid(model)
    data
}


#' augment method for smooth.spline
#' 
#' This combines the original data given to smooth.spline with the
#' fit and residuals
#' 
#' @param model a smooth.spline object
#' @param data defaults to data used to fit model
#' @param ... not used in this method
#' 
#' @return The original data with extra columns:
#'   \item{.fitted}{Fitted values of model}
#'   \item{.resid}{Residuals}
#' 
#' @export
augment.smooth.spline <- function(model, data=model$data, ...) {
    # move rownames if necessary
    data <- fix_data_frame(data, newcol=".rownames")

    data <- as.data.frame(data)
    data$.fitted <- fitted(model)
    data$.resid <- resid(model)
    data
}


#' augment a kmeans object
#' 
#' Constructs a data.frame containing one row for each initial point, with
#' the cluster assignment added.
#' 
#' @param model an object of class "kmeans"
#' @param data the original data that was clustered (required)
#' @param ... extra arguments (not used)
#' 
#' @return The original data with one extra column:
#'   \item{.cluster}{The cluster assigned by the k-means algorithm}
#' 
#' @export
augment.kmeans <- function(model, data, ...) {
    # move rownames if necessary
    data <- fix_data_frame(data, newcol=".rownames")

    # show cluster assignment as a factor (it's not numeric)
    cbind(as.data.frame(data), .cluster=factor(model$cluster))
}
