#' Tidying methods for mixed effects models
#' 
#' These methods tidy the coefficients of mixed effects models, particularly
#' responses of the \code{merMod} class
#' 
#' @param x An object of class \code{merMod}, such as those from \code{lmer},
#' \code{glmer}, or \code{nlmer}
#' 
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#' 
#' @name lme4_tidiers
#'
#' @examples
#' 
#' if (require("lme4")) {
#'     # example regressions are from lme4 documentation
#'     lmm1 <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
#'     tidy(lmm1)
#'     tidy(lmm1, effects = "fixed")
#'     tidy(lmm1, effects = "fixed", conf.int=TRUE)
#'     tidy(lmm1, effects = "fixed", conf.int=TRUE, conf.method="profile")
#'     tidy(lmm1, effects = "ran_modes", conf.int=TRUE)
#'     head(augment(lmm1, sleepstudy))
#'     glance(lmm1)
#'     
#'     glmm1 <- glmer(cbind(incidence, size - incidence) ~ period + (1 | herd),
#'                   data = cbpp, family = binomial)
#'     tidy(glmm1)
#'     tidy(glmm1, effects = "fixed")
#'     head(augment(glmm1, cbpp))
#'     glance(glmm1)
#'     
#'     startvec <- c(Asym = 200, xmid = 725, scal = 350)
#'     nm1 <- nlmer(circumference ~ SSlogis(age, Asym, xmid, scal) ~ Asym|Tree,
#'                   Orange, start = startvec)
#'     tidy(nm1)
#'     tidy(nm1, effects = "fixed")
#'     head(augment(nm1, Orange))
#'     glance(nm1)
#' }
NULL

