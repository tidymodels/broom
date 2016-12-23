# tidying functions for the survival package
# http://cran.r-project.org/web/packages/survival/index.html
# In particular, tidies objects of the following classes:
#   - aareg
#   - cch
#   - coxph
#   - pyears
#   - survexp
#   - survfit
#   - survreg


#' Tidiers for aareg objects
#' 
#' These tidy the coefficients of Aalen additive regression objects.
#' 
#' @param x an "aareg" object
#' @param ... extra arguments (not used)
#' 
#' @template boilerplate
#' 
#' @examples
#' 
#' if (require("survival", quietly = TRUE)) {
#'     afit <- aareg(Surv(time, status) ~ age + sex + ph.ecog, data=lung,
#'                   dfbeta=TRUE)
#'     summary(afit)
#'     tidy(afit)
#' }
#' 
#' @name aareg_tidiers


#' @name aareg_tidiers
#' 
#' @return \code{tidy.aareg} returns one row for each coefficient, with
#' the columns
#'   \item{term}{name of coefficient}
#'   \item{estimate}{estimate of the slope}
#'   \item{statistic}{test statistic for coefficient}
#'   \item{std.error}{standard error of statistic}
#'   \item{robust.se}{robust version of standard error estimate}
#'   \item{z}{z score}
#'   \item{p.value}{p-value}
#' 
#' @export
tidy.aareg <- function(x, ...) {
    nn <- c("estimate", "statistic", "std.error", "robust.se", "statistic.z",
            "p.value")
    fix_data_frame(summary(x)$table, nn)
}


#' @name aareg_tidiers
#' 
#' @return \code{glance} returns a one-row data frame containing
#'   \item{statistic}{chi-squared statistic}
#'   \item{p.value}{p-value based on chi-squared statistic}
#'   \item{df}{degrees of freedom used by coefficients}
#' 
#' @export
glance.aareg <- function(x, ...) {
    s <- summary(x)
    chi <- s$chisq
    df <- length(s$test.statistic) - 1
    
    data.frame(statistic = chi, p.value = 1 - stats::pchisq(chi, df),
               df = df)
}


#' tidiers for case-cohort data
#' 
#' Tidiers for case-cohort analyses: summarize each estimated coefficient,
#' or test the overall model.
#' 
#' @param x a "cch" object
#' @param conf.level confidence level for CI
#' @param ... extra arguments (not used)
#' 
#' @details It is not clear what an \code{augment} method would look like,
#' so none is provided. Nor is there currently any way to extract the
#' covariance or the residuals.
#' 
#' @template boilerplate
#' 
#' @examples
#' 
#' if (require("survival", quietly = TRUE)) {
#'     # examples come from cch documentation
#'     subcoh <- nwtco$in.subcohort
#'     selccoh <- with(nwtco, rel==1|subcoh==1)
#'     ccoh.data <- nwtco[selccoh,]
#'     ccoh.data$subcohort <- subcoh[selccoh]
#'     ## central-lab histology 
#'     ccoh.data$histol <- factor(ccoh.data$histol,labels=c("FH","UH"))
#'     ## tumour stage
#'     ccoh.data$stage <- factor(ccoh.data$stage,labels=c("I","II","III" ,"IV"))
#'     ccoh.data$age <- ccoh.data$age/12 # Age in years
#'     
#'     fit.ccP <- cch(Surv(edrel, rel) ~ stage + histol + age, data = ccoh.data,
#'                    subcoh = ~subcohort, id= ~seqno, cohort.size = 4028)
#'     
#'     tidy(fit.ccP)
#'     
#'     # coefficient plot
#'     library(ggplot2)
#'     ggplot(tidy(fit.ccP), aes(x = estimate, y = term)) + geom_point() +
#'         geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), height = 0) +
#'         geom_vline(xintercept = 0)
#'     
#'     # compare between methods
#'     library(dplyr)
#'     fits <- data_frame(method = c("Prentice", "SelfPrentice", "LinYing")) %>%
#'         group_by(method) %>%
#'         do(tidy(cch(Surv(edrel, rel) ~ stage + histol + age, data = ccoh.data,
#'                     subcoh = ~subcohort, id= ~seqno, cohort.size = 4028,
#'                     method = .$method)))
#'     
#'     # coefficient plots comparing methods
#'     ggplot(fits, aes(x = estimate, y = term, color = method)) + geom_point() +
#'         geom_errorbarh(aes(xmin = conf.low, xmax = conf.high)) +
#'         geom_vline(xintercept = 0)
#' }
#' 
#' @seealso \link{cch}
#' 
#' @name cch_tidiers


