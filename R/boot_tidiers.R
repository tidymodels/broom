#' Tidying methods for  bootstrap computations
#' 
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#' 
#' @name boot_tidiers
#' 
#' @examples
#'
#' if (require("boot")) {
#' }
NULL

boot.p <- function(bootvals,i) {
    2*min(mean(bootvals<0),mean(bootvals>0))
}

#' @rdname boot_tidiers
#'
#' @param x \code{\link{boot}} object
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level for CI
#' @param conf.method method for computing confidence intervals (see \code{\link{boot.ci}})
#' @param \dots extra arguments (not used)
#'
#' @importFrom boot boot.ci
#'
#' @examples
#' if (require("boot")) {
#'    g1 <- glm(lot2 ~ log(u), data = clotting, family = Gamma)
#'    bootfun <- function(d, i) {
#'       coef(update(g1, data= d[i,]))
#'    }
#'    bootres <- boot(clotting, bootfun, R = 999)
#'    tidy(g1,conf.int=TRUE)
#'    tidy(bootres,conf.int=TRUE)
#' }
#'

#' 
#' 
#' @export
tidy.boot <- function(x,
                      ## is there a convention for the default value of
                      ## conf.int?
                      conf.int = FALSE,
                      conf.level = 0.95,
                      conf.method = "perc", ...) {
    nn <- c("estimate", "p.value")
    obsvals <- c(x$t0)
    bootvals <- x$t
    npar <- ncol(bootvals)
    ## not sure what to do about returning standard error here;
    ## may be misleading if there is bias in the bootstrap mean
    ret <- cbind(obsvals,
                 vapply(1:npar,boot.p,bootvals,FUN.VALUE=numeric(1)))
    if (conf.int) {
        ci.list <- lapply(1:npar,
                          boot.ci,boot.out=x,
                          conf=conf.level,type=conf.method)
        ## boot.ci uses c("norm", "basic", "perc", "stud") for types
        ## stores them with longer names
        ci.pos <- pmatch(conf.method,names(ci.list[[1]]))
        ci.tab <- sapply(ci.list,function(x) x[[ci.pos]][4:5])
        ret <- cbind(ret,ci.tab)
        nn <- c(nn,"conf.low","conf.high")
    }
    return(fix_data_frame(ret,nn))
}