#' @rdname lme4_tidiers
#' 
#' @param effects A character vector including one or more of "fixed" (fixed-effect parameters); "ran_pars" (variances and covariances or standard deviations and correlations of random effect terms); "ran_modes" (conditional modes/BLUPs/latent variable estimates); or "coefs" (predicted parameter values for each group, as returned by \code{\link{coef.merMod}})
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level for CI
#' @param conf.method method for computing confidence intervals (see \code{lme4::confint.merMod})
#' @param scales scales on which to report the variables: for random effects, the choices are \sQuote{"sdcor"} (standard deviations and correlations: the default if \code{scales} is \code{NULL}) or \sQuote{"vcov"} (variances and covariances). \code{NA} means no transformation, appropriate e.g. for fixed effects; inverse-link transformations (exponentiation or logistic) are not yet implemented, but may be in the future.
#' @param ran_prefix a length-2 character vector specifying the strings to use as prefixes for self- (variance/standard deviation) and cross- (covariance/correlation) random effects terms
#' 
#' @return \code{tidy} returns one row for each estimated effect, either
#' with groups depending on the \code{effects} parameter.
#' It contains the columns
#'   \item{group}{the group within which the random effect is being estimated: \code{"fixed"} for fixed effects}
#'   \item{level}{level within group (\code{NA} except for modes)}
#'   \item{term}{term being estimated}
#'   \item{estimate}{estimated coefficient}
#'   \item{std.error}{standard error}
#'   \item{statistic}{t- or Z-statistic (\code{NA} for modes)}
#'   \item{p.value}{P-value computed from t-statistic (may be missing/NA)}
#'
#' @importFrom plyr ldply rbind.fill
#' @import dplyr
#' @importFrom tidyr gather spread
#' @importFrom nlme VarCorr ranef
## FIXME: is it OK/sensible to import these from (priority='recommended')
## nlme rather than (priority=NA) lme4?
#' 
#' @export
tidy.merMod <- function(x, effects = c("ran_pars","fixed"),
                        scales = NULL, ## c("sdcor","vcov",NA),
                        ran_prefix=NULL,
                        conf.int = FALSE,
                        conf.level = 0.95,
                        conf.method = "Wald",
                        debug=FALSE,
                        ...) {
    effect_names <- c("ran_pars", "fixed", "ran_modes", "coefs")
    if (!is.null(scales)) {
        if (length(scales) != length(effects)) {
            stop("if scales are specified, values (or NA) must be provided ",
                 "for each effect")
        }
    }
    if (length(miss <- setdiff(effects,effect_names))>0)
        stop("unknown effect type ",miss)
    base_nn <- c("estimate", "std.error", "statistic", "p.value")
    ret_list <- list()
    if ("fixed" %in% effects) {
        # return tidied fixed effects rather than random
        ss <- summary(x)
        ret <- stats::coef(ss)
        if (debug) {
            cat("output from coef(summary(x)):\n")
            print(coef(ss))
        }
        if (is(x,"merModLmerTest")) {
            ret <- ret[,!colnames(ret) %in% "df"]
        }            

        # p-values may or may not be included
        nn <- base_nn[1:ncol(ret)]

        if (conf.int) {
            if (is(x,"merMod")) {
                cifix <- confint(x,parm="beta_",method=conf.method,...)
            } else {
                if (is(x,"rlmerMod")) {
                    ## hack: rlmerMod has no confint() method,
                    ##  confint.default breaks
                    cc <- class(x)
                    class(x) <- "merMod"
                    if (method!="Wald") {
                        warning("only Wald method implemented for rlmerMod objects")
                    }
                    cifix <- confint(x,method="Wald", ...)
                    class(x) <- cc
                } else {
                    ci <- confint(x,...)
                }
            }
            ret <- data.frame(ret,cifix)
            nn <- c(nn,"conf.low","conf.high")
        }
        if ("ran_pars" %in% effects || "ran_modes" %in% effects) {
            ret <- data.frame(ret,group="fixed")
            nn <- c(nn,"group")
        }
        ret_list$fixed <-
            fix_data_frame(ret, newnames = nn)
    }
    if ("ran_pars" %in% effects) {
        if (is.null(scales)) {
            rscale <- "sdcor"
        } else rscale <- scales[effects=="ran_pars"]
        if (!rscale %in% c("sdcor","vcov"))
            stop(sprintf("unrecognized ran_pars scale %s",sQuote(rscale)))
        vc <- VarCorr(x)
        if (!is(x,"merMod") && grepl("^VarCorr",class(vc)[1])) {
            if (!is(x,"rlmerMod")) {
                ## hack: attempt to augment glmmADMB (or other)
                ##   values so we can use as.data.frame.VarCorr.merMod
                vc <- lapply(vc,
                             function(x) {
                    attr(x,"stddev") <- sqrt(diag(x))
                    attr(x,"correlation") <- cov2cor(x)
                    x
                })
                attr(vc,"useScale") <- (family(x)$family=="gaussian")
            }
            class(vc) <- "VarCorr.merMod"
        }
        ret <- as.data.frame(vc)
        ret[] <- lapply(ret, function(x) if (is.factor(x))
                                 as.character(x) else x)
        if (is.null(ran_prefix)) {
            ran_prefix <- switch(rscale,
                                 vcov=c("var","cov"),
                                 sdcor=c("sd","cor"))
        }
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

        ## FIXME: this is ugly, but maybe necessary?
        ## set 'term' column explicitly, disable fix_data_frame
        ##  rownames -> term conversion
        ## rownames(ret) <- seq(nrow(ret))

        if (conf.int) {
            ciran <- confint(x,parm="theta_",method=conf.method,...)
            ret <- data.frame(ret,ciran)
            nn <- c(nn,"conf.low","conf.high")
        }
        
        ## replicate lme4:::tnames, more or less
        ret_list$ran_pars <- fix_data_frame(ret[c("grp", rscale)],
                                            newnames = c("group", "estimate"))
    }
    if ("ran_modes" %in% effects) {
        ## fix each group to be a tidy data frame

        nn <- c("estimate", "std.error")
        re <- ranef(x,condVar=TRUE)
        getSE <- function(x) {
            v <- attr(x,"postVar")
            setNames(as.data.frame(sqrt(t(apply(v,3,diag)))),
                     colnames(x))
        }
        fix <- function(g,re,.id) {
             newg <- fix_data_frame(g, newnames = colnames(g), newcol = "level")
             # fix_data_frame doesn't create a new column if rownames are numeric,
             # which doesn't suit our purposes
             newg$level <- rownames(g)
             newg$type <- "estimate"

             newg.se <- getSE(re)
             newg.se$level <- rownames(re)
             newg.se$type <- "std.error"

             data.frame(rbind(newg,newg.se),.id=.id,
                        check.names=FALSE)
                        ## prevent coercion of variable names
        }

        mm <- do.call(rbind,Map(fix,coef(x),re,names(re)))

        ## block false-positive warnings due to NSE
        type <- spread <- est <- NULL
        mm %>% gather(term, estimate, -.id, -level, -type) %>%
            spread(type,estimate) -> ret

        ## FIXME: doesn't include uncertainty of population-level estimate

        if (conf.int) {
            if (conf.method != "Wald")
                stop("only Wald CIs available for conditional modes")

            mult <- qnorm((1+conf.level)/2)
            ret <- transform(ret,
                             conf.low=estimate-mult*std.error,
                             conf.high=estimate+mult*std.error)
        }

        ret <- dplyr::rename(ret,group=.id)
        ret_list$ran_modes <- ret
    }
    ## copied from nlme_tidiers.R ... refactor/DRY!
    if ("coefs" %in% effects) {
        fix <- function(g) {
            newg <- fix_data_frame(g, newnames = colnames(g), newcol = "level")
            ## fix_data_frame doesn't create a new column if rownames are numeric,
            ## which doesn't suit our purposes
            newg$level <- rownames(g)
            cbind(.id = attr(g,"grpNames"),newg )
        }

        ## combine them and gather terms
        ret <-  fix(stats::coef(x))    %>%
            tidyr::gather(term, estimate, -.id, -level)
        colnames(ret)[1] <- "group"
        ret_list$coef <- ret
    }

    ## use ldply to get 'effect' added as a column
    return(plyr::ldply(ret_list,identity,.id="effect"))
}