#' @rdname cch_tidiers
#' 
#' @template coefficients
#' 
#' @export
tidy.cch <- function(x, conf.level = .95, ...) {
    s <- summary(x)
    co <- stats::coefficients(s)
    ret <- fix_data_frame(co, newnames = c("estimate", "std.error", "statistic", "p.value"))
    
    # add confidence interval
    CI <- unrowname(stats::confint(x, level = conf.level))
    colnames(CI) <- c("conf.low", "conf.high")
    cbind(ret, CI)
}


#' @rdname cch_tidiers
#' 
#' @return \code{glance} returns a one-row data.frame with the following
#' columns:
#'   \item{score}{score}
#'   \item{rscore}{rscore}
#'   \item{p.value}{p-value from Wald test}
#'   \item{iter}{number of iterations}
#'   \item{n}{number of predictions}
#'   \item{nevent}{number of events}
#' 
#' @export
glance.cch <- function(x, ...) {
    ret <- compact(unclass(x)[c("score", "rscore", "wald.test", "iter",
                                "n", "nevent")])
    ret <- as.data.frame(ret)
    plyr::rename(ret, c("wald.test" = "p.value"))
}


#' Tidiers for coxph object
#' 
#' Tidy the coefficients of a Cox proportional hazards regression model,
#' construct predictions, or summarize the entire model into a single row.
#' 
#' @param x "coxph" object
#' @param data original data for \code{augment}
#' @param exponentiate whether to report the estimate and confidence intervals
#' on an exponential scale
#' @param conf.int confidence level to be used for CI
#' @param newdata new data on which to do predictions
#' @param type.predict type of predicted value (see \code{\link{predict.coxph}})
#' @param type.residuals type of residuals (see \code{\link{residuals.coxph}})
#' @param ... Extra arguments, not used
#' 
#' @name coxph_tidiers
#' 
#' @examples
#' 
#' if (require("survival", quietly = TRUE)) {
#'     cfit <- coxph(Surv(time, status) ~ age + sex, lung)
#' 
#'     tidy(cfit)
#'     tidy(cfit, exponentiate = TRUE)
#' 
#'     lp <- augment(cfit, lung)
#'     risks <- augment(cfit, lung, type.predict = "risk")
#'     expected <- augment(cfit, lung, type.predict = "expected")
#' 
#'     glance(cfit)
#'     
#'     # also works on clogit models
#'     resp <- levels(logan$occupation)
#'     n <- nrow(logan)
#'     indx <- rep(1:n, length(resp))
#'     logan2 <- data.frame(logan[indx,],
#'                          id = indx,
#'                          tocc = factor(rep(resp, each=n)))
#'     logan2$case <- (logan2$occupation == logan2$tocc)
#'
#'     cl <- clogit(case ~ tocc + tocc:education + strata(id), logan2)
#'     tidy(cl)
#'     glance(cl)
#'     
#'     library(ggplot2)
#'     ggplot(lp, aes(age, .fitted, color = sex)) + geom_point()
#'     ggplot(risks, aes(age, .fitted, color = sex)) + geom_point()
#'     ggplot(expected, aes(time, .fitted, color = sex)) + geom_point()
#' }


