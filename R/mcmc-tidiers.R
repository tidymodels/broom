#' Tidying methods for MCMC (Stan, JAGS, etc.) fits
#' 
#' MCMC tidiers are deprecated.
#'
#' @param x an object of class \sQuote{"stanfit"}
#' @param pars (character) specification of which parameters to include
#' @param estimate.method method for computing point estimate ("mean" or median")
#' @param conf.int (logical) include confidence interval?
#' @param conf.level probability level for CI
#' @param conf.method method for computing confidence intervals
#' ("quantile" or "HPDinterval")
#' @param droppars Parameters not to include in the output (such
#' as log-probability information)
#' @param rhat,ess (logical) include Rhat and/or effective sample size estimates?
#' @param ... unused
#'
#' @name mcmc_tidiers
#'
#' @export
tidyMCMC <- function(x,
                     pars, ## ?? do other
                     estimate.method = "mean",
                     conf.int = FALSE,
                     conf.level = 0.95,
                     conf.method = "quantile",
                     droppars = "lp__",
                     rhat = FALSE,
                     ess = FALSE,
                     ...) {
  .Deprecated()
  stan <- inherits(x, "stanfit")
  ss <- if (stan) as.matrix(x, pars = pars) else as.matrix(x)
  ss <- ss[, !colnames(ss) %in% droppars, drop = FALSE] ## drop log-probability info
  if (!missing(pars) && !stan) {
    if (length(badpars <- which(!pars %in% colnames(ss))) > 0) {
      stop("unrecognized parameters: ", pars[badpars])
    }
    ss <- ss[, pars]
  }

  estimate.method <- match.arg(estimate.method, c("mean", "median"))
  m <- switch(estimate.method,
    mean = colMeans(ss),
    median = apply(ss, 2, stats::median)
  )

  ret <- data.frame(
    estimate = m,
    std.error = apply(ss, 2, stats::sd)
  )
  if (conf.int) {
    levs <- c((1 - conf.level) / 2, (1 + conf.level) / 2)

    conf.method <- match.arg(conf.method, c("quantile", "HPDinterval"))
    ci <- switch(conf.method,
      quantile = t(apply(ss, 2, stats::quantile, levs)),
      coda::HPDinterval(coda::as.mcmc(ss), prob = conf.level)
    )

    colnames(ci) <- c("conf.low", "conf.high")
    ret <- data.frame(ret, ci)
  }

  if (rhat || ess) {
    if (!stan) warning("ignoring 'rhat' and 'ess' (only available for stanfit objects)")
    summ <- rstan::summary(x, pars = pars, probs = NULL)$summary[, c("Rhat", "n_eff"), drop = FALSE]
    summ <- summ[!dimnames(summ)[[1L]] %in% droppars, , drop = FALSE]
    if (rhat) ret$rhat <- summ[, "Rhat"]
    if (ess) ret$ess <- as.integer(round(summ[, "n_eff"]))
  }
  return(fix_data_frame(ret))
}


##' @rdname mcmc_tidiers
##' @export
tidy.rjags <- function(x,
                       pars, ## ?? do other
                       estimate.method = "mean",
                       conf.int = FALSE,
                       conf.level = 0.95,
                       conf.method = "quantile",
                       ...) {
  .Deprecated()
  tidyMCMC(coda::as.mcmc(x$BUGS),
    pars,
    estimate.method, conf.int, conf.level,
    conf.method,
    droppars = "deviance"
  )
}

##' @rdname mcmc_tidiers
##' @export
tidy.stanfit <- function(...) {
  .Deprecated()
  tidyMCMC(...)
}
