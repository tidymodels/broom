#' Tidying methods for an rstanarm model
#' 
#' These methods tidy the estimates from \code{\link[rstanarm]{stanreg-objects}}
#' into a summary, augment the original data with information on the fitted
#' values and residuals, and construct a one-row glance of the model's
#' statistics.
#'
#' @details If you have missing values in your model data, you may need to refit
#' the model with \code{na.action = na.exclude}.
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
#' @param prob,pars,regex_pars See \code{\link[rstanarm]{posterior_interval}}.
#' @param ... Currently ignored.
#' @examples
#' if (require(rstanarm)) {
#'  tidy(example_model)
#'  tidy(example_model, effects = "hierarchical")
#'  tidy(example_model, effects = "varying")
#'  
#'  fit <- stan_glm(mpg ~ wt + cyl, data = mtcars)
#'  tidy(fit, intervals = TRUE, prob = 0.5)
#'  
#'  fit2 <- stan_glmer(mpg ~ wt + (1 | cyl) + (1 + wt | gear), data = mtcars)
#'  tidy(fit2, effects = "varying", intervals = TRUE, prob = 0.95)
#' }
NULL


#' @rdname rstanarm_tidiers
#' 
#' @param exponentiate Should estimates be exponentiated?
#' @param intervals  \code{TRUE} columns for the lower and upper bounds of the
#'   \code{100*prob}/% posterior intervals are included. See
#'   \code{\link[rstanarm]{posterior_interval}}.
#' 
#' @return 
#' When \code{effects="non-varying"}, \code{tidy.stanreg} returns one
#' row for each coefficient, with three columns:
#' \item{term}{The term in the model}
#' \item{estimate}{Estimated coefficient (posterior median)}
#' \item{std.error}{Standard error based on \code{mad}. See the 
#'  \emph{Uncertainty estimates} section in
#'  \code{\link[rstanarm]{print.stanreg}} for more details.}
#' 
#' When \code{effects="varying"} estimates of group-specific are used instead of
#' the non-varying parameters. Addtional columns are added indicating the
#' \code{level} and \code{group}.
#' 
#' If \code{intervals=TRUE}, columns for the \code{lower} and 
#' \code{upper} values of the posterior intervals computed with 
#' \code{\link[rstanarm]{posterior_interval}} are also included.
#' 
#' @export
tidy.stanreg <- function(x, effects = c("non-varying", "hierarchical", "varying"), 
                         intervals = FALSE, 
                         prob = 0.9,
                         ...) {
    
    effects <- match.arg(effects)
    if (!inherits(x, "lmerMod") && effects != "non-varying")
        stop("Only non-varying effects available for this model.")
    
    nn <- c("estimate", "std.error")
    ret_list <- list()
    if (effects == "non-varying") {
        # return tidied fixed effects rather than random
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
    if (effects == "hierarchical") {
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
    
    if (effects == "varying") {
        nn <- c("estimate", "std.error")
        s <- x$stan_summary
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