#' @rdname coxph_tidiers
#' 
#' @return \code{tidy} returns a data.frame with one row for each term,
#' with columns
#'   \item{estimate}{estimate of slope}
#'   \item{std.error}{standard error of estimate}
#'   \item{statistic}{test statistic}
#'   \item{p.value}{p-value}
#' 
#' @export
tidy.coxph <- function(x, exponentiate = FALSE, conf.int = .95, ...) {
    s <- summary(x, conf.int = conf.int)
    co <- stats::coef(s)

    if (s$used.robust)
        nn <- c("estimate", "std.error", "robust.se", "statistic", "p.value")
    else
        nn <- c("estimate", "std.error", "statistic", "p.value")

    ret <- fix_data_frame(co[, -2, drop=FALSE], nn)
    
    if (exponentiate) {
        ret$estimate <- exp(ret$estimate)
    }
    if (!is.null(s$conf.int)) {
        CI <- as.matrix(unrowname(s$conf.int[, 3:4, drop=FALSE]))
        colnames(CI) <- c("conf.low", "conf.high")
        if (!exponentiate) {
            CI <- log(CI)
        }
        ret <- cbind(ret, CI)
    }
    
    ret
}


#' @rdname coxph_tidiers
#' 
#' @template augment_NAs
#' 
#' @return \code{augment} returns the original data.frame with additional
#' columns added:
#'   \item{.fitted}{predicted values}
#'   \item{.se.fit}{standard errors }
#'   \item{.resid}{residuals (not present if \code{newdata} is provided)}
#' 
#' @export
augment.coxph <- function(x, data = stats::model.frame(x), newdata,
                          type.predict = "lp", type.residuals = "martingale",
                          ...) {
    ret <- fix_data_frame(data, newcol = ".rownames")
    augment_columns(x, data, newdata, type.predict = type.predict,
                               type.residuals = type.residuals)
}


#' @rdname coxph_tidiers
#' 
#' @return \code{glance} returns a one-row data.frame with statistics
#' calculated on the cox regression.
#' 
#' @export
glance.coxph <- function(x, ...) {
    s <- summary(x)
    
    # including all the test statistics and p-values as separate
    # columns. Admittedly not perfect but does capture most use cases.
    ret <- list(n = s$n,
                nevent = s$nevent,
                statistic.log = s$logtest[1],
                p.value.log = s$logtest[3],
                statistic.sc = s$sctest[1],
                p.value.sc = s$sctest[3],
                statistic.wald = s$waldtest[1],
                p.value.wald = s$waldtest[3],
                statistic.robust = s$robscore[1],
                p.value.robust = s$robscore[3],
                r.squared = s$rsq[1],
                r.squared.max = s$rsq[2],
                concordance = s$concordance[1],
                std.error.concordance = s$concordance[2])
    ret <- as.data.frame(compact(ret))
    finish_glance(ret, x)
}


#' tidy survival curve fits
#' 
#' Construct tidied data frames showing survival curves over time.
#' 
#' @param x "survfit" object
#' @param ... extra arguments, not used
#' 
#' @details \code{glance} does not work on multi-state survival curves,
#' since the values \code{glance} outputs would be calculated for each state.
#' \code{tidy} does work for multi-state survival objects, and includes a
#' \code{state} column to distinguish between them.
#' 
#' @template boilerplate
#' 
#' @examples
#' 
#' if (require("survival", quietly = TRUE)) {
#'     cfit <- coxph(Surv(time, status) ~ age + sex, lung)
#'     sfit <- survfit(cfit)
#'     
#'     head(tidy(sfit))
#'     glance(sfit)
#'     
#'     library(ggplot2)
#'     ggplot(tidy(sfit), aes(time, estimate)) + geom_line() +
#'         geom_ribbon(aes(ymin=conf.low, ymax=conf.high), alpha=.25)
#'     
#'     # multi-state
#'     fitCI <- survfit(Surv(stop, status * as.numeric(event), type = "mstate") ~ 1,
#'                   data = mgus1, subset = (start == 0))
#'     td_multi <- tidy(fitCI)
#'     head(td_multi)
#'     tail(td_multi)
#'     ggplot(td_multi, aes(time, estimate, group = state)) +
#'         geom_line(aes(color = state)) +
#'         geom_ribbon(aes(ymin = conf.low, ymax = conf.high), alpha = .25)
#'  
#'     # perform simple bootstrapping
#'     library(dplyr)
#'     bootstraps <- lung %>% bootstrap(100) %>%
#'         do(tidy(survfit(coxph(Surv(time, status) ~ age + sex, .))))
#'     
#'     ggplot(bootstraps, aes(time, estimate, group = replicate)) +
#'         geom_line(alpha = .25)
#'     
#'     bootstraps_bytime <- bootstraps %>% group_by(time) %>%
#'         summarize(median = median(estimate),
#'                   low = quantile(estimate, .025),
#'                   high = quantile(estimate, .975))
#'     
#'     ggplot(bootstraps_bytime, aes(x = time, y = median)) + geom_line() +
#'         geom_ribbon(aes(ymin = low, ymax = high), alpha = .25)
#'  
#'     # bootstrap for median survival
#'     glances <- lung %>%
#'         bootstrap(100) %>%
#'         do(glance(survfit(coxph(Surv(time, status) ~ age + sex, .))))
#'     
#'     glances
#'     
#'     qplot(glances$median, binwidth = 15)
#'     quantile(glances$median, c(.025, .975))
#' }
#' 
#' @name survfit_tidiers


