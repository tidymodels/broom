#' Tidying methods for H2O models
#' 
#' These methods summarize the results of H2O models into tidy forms.
#' 
#' @name h2o_tidiers
#' 
#' @param x An H2OModel object

setClass("H2OModel")
setClass("H2OBinomialModel")
setClass("H2ORegressionModel")

#' @rdname h2o_tidiers
#' 
#' @param exponentiate For GLM, whether to exponentiate the coefficient estimates (typical for logistic regression)
#' 
#' @return \code{tidy} for H2O GLM models returns one row for each coefficient. Note that p-values and associated statistics are only included if \code{compute_p_values} was set to \code{TRUE} during model fitting
#'   \item{term}{The term in the linear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error from the GLM}
#'   \item{statistic}{Z-score}
#'   \item{p.value}{p-value}
#' @export
setMethod("tidy", "H2OBinomialModel", function(x, exponentiate = FALSE) {
    if (x@algorithm == "glm") {
        tidy_h2o_glm(x, exponentiate)
    } else {
        stop(paste(x@algorithm, " not supported"))
    }
}
)

#' @rdname h2o_tidiers
#' 
#' @export
setMethod("tidy", "H2ORegressionModel", function(x, exponentiate = FALSE) {
    if (x@algorithm == "glm") {
        tidy_h2o_glm(x, exponentiate)
    } else {
        stop(paste(x@algorithm, " not supported"))
    }
}
)

#' @rdname h2o_tidiers
#' 
#' @param data H2OFrame on which the model is trained on
#' @param newdata If provided, performs predictions on the new data; must be an H2OFrame object
#' @param collect Whether to collect the output to a local R data.frame; defaults to \code{TRUE}
#' 
#' @details By default, \code{augment} returns local data frame. For very large datasets, it may be desirable to set \code{collect = FALSE}, in which case the function returns a pointer to the appended H2OFrame.
#' 
#' @return \code{augment} for H2O GLM models returns a data frame (or H2OFrame if \code{collect = FALSE}) with the following columns appended to \code{data} or \code{newdata}
#'   \item{.fitted}{Fitted values of model}
#'   \item{.se.fit}{Standard errors of fitted values}
#'   
#' @export
setMethod("augment", "H2OBinomialModel", function(x, data = h2o.getFrame(x@allparameters$training_frame),
                                                  newdata = NULL, collect = TRUE, ...) {
    if (x@algorithm == "glm") {
        augment_h2o_glm(x, data, newdata, collect, ...)
    } else {
        stop(paste(x@algorithm, " not supported"))
    }
    
}
)

#' @rdname h2o_tidiers
#' 
#' @export
setMethod("augment", "H2ORegressionModel", function(x, data = h2o.getFrame(x@allparameters$training_frame),
                                                    newdata = NULL, collect = TRUE, ...) {
    if (x@algorithm == "glm") {
        augment_h2o_glm(x, data, newdata, collect, ...)
    } else {
        stop(paste(x@algorithm, " not supported"))
    }
    
}
)

#' @rdname h2o_tidiers
#' 
#' @param on The dataset on which model metrics will be evaluated; one of \code{"train"}, \code{"valid"}, and \code{"xval"}; defaults to \code{"train"}
#' 
#' @return \code{glance} for H2O models returns a one-row data.frame with columns representing various model metrics. In the case of GLM the following are outputted
#'   \item{r.squared}{The percent of variance explained by the model}
#'   \item{df.null}{Null degrees of freedom}
#'   \item{df.residual}{Residual degrees of freedom}
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{deviance}{deviance}
#'   \item{MSE}{Mean squared error}
#'   \item{RMSE}{Root mean squared error}
#'   \item{AUC}{Area under the ROC curve}
#'   \item{logloss}{Log loss}
#'   
#' @export
setMethod("glance", "H2OModel", function(x, on = "train", ...) {
    stopifnot(on %in% c("train", "valid", "xval"))
    h2o_extractor_funs <- c(null.deviance = h2o.null_deviance, 
                            df.null = h2o.null_dof, 
                            df.residual = h2o.residual_dof,
                            AIC = h2o.aic, 
                            deviance = h2o.residual_deviance,
                            r.squared = h2o.r2,
                            MSE = h2o.mse,
                            RMSE = h2o.rmse,
                            # RMSLE = h2o.rmsle,
                            AUC = h2o.auc,
                            # Gini = h2o.giniCoef,
                            logloss = h2o.logloss
                            # mean_per_class_error = h2o.mean_per_class_error
                            )
    
    data_frame(metric = names(h2o_extractor_funs), 
               h2o_fun = h2o_extractor_funs) %>%
        rowwise %>%
        mutate(value = suppressWarnings(
            c(x, TRUE) %>%
                setNames(c("object", on)) %>%
                do.call(h2o_fun, .) %>%
                ifelse(is.null(.), NA, .))
        ) %>%
        select(-h2o_fun) %>%
        filter(!is.na(value)) %>%
        tidyr::spread(metric, value)
}
)
