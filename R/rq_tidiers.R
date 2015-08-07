#' Tidying methods for quantile regression models
#' 
#' These methods tidy the coefficients of a quantile regression
#' model into a summary, augment the original data with information
#' on the fitted values and residuals, and construct a glance of
#' the model's statistics.
#' 
#' @template boilerplate
#' 
#' @name rq_tidiers
#' 
#' @param x model object returned by \code{rq} or \code{nlrq}
#' @param data Original data, defaults to extracting it from the model
#'
NULL

#' @rdname rq_tidiers
#' 
#' @param se.type Type of standard errors to calculate; see \code{summary.rq}
#' @param conf.int boolean; should confidence intervals be calculated, ignored
#' if \code{se.type = "rank"}
#' @param conf.level confidence level for intervals
#' @param alpha confidence level when \code{se.type = "rank"}; defaults to the same
#' as \code{conf.level} although the specification is inverted
#' @param \dots other arguments passed on to \code{summary.rq}
#' 
#' @details If \code{se.type != "rank"} and \code{conf.int = TRUE} confidence
#' intervals are calculated by \code{summary.rq}. Otherwise they are standard t
#' based intervals.
#' 
#' @return \code{tidy.rq} returns a data frame with one row for each coefficient.
#' The columns depend upon the confidence interval method selected.
#' 
#' @export
tidy.rq <- function(x,se.type = "rank",conf.int = TRUE,conf.level = 0.95,alpha = 1 - conf.level, ...){
    #summary.rq often issues warnings when computing standard errors
    rq_summary <- suppressWarnings(summary(x,se = se.type, alpha = alpha, ...))
    process_rq(rq_obj = rq_summary,se.type = se.type,conf.int = conf.int,conf.level = conf.level,...)
}

#' @rdname rq_tidiers
#' 
#' @return \code{tidy.rqs} returns a data frame with one row for each coefficient at
#' each quantile that was estimated. The columns depend upon the confidence interval 
#' method selected.
#' 
#' @export
tidy.rqs <- function(x,se.type = "rank",conf.int = TRUE,conf.level = 0.95,alpha = 1 - conf.level, ...){
    #summary.rq often issues warnings when computing standard errors
    rq_summary <- suppressWarnings(summary(x,se = se.type,alpha = alpha, ...))
    plyr::ldply(rq_summary,process_rq,se.type = se.type,conf.int = conf.int,conf.level = conf.level,...)
}

#' @rdname rq_tidiers
#' 
#' @return \code{tidy.nlrq} returns one row for each coefficient in the model,
#' with five columns:
#'   \item{term}{The term in the nonlinear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error from the linear model}
#'   \item{statistic}{t-statistic}
#'   \item{p.value}{two-sided p-value}
#' 
#' @export
tidy.nlrq <- function(x, conf.int = FALSE, conf.level = 0.95, ...){
    nn <- c("estimate", "std.error", "statistic", "p.value")
    ret <- fix_data_frame(coef(summary(x)), nn)
    
    if (conf.int){
        x_summary <- summary(x)
        a <- (1 - conf.level) / 2
        cv <- qt(c(a,1-a),df = x_summary[["rdf"]])
        ret[["conf.low"]] <- ret[["estimate"]] + (cv[1] * ret[["std.error"]])
        ret[["conf.high"]] <- ret[["estimate"]] + (cv[2] * ret[["std.error"]])
    }
    ret
}

#' @rdname rq_tidiers
#' 
#' @return \code{glance.rq} returns one row for each quantile (tau)
#' with the columns:
#'  \item{tau}{quantile estimated}
#'  \item{logLik}{the data's log-likelihood under the model}
#'  \item{AIC}{the Akaike Information Criterion}
#'  \item{BIC}{the Bayesian Information Criterion}
#'  \item{df.residual}{residual degrees of freedom}
#' @export
glance.rq <- function(x,...){
    n <- length(fitted(x))
    s <- summary(x)
    data.frame(tau = x[["tau"]],
               logLik = logLik(x),
               AIC = AIC(x),
               BIC = AIC(x,k = log(n)),
               df.residual = rep(s[["rdf"]],times = length(x[["tau"]])))
}

#' @export
glance.rqs <- glance.rq

#' @rdname rq_tidiers
#' 
#' @return \code{glance.rq} returns one row for each quantile (tau)
#' with the columns:
#'  \item{tau}{quantile estimated}
#'  \item{logLik}{the data's log-likelihood under the model}
#'  \item{AIC}{the Akaike Information Criterion}
#'  \item{BIC}{the Bayesian Information Criterion}
#'  \item{df.residual}{residual degrees of freedom}
#' @export
glance.nlrq <- function(x,...){
    n <- length(x[["m"]]$fitted())
    s <- summary(x)
    data.frame(tau = x[["m"]]$tau(),
               logLik = logLik(x),
               AIC = AIC(x),
               BIC = AIC(x,k = log(n)),
               df.residual = s[["rdf"]])
}