#' @rdname survfit_tidiers
#' 
#' @return \code{tidy} returns a row for each time point, with columns
#'   \item{time}{timepoint}
#'   \item{n.risk}{number of subjects at risk at time t0}
#'   \item{n.event}{number of events at time t}
#'   \item{n.censor}{number of censored events}
#'   \item{estimate}{estimate of survival or cumulative incidence rate when multistate}
#'   \item{std.error}{standard error of estimate}
#'   \item{conf.high}{upper end of confidence interval}
#'   \item{conf.low}{lower end of confidence interval}
#'   \item{state}{state if multistate survfit object inputted}
#'   \item{strata}{strata if stratified survfit object inputted}
#' @export
tidy.survfit <- function(x, ...) {

    if (inherits(x, "survfitms")) {

        # c(x$???) when value is a matrix and needs to be stacked
        ret <- data.frame(
            time=x$time,
            n.risk=c(x$n.risk),
            n.event=c(x$n.event),
            n.censor = c(x$n.censor), 
            estimate = c(x$pstate),
            std.error = c(x$std.err),
            conf.high = c(x$upper),
            conf.low = c(x$lower),
            state = rep(x$states, each = nrow(x$pstate))
        )
        
        ret <- ret[ret$state != "",]
    } else {
        ret <- data.frame(
            time = x$time, 
            n.risk=x$n.risk,
            n.event=x$n.event,
            n.censor = x$n.censor, 
            estimate=x$surv,
            std.error=x$std.err,
            conf.high=x$upper,
            conf.low=x$lower)
    }
    # strata are automatically recycled if there are multiple states
    if (!is.null(x$strata)) {
        ret$strata <- rep(names(x$strata), x$strata)
    }
    ret
}

#' @rdname survfit_tidiers
#' 
#' @return \code{glance} returns one-row data.frame with the columns
#' displayed by \code{\link{print.survfit}}
#'   \item{records}{number of observations}
#'   \item{n.max}{n.max}
#'   \item{n.start}{n.start}
#'   \item{events}{number of events}
#'   \item{rmean}{Restricted mean (see \link[survival]{print.survfit})}
#'   \item{rmean.std.error}{Restricted mean standard error}
#'   \item{median}{median survival}
#'   \item{conf.low}{lower end of confidence interval on median}
#'   \item{conf.high}{upper end of confidence interval on median}
#' 
#' @export
glance.survfit <- function(x, ...) {
    if (inherits(x, "survfitms")) {
        stop("Cannot construct a glance of a multi-state survfit object")
    }
    if (!is.null(x$strata)) {
        stop("Cannot construct a glance of a multi-strata survfit object")
    }
    
    s <- summary(x)
    ret <- unrowname(as.data.frame(t(s$table)))
    
    colnames(ret) <- plyr::revalue(colnames(ret),
                                   c("*rmean" = "rmean",
                                     "*se(rmean)" = "rmean.std.error"),
                                   warn_missing = FALSE)
    
    colnames(ret)[utils::tail(seq_along(ret), 2)] <- c("conf.low", "conf.high")
    ret
}


