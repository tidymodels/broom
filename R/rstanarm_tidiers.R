#' Tidying methods for an rstanarm model
#' 
#' These methods tidy the estimates from \code{\link[rstanarm]{stanreg-objects}}
#' (fitted model objects from the \pkg{rstanarm} package) into a summary.
#' 
#'
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#'
#' @seealso \code{\link[rstanarm]{summary.stanreg}}
#'
#' @name rstanarm_tidiers
#' 
#' @param x Fitted model object from the \pkg{rstanarm} package. See 
#'   \code{\link[rstanarm]{stanreg-objects}}.
#' @examples
#' if (require(rstanarm)) {
#'  fit <- stan_glmer(mpg ~ wt + (1|cyl) + (1+wt|gear), data = mtcars, 
#'                    iter = 500, chains = 2)
#'  tidy(fit, intervals = TRUE, prob = 0.5)
#'  tidy(fit, parameters = "hierarchical")
#'  tidy(fit, parameters = "varying")
#'  glance(fit, looic = TRUE, cores = 1)
#' }
#'  
NULL


#' @rdname rstanarm_tidiers
#' @param parameters One of \code{"non-varying"}, \code{"varying"}, or 
#'   \code{"hierarchical"} (can be abbreviated). See the Value section for 
#'   details.
#' @param prob See \code{\link[rstanarm]{posterior_interval}}.
#' @param intervals If \code{TRUE} columns for the lower and upper bounds of the
#'   \code{100*prob}\% posterior uncertainty intervals are included. See 
#'   \code{\link[rstanarm]{posterior_interval}} for details.
#' 
#' @return 
#' When \code{parameters="non-varying"} (the default), \code{tidy.stanreg} returns
#' one row for each coefficient, with three columns:
#' \item{term}{The name of the corresponding term in the model.}
#' \item{estimate}{A point estimate of the coefficient (posterior median).}
#' \item{std.error}{A standard error for the point estimate based on
#' \code{\link[stats]{mad}}. See the \emph{Uncertainty estimates} section in 
#' \code{\link[rstanarm]{print.stanreg}} for more details.}
#' 
#' For models with group-specific parameters (e.g., models fit with 
#' \code{\link[rstanarm]{stan_glmer}}), setting \code{parameters="varying"}
#' selects the group-level parameters instead of the non-varying regression 
#' coefficients. Addtional columns are added indicating the \code{level} and 
#' \code{group}. Specifying \code{parameters="hierarchical"} selects the
#' standard deviations and (for certain models) correlations of the group-level
#' parameters.
#' 
#' If \code{intervals=TRUE}, columns for the \code{lower} and 
#' \code{upper} values of the posterior intervals computed with 
#' \code{\link[rstanarm]{posterior_interval}} are also included.
#' 
#' @export
tidy.stanreg <- function(x, 
                         parameters = c("non-varying", "varying", "hierarchical"), 
                         intervals = FALSE, 
                         prob = 0.9,
                         ...) {
    
    parameters <- match.arg(parameters)
    if (!inherits(x, "lmerMod") && parameters != "non-varying")
        stop("Only non-varying parameters available for this model.")
    
    nn <- c("estimate", "std.error")
    ret_list <- list()
    if (parameters == "non-varying") {
        ret <- cbind(rstanarm::fixef(x), 
                     rstanarm::se(x)[names(rstanarm::fixef(x))])
        
        if (intervals) {
            cifix <- rstanarm::posterior_interval(x, pars = names(rstanarm::fixef(x)), 
                                                  prob = prob)
            ret <- data.frame(ret,cifix)
            nn <- c(nn,"lower","upper")
        }
        ret_list$non_varying <-
            fix_data_frame(ret, newnames = nn)
    }
    if (parameters == "hierarchical") {
        ret <- as.data.frame(rstanarm::VarCorr(x))
        ret[] <- lapply(ret, function(x) if (is.factor(x))
            as.character(x) else x)
        rscale <- "sdcor" # FIXME
        ran_prefix <- c("sd", "cor") # FIXME
        pfun <- function(x) {
            v <- na.omit(unlist(x))
            if (length(v)==0) v <- "Observation"
            p <- paste(v,collapse=".")
            if (!identical(ran_prefix,NA)) {
                p <- paste(ran_prefix[length(v)],p,sep="_")
            }
            return(p)
        }
        
        rownames(ret) <- paste(apply(ret[c("var1","var2")],1,pfun),
                               ret[,"grp"], sep = ".")
        ret_list$hierarchical <- fix_data_frame(ret[c("grp", rscale)],
                                                newnames = c("group", "estimate"))
    }
    
    if (parameters == "varying") {
        nn <- c("estimate", "std.error")
        s <- summary(x, pars = "varying")
        ret <- cbind(s[, "50%"], rstanarm::se(x)[rownames(s)])
        
        if (intervals) {
            ciran <- rstanarm::posterior_interval(x, regex_pars = "^b\\[",
                                                  prob = prob)
            ret <- data.frame(ret,ciran)
            nn <- c(nn,"lower","upper")
        }
        
        double_splitter <- function(x, split1, sel1, split2, sel2) {
            y <- unlist(lapply(strsplit(x, split = split1, fixed = TRUE), "[[", sel1))
            unlist(lapply(strsplit(y, split = split2, fixed = TRUE), "[[", sel2))
        }
        vv <- fix_data_frame(ret, newnames = nn)
        nn <- c("level", "group", "term", nn)
        nms <- vv$term
        vv$term <- NULL
        lev <- double_splitter(nms, ":", 2, "]", 1)
        grp <- double_splitter(nms, " ", 2, ":", 1)
        trm <- double_splitter(nms, " ", 1, "[", 2)
        vv <- data.frame(lev, grp, trm, vv)
        ret_list$varying <- fix_data_frame(vv, newnames = nn)
    }
    
    return(rbind.fill(ret_list))
}


#' @rdname rstanarm_tidiers
#' 
#' @param looic Should the LOO Information Criterion be included? See 
#'   \code{\link[rstanarm]{loo.stanreg}} for details. Note: for models fit to
#'   very large data this can be a slow computation.
#' @param ... For \code{glance}, if \code{looic=TRUE}, optional arguments to
#'   \code{\link[rstanarm]{loo.stanreg}}.
#' 
#' @return \code{glance} returns one row with the columns
#'   \item{algorithm}{The algorithm used to fit the model.}
#'   \item{pss}{The posterior sample size (except for models fit using 
#'   optimization).}
#'   \item{nobs}{The number of observations used to fit the model.}
#'   \item{sigma}{The square root of the estimated residual variance.}
#'   \item{looic}{If \code{looic=TRUE}, the LOO Information Criterion.}
#' 
#' @export
glance.stanreg <- function(x, looic = FALSE, ...) {
    sigma <- if (getRversion() >= "3.3.0") {
        get("sigma", asNamespace("stats"))
    } else {
        get("sigma", asNamespace("rstanarm"))
    }
    ret <- data.frame(algorithm = x$algorithm) 

    if (x$algorithm != "optimizing") {
        pss <- x$stanfit@sim$n_save
        if (x$algorithm == "sampling")
            pss <- sum(pss - x$stanfit@sim$warmup2)
        ret <- data.frame(ret, pss = pss)
    }
    
    ret <- data.frame(ret, nobs = stats::nobs(x), sigma = sigma(x))
    if (looic) {
        if (x$algorithm == "sampling") {
            looic <- rstanarm::loo(x, ...)$looic
            ret <- data.frame(ret, looic = looic)
        } else {
          message("looic only available for models fit using MCMC")  
        }
    }
    unrowname(ret)
}