#' @export
tidy.rlmerMod <- broom:::tidy.merMod

#' @rdname lme4_tidiers
#' 
#' @param data original data this was fitted on; if not given this will
#' attempt to be reconstructed
#' @param newdata new data to be used for prediction; optional
#' 
#' @template augment_NAs
#' 
#' @return \code{augment} returns one row for each original observation,
#' with columns (each prepended by a .) added. Included are the columns
#'   \item{.fitted}{predicted values}
#'   \item{.resid}{residuals}
#'   \item{.fixed}{predicted values with no random effects}
#' 
#' Also added for "merMod" objects, but not for "mer" objects,
#' are values from the response object within the model (of type
#' \code{lmResp}, \code{glmResp}, \code{nlsResp}, etc). These include \code{".mu",
#' ".offset", ".sqrtXwt", ".sqrtrwt", ".eta"}.
#'
#' @export
augment.merMod <- function(x, data = stats::model.frame(x), newdata, ...) {    
    # move rownames if necessary
    if (missing(newdata)) {
        newdata <- NULL
    }
    ret <- augment_columns(x, data, newdata, se.fit = NULL)
    
    # add predictions with no random effects (population means)
    predictions <- stats::predict(x, re.form = NA)
    # some cases, such as values returned from nlmer, return more than one
    # prediction per observation. Not clear how those cases would be tidied
    if (length(predictions) == nrow(ret)) {
        ret$.fixed <- predictions
    }

    # columns to extract from resp reference object
    # these include relevant ones that could be present in lmResp, glmResp,
    # or nlsResp objects

    respCols <- c("mu", "offset", "sqrtXwt", "sqrtrwt", "weights", "wtres", "gam", "eta")
    cols <- lapply(respCols, function(n) x@resp[[n]])
    names(cols) <- paste0(".", respCols)
    cols <- as.data.frame(compact(cols))  # remove missing fields
    
    cols <- insert_NAs(cols, ret)
    if (length(cols) > 0) {
        ret <- cbind(ret, cols)
    }

    unrowname(ret)
}