#' Tidy an expected survival curve
#' 
#' This constructs a summary across time points or overall of an expected survival
#' curve. Note that this contains less information than most survfit objects.
#' 
#' @param x "survexp" object
#' @param ... extra arguments (not used)
#' 
#' @template boilerplate
#' 
#' @examples
#' 
#' if (require("survival", quietly = TRUE)) {
#'     sexpfit <- survexp(futime ~ 1, rmap=list(sex="male", year=accept.dt,
#'                                              age=(accept.dt-birth.dt)),
#'                        method='conditional', data=jasa)
#' 
#'     tidy(sexpfit)
#'     glance(sexpfit)
#' }
#' 
#' @name sexpfit_tidiers


#' @rdname sexpfit_tidiers
#' 
#' @return \code{tidy} returns a one row for each time point, with columns
#'   \item{time}{time point}
#'   \item{estimate}{estimated survival}
#'   \item{n.risk}{number of individuals at risk}
#' 
#' @export
tidy.survexp <- function(x, ...) {
    ret <- as.data.frame(summary(x)[c("time", "surv", "n.risk")])
    plyr::rename(ret, c(surv = "estimate"))
}


#' @rdname sexpfit_tidiers
#' 
#' @return \code{glance} returns a one-row data.frame with the columns:
#'   \item{n.max}{maximum number of subjects at risk}
#'   \item{n.start}{starting number of subjects at risk}
#'   \item{timepoints}{number of timepoints}
#'   
#' @export
glance.survexp <- function(x, ...) {
    data.frame(n.max = max(x$n.risk), n.start = x$n.risk[1],
               timepoints = length(x$n.risk))
}


#' Tidy person-year summaries
#' 
#' These tidy the output of \code{pyears}, a calculation of the person-years
#' of follow-up time contributed by a cohort of subject. Since the output of
#' \code{pyears$data} is already tidy (if the \code{data.frame = TRUE} argument
#' is given), this does only a little work and should rarely be necessary.
#' 
#' @param x a "pyears" object
#' @param ... extra arguments (not used)
#' 
#' @examples
#' 
#' if (require("survival", quietly = TRUE)) {
#'     temp.yr  <- tcut(mgus$dxyr, 55:92, labels=as.character(55:91)) 
#'     temp.age <- tcut(mgus$age, 34:101, labels=as.character(34:100))
#'     ptime <- ifelse(is.na(mgus$pctime), mgus$futime, mgus$pctime)
#'     pstat <- ifelse(is.na(mgus$pctime), 0, 1)
#'     pfit <- pyears(Surv(ptime/365.25, pstat) ~ temp.yr + temp.age + sex,  mgus,
#'                    data.frame=TRUE)
#'     head(tidy(pfit))
#'     glance(pfit)
#' 
#'     # if data.frame argument is not given, different information is present in
#'     # output
#'     pfit2 <- pyears(Surv(ptime/365.25, pstat) ~ temp.yr + temp.age + sex,  mgus) 
#'     head(tidy(pfit2))
#'     glance(pfit2)
#' }
#' 
#' @seealso \link{pyears}
#' 
#' @name pyears_tidiers


#' @rdname pyears_tidiers
#' 
#' @return \code{tidy} returns a data.frame with the columns
#'   \item{pyears}{person-years of exposure}
#'   \item{n}{number of subjects contributing time}
#'   \item{event}{observed number of events}
#'   \item{expected}{expected number of events (present only if a
#'   \code{ratetable} term is present)}
#' 
#' If the \code{data.frame = TRUE} argument is supplied to \code{pyears},
#' this is simply the contents of \code{x$data}.
#' 
#' @export
tidy.pyears <- function(x, ...) {
    if (is.null(x$data)) {
        ret <- compact(unclass(x)[c("pyears", "n", "event", "expected")])
        as.data.frame(ret)
    } else {
        x$data
    }
}


