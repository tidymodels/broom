#' Tidying methods for Stan fits
##'
##' @param x an object of class \sQuote{"stanfit"}
##' @param pars (character) specification of which parameters to include
##' @param pt.method method for computing point estimate ("mean" or "median")
##' @param conf.int (logical) include confidence interval?
##' @param conf.level probability level for CI
##' @param conf.method method for computing confidence intervals ("quantile" or "HPDinterval")
##' @param ... unused
##' @importFrom coda HPDinterval as.mcmc
##' @export
tidy.stanfit <- function(x,
                         pars, ## ?? do other 
                         pt.method = "mean",
                         conf.int = FALSE,
                         conf.level = 0.95,
                         conf.method = "quantile",
                         ...) {
    ss <- as.matrix(x)
    ss <- ss[,!colnames(ss)=="lp__"]  ## drop log-probability info
    if (!missing(pars)) {
        if (length(badpars <- which(!pars %in% colnames(ss)))>0) {
            stop("unrecognized parameters: ",pars[w])
        }
        ss <- ss[,pars]
    }
    if (pt.method=="mean") {
        m <- colMeans(ss)
    } else if (pt.method=="median") {
        m <- apply(ss,1,median)
    } else stop("unknown pt.method ",pt.method)
    ret <- data.frame(estimate=colMeans(ss),
                      std.error=apply(ss,2,sd))
    if (conf.int) {
        levs <- c((1-conf.level)/2,(1+conf.level)/2)
        if (conf.method=="quantile") {
            ci <- t(apply(ss,2,quantile,levs))
        } else if (conf.method=="HPDinterval") {
            ci <- HPDinterval(as.mcmc(ss),prob=conf.leve)
        } else stop("unknown conf.method ",conf.method)
        colnames(ci) <- c("conf.low","conf.high")
        ret <- data.frame(ret,ci)
    }
    return(fix_data_frame(ret))
}