#' @rdname lme4_tidiers
#' 
#' @param ... extra arguments (not used)
#' 
#' @return \code{glance} returns one row with the columns
#'   \item{sigma}{the square root of the estimated residual variance}
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'   \item{deviance}{deviance}
#' 
#' @export
glance.merMod <- function(x, ...) {
    # We cannot use stats::sigma or lme4::sigma here, even in an
    # if statement, since that leads to R CMD CHECK warnings on 3.2
    # or dev R, respectively
    sigma <- if (getRversion() >= "3.3.0") {
        get("sigma", asNamespace("stats"))
    } else {
        get("sigma", asNamespace("lme4"))
    }
    ret <- unrowname(data.frame(sigma = sigma(x)))
    finish_glance(ret, x)
}

##' Augmentation for random effects (for caterpillar plots etc.)
##' 
##' @param x ranef (conditional mode) information from an lme4 fit, using \code{ranef(.,condVar=TRUE)}
##' @param ci.level level for confidence intervals
##' @param reorder reorder levels by conditional mode values?
##' @param order.var numeric or character: which variable to use for ordering levels?
##' @importFrom reshape2 melt
##' @importFrom plyr ldply
##' @examples
##' if (require("lme4"))
##' fit <- lmer(Reaction~Days+(Days|Subject),sleepstudy)
##' rr <- ranef(fit,condVar=TRUE)
##' aa <- augment(rr)
##' ## Q-Q plot:
##' g0 <- ggplot(aa,aes(estimate,qq,xmin=lb,xmax=ub))+
##'    geom_errorbarh(height=0)+
##'    geom_point()+facet_wrap(~variable,scale="free_x")
##' ## regular caterpillar plot:
##' g1 <- ggplot(aa,aes(estimate,level,xmin=lb,xmax=ub))+
##'    geom_errorbarh(height=0)+
##'    geom_vline(xintercept=0,lty=2)+
##'    geom_point()+facet_wrap(~variable,scale="free_x")
##' ## emphasize extreme values
##' aa2 <- ddply(aa,c("grp","level"),
##'             transform,
##'             keep=any(estimate/std.error>2))
##' aa3 <- subset(aa2,keep)
##' ## Update caterpillar plot with extreme levels highlighted:
##' ggplot(aa2,aes(estimate,level,xmin=lb,xmax=ub,colour=factor(keep)))+
##'    geom_errorbarh(height=0)+
##'    geom_vline(xintercept=0,lty=2)+
##'    geom_point()+facet_wrap(~variable,scale="free_x")+
##'    scale_colour_manual(values=c("black","red"),guide=FALSE)
##' @export 
augment.ranef.mer <- function(x,
                                 ci.level=0.9,
                                 reorder=TRUE,
                                 order.var=1) {
    tmpf <- function(z) {
        if (is.character(order.var) && !order.var %in% names(z)) {
            order.var <- 1
            warning("order.var not found, resetting to 1")
        }
        ## would use plyr::name_rows, but want levels first
        zz <- data.frame(level=rownames(z),z,check.names=FALSE)
        if (reorder) {
            ## if numeric order var, add 1 to account for level column
            ov <- if (is.numeric(order.var)) order.var+1 else order.var
            zz$level <- reorder(zz$level, zz[,order.var+1], FUN=identity)
        }
        ## Q-Q values, for each column separately
        qq <- c(apply(z,2,function(y) {
                  qnorm(ppoints(nrow(z)))[order(order(y))]
              }))
        rownames(zz) <- NULL
        pv   <- attr(z, "postVar")
        cols <- 1:(dim(pv)[1])
        se   <- unlist(lapply(cols, function(i) sqrt(pv[i, i, ])))
        ## n.b.: depends on explicit column-major ordering of se/melt
        zzz <- cbind(melt(zz,id.vars="level",value.name="estimate"),
                     qq=qq,std.error=se)
        ## reorder columns:
        subset(zzz,select=c(variable, level, estimate, qq, std.error))
    }
    dd <- ldply(x,tmpf,.id="grp")
    ci.val <- -qnorm((1-ci.level)/2)
    transform(dd,
              ## p=2*pnorm(-abs(estimate/std.error)), ## 2-tailed p-val
              lb=estimate-ci.val*std.error,
              ub=estimate+ci.val*std.error)
}
