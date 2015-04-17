#' Helper function for tidy.rq and tidy.rqs
#' 
#' See documentation for \code{summary.rq} for complete description
#' of the options for \code{se.type}, \code{conf.int}, etc.
#' 
#' @param rq_obj an object returned by \code{summary.rq} or \code{summary.rqs}
#' @param se.type type of standard errors used in \code{summary.rq} or \code{summary.rqs}
#' @param conf.int
#' @param conf.level
#' @param \dots currently unused
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
