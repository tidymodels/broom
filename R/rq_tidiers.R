process_rq <- function(rq_obj,se.type = "rank",conf.int = TRUE, conf.level = 0.95,...){
    nn <- c("estimate", "std.error", "statistic", "p.value")
    co <- as.data.frame(rq_obj[["coefficients"]])
    if (se.type == "rank"){
        co <- setNames(co,c("estimate","conf.low","conf.high"))
        conf.int <- FALSE
    }else{
        co <- setNames(co,nn)
    }
    if (conf.int){
        a <- (1 - conf.level) / 2
        cv <- qt(c(a,1-a),df = rq_obj[["rdf"]])
        co[["conf.low"]] <- co[["estimate"]] + (cv[1] * co[["std.error"]])
        co[["conf.high"]] <- co[["estimate"]] + (cv[2] * co[["std.error"]])
    }
    co[["tau"]] <- rq_obj[["tau"]]
    fix_data_frame(co,colnames(co))
}

#' @export
tidy.rq <- function(x,se.type = "rank",conf.int = TRUE,conf.level = 0.95,...){
    rq_summary <- suppressWarnings(summary(x,se = se.type,...))
    process_rq(rq_obj = rq_summary,se.type = se.type,conf.int = conf.int,conf.level = conf.level,...)
}

#' @export
tidy.rqs <- function(x,se.type = "rank",conf.int = TRUE,conf.level = 0.95,...){
    rq_summary <- suppressWarnings(summary(x,se = se.type,...))
    plyr::ldply(rq_summary,process_rq,se.type = se.type,conf.int = conf.int,conf.level = conf.level,...)
}

#' @export
glance.rq <- function(x,...,k = 0){
    data.frame(tau = x[["tau"]],
               logLik = logLik(x),
               AIC = AIC(x),
               BIC = AIC(x,k = k),
               df = rep(attr(AIC(x),"edf"),length(x[["tau"]])))
}

#' @export
glance.rqs <- glance.rq

#' @export
augment.rq <- function(x,data = model.frame(x),newdata, ...){
    args <- list(...)
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

#' @export
augment.rqs <- function(x,data = model.frame(x), newdata, ...){
    n_tau <- length(x[["tau"]])
    if (missing(newdata) || is.null(newdata)){
        original <- data[rep(seq_len(nrow(data)), n_tau),]
        pred <- predict(x,stepfun = FALSE,...)
        resid <- residuals(x)
        resid <- setNames(as.data.frame(resid),x[["tau"]])
        resid <- reshape2::melt(resid,measure.vars = 1:ncol(resid),variable.name = ".tau",value.name = ".resid")
        original <- cbind(original,resid)
        pred <- setNames(as.data.frame(pred),x[["tau"]])
        pred <- reshape2::melt(pred,measure.vars = 1:ncol(pred),variable.name = ".tau",value.name = ".fitted")
        return(unrowname(cbind(original,pred[,-1,drop = FALSE])))
    } else{
        original <- newdata[rep(seq_len(nrow(newdata)), n_tau),]
        pred <- predict(x, newdata = newdata, stepfun = FALSE,...)
        pred <- setNames(as.data.frame(pred),x[["tau"]])
        pred <- reshape2::melt(pred,measure.vars = 1:ncol(pred),variable.name = ".tau",value.name = ".fitted")
        return(unrowname(cbind(original,pred)))
    }
}