#' @rdname rq_tidiers
#' 
#' @param newdata If provided, new data frame to use for predictions
#' 
#' @return \code{augment.rq} returns a row for each original observation
#' with the following columns added:
#'  \item{.resid}{Residuals}
#'  \item{.fitted}{Fitted quantiles of the model}
#'  \item{.tau}{Quantile estimated}
#'  
#'  Depending on the arguments passed on to \code{predict.rq} via \code{\dots}
#'  a confidence interval is also calculated on the fitted values resulting in
#'  columns:
#'      \item{.conf.low}{Lower confidence interval value}
#'      \item{.conf.high}{Upper confidence interval value}
#'      
#'  See \code{predict.rq} for details on additional arguments to specify
#'  confidence intervals. \code{predict.rq} does not provide confidence intervals
#'  when \code{newdata} is provided.
#' 
#' @export
augment.rq <- function(x,data = model.frame(x),newdata, ...){
    args <- list(...)
    force_newdata <- FALSE
    if ("interval" %in% names(args) && args[["interval"]] != "none"){
        force_newdata <- TRUE
    }
    if (missing(newdata) || is.null(newdata)){
        original <- data
        original[[".resid"]] <- residuals(x)
        if (force_newdata){
            pred <- predict(x, newdata = data,...)
        } else{
            pred <- predict(x,...)  
        } 
    } else{
        original <- newdata
        pred <- predict(x, newdata = newdata,...)
    }
    
    if (NCOL(pred) == 1){
        original[[".fitted"]] <- pred
        original[[".tau"]] <- x[["tau"]]
        return(unrowname(original))
    } else{
        colnames(pred) <- c(".fitted",".conf.low",".conf.low")
        original[[".tau"]] <- x[["tau"]]
        return(unrowname(cbind(original,pred)))
    }
}

#' @rdname rq_tidiers
#' 
#' @return \code{augment.rqs} returns a row for each original observation
#' and each estimated quantile (\code{tau}) with the following columns added:
#'  \item{.resid}{Residuals}
#'  \item{.fitted}{Fitted quantiles of the model}
#'  \item{.tau}{Quantile estimated}
#'  
#'  \code{predict.rqs} does not return confidence interval estimates.
#' 
#' @export
augment.rqs <- function(x,data = model.frame(x), newdata, ...){
    n_tau <- length(x[["tau"]])
    if (missing(newdata) || is.null(newdata)){
        original <- data[rep(seq_len(nrow(data)), n_tau),]
        pred <- predict(x,stepfun = FALSE,...)
        resid <- residuals(x)
        resid <- setNames(as.data.frame(resid),x[["tau"]])
        #resid <- reshape2::melt(resid,measure.vars = 1:ncol(resid),variable.name = ".tau",value.name = ".resid")
        resid <- tidyr::gather(data = resid,key = ".tau",value = ".resid")
        original <- cbind(original,resid)
        pred <- setNames(as.data.frame(pred),x[["tau"]])
        #pred <- reshape2::melt(pred,measure.vars = 1:ncol(pred),variable.name = ".tau",value.name = ".fitted")
        pred <- tidyr::gather(data = pred,key = ".tau",value = ".fitted")
        return(unrowname(cbind(original,pred[,-1,drop = FALSE])))
    } else{
        original <- newdata[rep(seq_len(nrow(newdata)), n_tau),]
        pred <- predict(x, newdata = newdata, stepfun = FALSE,...)
        pred <- setNames(as.data.frame(pred),x[["tau"]])
        #pred <- reshape2::melt(pred,measure.vars = 1:ncol(pred),variable.name = ".tau",value.name = ".fitted")
        pred <- tidyr::gather(data = pred,key = ".tau",value = ".fitted")
        return(unrowname(cbind(original,pred)))
    }
}

#' @rdname rq_tidiers
#' 
#' @details This simply calls \code{augment.nls} on the "nlrq" object.
#' 
#' @return \code{augment.rqs} returns a row for each original observation
#' with the following columns added:
#'  \item{.resid}{Residuals}
#'  \item{.fitted}{Fitted quantiles of the model}
#'  
#' 
#' @export
augment.nlrq <- augment.nls


#' Helper function for tidy.rq and tidy.rqs
#' 
#' See documentation for \code{summary.rq} for complete description
#' of the options for \code{se.type}, \code{conf.int}, etc.
#' 
#' @param rq_obj an object returned by \code{summary.rq} or \code{summary.rqs}
#' @param se.type type of standard errors used in \code{summary.rq} or \code{summary.rqs}
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level for confidence interval
#' @param \dots currently unused
process_rq <- function(rq_obj, se.type = "rank",
                       conf.int = TRUE,
                       conf.level = 0.95, ...){
    nn <- c("estimate", "std.error", "statistic", "p.value")
    co <- as.data.frame(rq_obj[["coefficients"]])
    if (se.type == "rank") {
        co <- setNames(co,c("estimate","conf.low","conf.high"))
        conf.int <- FALSE
    }else{
        co <- setNames(co,nn)
    }
    if (conf.int) {
        a <- (1 - conf.level) / 2
        cv <- qt(c(a, 1 - a), df = rq_obj[["rdf"]])
        co[["conf.low"]] <- co[["estimate"]] + (cv[1] * co[["std.error"]])
        co[["conf.high"]] <- co[["estimate"]] + (cv[2] * co[["std.error"]])
    }
    co[["tau"]] <- rq_obj[["tau"]]
    fix_data_frame(co,colnames(co))
}
