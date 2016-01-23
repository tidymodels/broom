#' Tidying methods for MCMC (Stan, JAGS, etc.) fits
#'
#' @param x an object of class \sQuote{"stanfit"}
#' @param pars (character) specification of which parameters to nclude
#' @param estimate.method method for computing point estimate ("mean" or "median")
#' @param conf.int (logical) include confidence interval?
#' @param conf.level probability level for CI
#' @param conf.method method for computing confidence intervals
#' ("quantile" or "HPDinterval")
#' @param drop.pars Parameters not to include in the output (such
#' as log-probability information)
#' @param ... unused
#' 
#' @name mcmc_tidiers
#' 
#' @examples
#' 
#' # Using example from "RStan Getting Started"
#' # https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
#' 
#' model_file <- system.file("extdata", "8schools.stan", package = "broom")
#' 
#' schools_dat <- list(J = 8, 
#'                     y = c(28,  8, -3,  7, -1,  1, 18, 12),
#'                     sigma = c(15, 10, 16, 11,  9, 11, 10, 18))
#' 
#' if (requireNamespace("rstan", quietly = TRUE)) {
#'   infile <- system.file("extdata", "rstan_example.rda", package = "broom")
#'   if (infile=="") {
#'      set.seed(2015)
#'      rstan_example <- rstan::stan(file = model_file, data = schools_dat, 
#'                         iter = 100, chains = 2)
#'   } else {
#'   # the object from the above code was saved as rstan_example.rda
#'     load(infile)
#'   }
#'   tidy(rstan_example)
#'   tidy(rstan_example, conf.int = TRUE)
#'   
#'   td_mean <- tidy(rstan_example, conf.int = TRUE)
#'   td_median <- tidy(rstan_example, conf.int = TRUE, estimate.method = "median")
#'   
#'   library(dplyr)
#'   library(ggplot2)
#'   tds <- rbind(mutate(td_mean, method = "mean"),
#'                mutate(td_median, method = "median")) %>%
#'   mutate(type=ifelse(grepl("^theta",term),"theta",
#'               ifelse(grepl("^eta",term),"eta",
#'                      "other")))
#'   
#'   ggplot(tds, aes(estimate, term)) +
#'     geom_errorbarh(aes(xmin = conf.low, xmax = conf.high),height=0) +
#'     geom_point(aes(color = method))+
#'     facet_wrap(~type,scale="free",ncol=1)
#' } ## stan
#' 
#' if (requireNamespace("MCMCglmm", quietly = TRUE)) {
#'     data(PlodiaPO,package="MCMCglmm")  
#'     model1 <- MCMCglmm(PO~1, random=~FSfamily, data=PlodiaPO, verbose=FALSE)
#'     tidy(model1)
#' }
#' @importFrom stats median sd
#' @importFrom coda HPDinterval as.mcmc
#' @export
tidyMCMC <- function(x,
                     estimate.method = c("mean","median"),
                     conf.int = FALSE,
                     conf.level = 0.95,
                     conf.method = c("quantile","HPDinterval"),
                     drop.pars = c("lp__","deviance"),
                     ...) {

    estimate.method <- match.arg(estimate.method)
    conf.method <- match.arg(conf.method)
    
    ss <- as.matrix(x)  ## works natively on stanfit, mcmc.list, mcmc objects
    ss <- ss[, !colnames(ss) %in% drop.pars, drop=FALSE] 
    
    m <- switch(estimate.method,
                mean = colMeans(ss),
                median = apply(ss, 2, median))

    ret <- data.frame(estimate = m,
                      std.error = apply(ss, 2, sd))
    if (conf.int) {
        levs <- c((1 - conf.level) / 2, (1 + conf.level) / 2)

        ci <- switch(conf.method,
                     quantile = t(apply(ss, 2, stats::quantile, levs)),
                     HPDinterval(as.mcmc(ss), prob = conf.level))

        colnames(ci) <- c("conf.low", "conf.high")
        ret <- data.frame(ret, ci)
    }
    return(fix_data_frame(ret))
}


##' @rdname mcmc_tidiers
##' @importFrom coda as.mcmc
##' @export
tidy.rjags <- function(x,
                       estimate.method = "mean",
                       conf.int = FALSE,
                       conf.level = 0.95,
                       conf.method = "quantile",
                       ...) {
    tidyMCMC(as.mcmc(x$BUGS),
             estimate.method, conf.int, conf.level,
             conf.method, droppars = "deviance")
}

##' @rdname mcmc_tidiers
##' @export
tidy.stanfit <- tidyMCMC

##' @rdname mcmc_tidiers
##' @export
tidy.mcmc <- tidyMCMC

##' @rdname mcmc_tidiers
##' @importFrom plyr ldply
##' @export
tidy.MCMCglmm <- function(x,effects="fixed",scales,...) {
    if (!missing(scales)) stop("tidy.MCMCglmm doesn't yet implement scales")
    ## FIXME: allow scales= parameter to get varcov on sd/corr scale?
    clist <- c(fixed="Sol",ran_pars="VCV",ran_vals="Liab")
    comp <- clist[effects]
    ## override MCMCglmm internal component names
    ## FIXME:: have to work harder to retrieve group/term information
    ##  about random parameters
    return(plyr::ldply(setNames(x[comp],effects),
                 tidy,...,.id="effect"))
}
