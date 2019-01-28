# These packages were checked are are compatible with `stats::nobs`:

# aer
# plm
# betareg
# gam
# gamlss
# geefit
# glmnet
# lme4
# mass-polr
# mass-rlm
# mediate
# mgcv
# ordinal
# psych
# speedglm
# stats-arima
# stats-factanal
# stats-glm
# stats-lm
# stats-nls

# These packages still need to be checked:

# caret
# joineRML
# ergm
# nlme
# rstanarm
# lavaan: conflict between stats::nobs and lavaan::nobs
# mass-ridgelm
# survival-*

# These packages do not have exxamples in the broom docs

# quantreg-rq
# quantreg-rqs

# Custom `nobs` methods

# nnet-multinom
nobs.multinom <- function(object, ...) {
    nrow(object$residuals)
}

# orcutt
nobs.orcutt <- function(object, ...) {
    nrow(object$residuals)
}

# mass-fitdistr
nobs.fitdistr <- function(object, ...) {
    object$n
}

# biglm
nobs.biglm <- function(object, ...) {
    object$n
}

# glmnet-cv-glmnet
nobs.cv.glmnet <- function(object, ...) {
    stats::nobs(object$glmnet.fit)
}

# gmm
nobs.gmm <- function(object, ...) {
    object$n
}

#lfe - felm
nobs.felm <- function(object, ...) {
    object$N
}

#lmodel2
nobs.lmodel2 <- function(object, ...) {
    object$n
}

#mclust
nobs.Mclust <- function(object, ...) {
    object$n
}

#muhaz
nobs.muhaz <- function(object, ...) {
    length(object$pin$times)
}

#polca
nobs.poLCA <- function(object, ...) {
    object$N
}

#robust-glmrob
nobs.lmRob <- function(object, ...) {
    length(object$residuals)
}
nobs.glmRob <- function(object, ...) {
    length(object$residuals)
}

#stats-loess
nobs.loess <- function(object, ...) {
    object$n
}

#stats-prcomp
nobs.prcomp <- function(object, ...) {
    NROW(object$x)
}

#stats-smooth.spline
nobs.smooth.spline <- function(object, ...) {
    length(object$x)
}

#bbmle
nobs.bbmle <- function(object, ...) {
    length(object@data[[1]])
}

#survival-aareg
nobs.aareg <- function(object, ...) {
    object$n[1] # obs / event times / event times in computation
}

#survival-survreg
nobs.survreg <- function(object, ...) {
    length(object$linear.predictors)
}

#survival-survfit
nobs.survfit <- function(object, ...) {
    object$n
}

#survival-survfit.cox
nobs.survfit.cox <- function(object, ...) {
    object$n
}

#survival-coxph
nobs.coxph <- function(object, ...) {
    length(object$linear.predictors)
}

#survival-pyears
nobs.pyears <- function(object, ...) {
    object$observations
}

#survival-survdiff
nobs.survdiff <- function(object, ...) {
    s <- summary(object)
    s$nobs
}

#tseries
nobs.garch <- function(object, ...) {
    object$n.used
}
