#' @name rms_tidiers
#' @title Tidiers for rms model objects
#' 
#' @param x A model object that inherits class \code{rms}
#' @param conf.int Whether to return the confidence intervals in 
#'   the tidy output
#' @param conf.level The confidence level for the confidence intervals
#' @param exponentiate Whether to exponentiate the estimate and
#'   confidence intervals
#' @param ... Extra arguments, not used
#' 
#' @export

tidy.cph <- function(x, conf.int = FALSE, conf.level = 0.95,
                     exponentiate = FALSE, ...)
{
    res <- data.frame(term = names(x$coef),
                      estimate = x$coef,
                      std.error = sqrt(diag(x$var)),
                      stringsAsFactors = FALSE)
    res$statistic <- res$estimate / res$std.error
    res$p.value <- pnorm(abs(res$statistic), lower.tail = FALSE) * 2
    
    if (conf.int){
        ci <- as.data.frame(confint(x, level = conf.level))
        names(ci) <- c("conf.low", "conf.high")
        
        res <- cbind(res, ci)
    }
    
    if (exponentiate){
        res$estimate <- exp(res$estimate)
        
        if (conf.int){
            res$conf.low <- exp(res$conf.low)
            res$conf.high <- exp(res$conf.high)
        }
    }
    
    rownames(res) <- NULL
    res
}

#' @rdname rms_tidiers
#' @export

tidy.lrm <- function(x, conf.int = FALSE, conf.level = 0.95,
                     exponentiate = FALSE, ...)
{
    res <- data.frame(term = names(x$coef),
                      estimate = x$coef,
                      std.error = sqrt(diag(x$var)),
                      stringsAsFactors = FALSE)
    res$statistic <- res$estimate / res$std.error
    res$p.value <- pnorm(abs(res$statistic), lower.tail = FALSE) * 2
    
    if (conf.int){
        ci <- as.data.frame(confint(x, level = conf.level))
        names(ci) <- c("conf.low", "conf.high")
        
        res <- cbind(res, ci)
    }
    
    if (exponentiate){
        res$estimate <- exp(res$estimate)
        
        if (conf.int){
            res$conf.low <- exp(res$conf.low)
            res$conf.high <- exp(res$conf.high)
        }
    }
    
    rownames(res) <- NULL
    res
}

#' @rdname rms_tidiers
#' @export

tidy.ols <- function(x, conf.int = TRUE, conf.level = TRUE,
                     exponentiate = TRUE, ...)
{
    res <- data.frame(term = names(x$coef),
                      estimate = x$coef,
                      std.error = sqrt(diag(x$var)),
                      stringsAsFactors = FALSE)
    res$statistic <- res$estimate / res$std.error
    res$p.value <- pt(abs(res$statistic), x$stats["n"] - 1, lower.tail = FALSE) * 2
    
    if (conf.int){
        ci <- as.data.frame(confint(x, level = conf.level))
        names(ci) <- c("conf.low", "conf.high")
        
        res <- cbind(res, ci)
    }
    
    if (exponentiate){
        res$estimate <- exp(res$estimate)
        
        if (conf.int){
            res$conf.low <- exp(res$conf.low)
            res$conf.high <- exp(res$conf.high)
        }
    }
    
    rownames(res) <- NULL
    res
}
