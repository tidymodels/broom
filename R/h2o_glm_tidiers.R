tidy_h2o_glm <- function(x, exponentiate, ...) {
    newnames <- if (x@allparameters$compute_p_values) {
        c("term", "estimate", "std.error", "statistic", "p.value",
          "standardized_coefficients")
    } else {
        c("term", "estimate", "standardized_coefficients")
    }
    
    if (exponentiate) {
        if (x@allparameters$link != "logit" && x@allparameters$link  != "log") {
            warning(paste("Exponentiating coefficients, but model did not use",
                          "a log or logit link function"))
        }
        trans <- exp
    } else {
        trans <- identity
    }
    
    x@model$coefficients_table %>%
        fix_data_frame(newnames = newnames) %>%
        purrr::modify_at(c("estimate", "standardized_coefficients"), trans)
}

augment_h2o_glm <- function(x,
                            data,
                            newdata, collect, ...) {
    
    if (!(is.null(newdata) || h2o::is.h2o(newdata)))
        stop("newdata must be a H2OFrame")
    stopifnot(is.logical(collect))
    if (! class(x) %in% c("H2ORegressionModel", "H2OBinomialModel"))
        stop(paste0(class(x), " not supported"))
    
    ret <- if (is.null(newdata)) data else newdata
    pred <- predict(x, ret)
    if (class(x) == "H2OBinomialModel") {
        ret$.fitted <- data[[x@allparameters$y]] %>%
            h2o::h2o.levels() %>%
            .[2] %>%
            pred[.]
    } else {
        ret$.fitted <- pred$predict
    }
    if (x@allparameters$compute_p_values) {
        ret$.se.fit <- pred$StdErr
    }
    
    if (collect == TRUE) {
        as.data.frame(ret)
    } else {
        ret
    }
}