#' @rdname pyears_tidiers
#' 
#' @return \code{glance} returns a one-row data frame with
#'   \item{total}{total number of person-years tabulated}
#'   \item{offtable}{total number of person-years off table}
#' 
#' This contains the values printed by \code{summary.pyears}.
#' 
#' @export
glance.pyears <- function(x, ...) {
    if (is.null(x$data)) {
        data.frame(total = sum(x$pyears), offtable = x$offtable)
    } else {
        data.frame(total = sum(x$data$pyears), offtable = x$offtable)
    }
}


#' Tidiers for a parametric regression survival model
#' 
#' Tidies the coefficients of a parametric survival regression model,
#' from the "survreg" function, adds fitted values and residuals, or
#' summarizes the model statistics.
#' 
#' @param x a "survreg" model
#' @param conf.level confidence level for CI
#' @param ... extra arguments (not used)
#' 
#' @template boilerplate
#' 
#' @examples
#' 
#' if (require("survival", quietly = TRUE)) {
#'     sr <- survreg(Surv(futime, fustat) ~ ecog.ps + rx, ovarian,
#'            dist="exponential")
#' 
#'     td <- tidy(sr)
#'     augment(sr, ovarian)
#'     augment(sr)
#'     glance(td)
#' 
#'     # coefficient plot
#'     library(ggplot2)
#'     ggplot(td, aes(estimate, term)) + geom_point() +
#'         geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), height = 0) +
#'         geom_vline(xintercept = 0)
#' }
#' 
#' @name survreg_tidiers


#' @rdname survreg_tidiers
#' 
#' @template coefficients
#' 
#' @export
tidy.survreg <- function(x, conf.level = .95, ...) {
    s <- summary(x)
    nn <- c("estimate", "std.error", "statistic", "p.value")
    ret <- fix_data_frame(s$table, newnames = nn)
    ret
    
    # add confidence interval
    CI <- unrowname(stats::confint(x, level = conf.level))
    colnames(CI) <- c("conf.low", "conf.high")
    cbind(ret, CI)
}


#' @name survreg_tidiers
#' 
#' @param data original data; if it is not provided, it is reconstructed
#' as best as possible with \code{\link{model.frame}}
#' @param newdata New data to use for prediction; optional
#' @param type.predict type of prediction, default "response"
#' @param type.residuals type of residuals to calculate, default "response"
#' 
#' @template augment_NAs
#' 
#' @return \code{augment} returns the original data.frame with the following
#' additional columns:
#'   \item{.fitted}{Fitted values of model}
#'   \item{.se.fit}{Standard errors of fitted values}
#'   \item{.resid}{Residuals}
#' 
#' @export
augment.survreg <- function(x, data = stats::model.frame(x), newdata,
                            type.predict = "response",
                            type.residuals = "response", ...) {
    ret <- fix_data_frame(data, newcol = ".rownames")
    augment_columns(x, data, newdata, type.predict = type.predict,
                    type.residuals = type.residuals)
}


#' @rdname survreg_tidiers
#' 
#' @return \code{glance} returns a one-row data.frame with the columns:
#'   \item{iter}{number of iterations}
#'   \item{df}{degrees of freedom}
#'   \item{statistic}{chi-squared statistic}
#'   \item{p.value}{p-value from chi-squared test}
#'   \item{logLik}{log likelihood}
#'   \item{AIC}{Akaike information criterion}
#'   \item{BIC}{Bayesian information criterion}
#'   \item{df.residual}{residual degrees of freedom}
#' 
#' @export
glance.survreg <- function(x, conf.level = .95, ...) {
    ret <- data.frame(iter = x$iter, df = sum(x$df))

    ret$chi <- 2 * diff(x$loglik)
    ret$p.value <- 1 - stats::pchisq(ret$chi, sum(x$df) - x$idf)

    finish_glance(ret, x)
}
