#' Tidying methods for an exponential random graph model
#'
#' These methods tidy the coefficients of an exponential random graph model
#' estimated with the \pkg{ergm} package into a summary, and construct
#' a one-row glance of the model's statistics. The methods should work with
#' any model that conforms to the \pkg{ergm} class, such as those
#' produced from weighted networks by the \pkg{ergm.count} package.
#'
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#'
#' @references Hunter DR, Handcock MS, Butts CT, Goodreau SM, Morris M (2008b).
#' \pkg{ergm}: A Package to Fit, Simulate and Diagnose Exponential-Family 
#' Models for Networks. \emph{Journal of Statistical Software}, 24(3). 
#' \url{http://www.jstatsoft.org/v24/i03/}.
#' 
#' @seealso \code{\link[ergm]{ergm}}, 
#' \code{\link[ergm]{control.ergm}}, 
#' \code{\link[ergm]{summary.ergm}}
#'
#' @name ergm_tidiers
#'
#' @param x an \pkg{ergm} object
#' @examples
#'
#' if (require("ergm")) {
#'     # Using the same example as the ergm package
#'     # Load the Florentine marriage network data
#'     data(florentine)
#'
#'     # Fit a model where the propensity to form ties between
#'     # families depends on the absolute difference in wealth
#'     gest <- ergm(flomarriage ~ edges + absdiff("wealth"))
#'
#'     # Show terms, coefficient estimates and errors
#'     tidy(gest)
#'
#'     # Show coefficients as odds ratios with a 99% CI
#'     tidy(gest, exponentiate = TRUE, conf.int = TRUE, conf.level = 0.99)
#'
#'     # Take a look at likelihood measures and other
#'     # control parameters used during MCMC estimation
#'     glance(gest)
#'     glance(gest, deviance = TRUE)
#'     glance(gest, mcmc = TRUE)
#' }
NULL

#' @rdname ergm_tidiers
#'
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level of the interval, used only if
#' \code{conf.int=TRUE}
#' @param exponentiate whether to exponentiate the coefficient estimates
#' and confidence intervals
#' @param quick whether to compute a smaller and faster version, containing
#' only the \code{term} and \code{estimate} columns.
#'
#' @details There is no \code{augment} method for \pkg{ergm} objects.
#'
#' @return \code{tidy.ergm} returns one row for each coefficient, with five columns:
#'   \item{term}{The term in the model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error}
#'   \item{mcmc.error}{The MCMC error}
#'   \item{p.value}{The two-sided p-value}
#'
#' If \code{conf.int=TRUE}, it also includes columns for \code{conf.low} and
#' \code{conf.high}.
#'
#' @export
tidy.ergm <- function(x, conf.int = FALSE, conf.level = .95,
                      exponentiate = FALSE, quick = FALSE, ...) {
    if (quick) {
        co <- x$coef
        ret <- data.frame(term = names(co), estimate = unname(co))
        return(process_ergm(ret, conf.int = FALSE, exponentiate = exponentiate))
    }
    co <- ergm::summary.ergm(x, ...)$coefs
    
    nn <- c("estimate", "std.error", "mcmc.error", "p.value")
    if (inherits(co, "listof")) {
        # multiple response variables
        ret <- plyr::ldply(co, fix_data_frame, nn[1:ncol(co[[1]])],
                           .id = "response")
        ret$response <- stringr::str_replace(ret$response, "Response ", "")
    } else {
        ret <- fix_data_frame(co, nn[1:ncol(co)])
    }
    
    process_ergm(ret, x, conf.int = conf.int, conf.level = conf.level,
                 exponentiate = exponentiate)
}

#' @rdname ergm_tidiers
#'
#' @param deviance whether to report null and residual deviance for the model,
#' along with degrees of freedom; defaults to \code{FALSE}
#' @param mcmc whether to report MCMC interval, burn-in and sample size used to
#' estimate the model; defaults to \code{FALSE}
#' @param ... extra arguments passed to \code{\link[ergm]{summary.ergm}}
#'
#' @return \code{glance.ergm} returns a one-row data.frame with the columns
#'   \item{independence}{Whether the model assumed dyadic independence}
#'   \item{iterations}{The number of iterations performed before convergence}
#'   \item{logLik}{If applicable, the log-likelihood associated with the model}
#'   \item{AIC}{The Akaike Information Criterion}
#'   \item{BIC}{The Bayesian Information Criterion}
#'
#' If \code{deviance=TRUE}, and if the model supports it, the
#' data frame will also contain the columns
#'   \item{null.deviance}{The null deviance of the model}
#'   \item{df.null}{The degrees of freedom of the null deviance}
#'   \item{residual.deviance}{The residual deviance of the model}
#'   \item{df.residual}{The degrees of freedom of the residual deviance}
#'
#' Last, if \code{mcmc=TRUE}, the data frame will also contain
#' the columns
#'   \item{MCMC.interval}{The interval used during MCMC estimation}
#'   \item{MCMC.burnin}{The burn-in period of the MCMC estimation}
#'   \item{MCMC.samplesize}{The sample size used during MCMC estimation}
#'
#' @export
glance.ergm <- function(x, deviance = FALSE, mcmc = FALSE, ...) {
    # will show appropriate warnings about standard errors, pseudolikelihood etc.
    s <- ergm::summary.ergm(x, ...)
    # dyadic (in)dependence and number of MCMLE iterations
    ret <- data.frame(independence = s$independence, iterations = x$iterations)
    # log-likelihood
    ret$logLik <- tryCatch(as.numeric(ergm::logLik.ergm(x)), error = function(e) NULL)
    # null and residual deviance
    if (deviance & !is.null(ret$logLik)) {
        dyads <- ergm::get.miss.dyads(x$constrained, x$constrained.obs)
        dyads <- statnet.common::NVL(dyads, network::network.initialize(1))
        dyads <- network::network.edgecount(dyads)
        dyads <- network::network.dyadcount(x$network, FALSE) - dyads
        
        ret$null.deviance <- ergm::logLikNull(x)
        ret$null.deviance <- ifelse(is.na(ret$null.deviance), 0, -2 * ret$null.deviance)
        ret$df.null <- dyads
        
        ret$residual.deviance <- -2 * ret$logLik
        ret$df.residual <- dyads - length(x$coef)
    }
    
    # AIC and BIC
    ret$AIC <- tryCatch(stats::AIC(x), error = function(e) NULL)
    ret$BIC <- tryCatch(stats::BIC(x), error = function(e) NULL)
    
    if (mcmc) {
        ret <- cbind(ret, data.frame(
            MCMC.interval = x$control$MCMC.interval,
            MCMC.burnin = x$control$MCMC.burnin,
            MCMC.samplesize = x$control$MCMC.samplesize))
    }
    
    ret <- unrowname(ret)
    ret
}

#' helper function to process a tidied ergm object
#'
#' Optionally exponentiates the coefficients, and optionally adds
#' a confidence interval, to a tidied ergm object.
#'
#' @param ret data frame with a tidied version of a coefficient matrix
#' @param x an "ergm" object
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level of the interval, used only if
#' \code{conf.int=TRUE}
#' @param exponentiate whether to exponentiate the coefficient estimates
#' and confidence intervals (typical for logistic regression)
process_ergm <- function(ret, x, conf.int = FALSE, conf.level = .95,
                         exponentiate = FALSE) {
    if (exponentiate) {
        # save transformation function for use on confidence interval
        if (is.null(x$glm) ||
            (x$glm$family$link != "logit" && x$glm$family$link != "log")) {
            warning(paste("Exponentiating coefficients, but model did not use",
                          "a log or logit link function"))
        }
        trans <- exp
    } else {
        trans <- identity
    }
    
    if (conf.int) {
        z <- stats::qnorm(1 - (1 - conf.level) / 2)
        CI <- cbind(conf.low = ret$estimate - z * ret$std.error,
                    conf.high = ret$estimate + z * ret$std.error)
        ret <- cbind(ret, trans(unrowname(CI)))
    }
    ret$estimate <- trans(ret$estimate)
    
    ret
}
