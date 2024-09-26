# `stats::nobs` is a standard function to retrieve the number of
# observations used to fit a model. Unfortunately, Some packages do
# not define a `stats::nobs.MODEL` method. This file fills-in those missing
# methods. Ideally, we should offload these methods by submitting them for
# adoption in the upstream packages.

# These packages still need to be checked:

# caret
# joineRML
# ergm
# nlme
# rstanarm
# lavaan: conflict between stats::nobs and lavaan::nobs
# mass-ridgelm
# survival-*
# quantreg-rq
# quantreg-rqs

# nnet-multinom
#' @export
nobs.multinom <- function(object, ...) {
  nrow(object$residuals)
}

# orcutt
#' @export
nobs.orcutt <- function(object, ...) {
  nrow(object$residuals)
}

# mass-fitdistr
#' @export
nobs.fitdistr <- function(object, ...) {
  object$n
}

# biglm
#' @export
nobs.biglm <- function(object, ...) {
  object$n
}

# glmnet-cv-glmnet
#' @export
nobs.cv.glmnet <- function(object, ...) {
  stats::nobs(object$glmnet.fit)
}

# gmm
#' @export
nobs.gmm <- function(object, ...) {
  object$n
}

# lfe - felm
#' @export
nobs.felm <- function(object, ...) {
  object$N
}

# lmodel2
#' @export
nobs.lmodel2 <- function(object, ...) {
  object$n
}

# mclust
#' @export
nobs.Mclust <- function(object, ...) {
  object$n
}

# muhaz
#' @export
nobs.muhaz <- function(object, ...) {
  length(object$pin$times)
}

# polca
#' @export
nobs.poLCA <- function(object, ...) {
  object$N
}

# robust-glmrob
#' @export
nobs.lmRob <- function(object, ...) {
  length(object$residuals)
}
#' @export
nobs.glmRob <- function(object, ...) {
  length(object$residuals)
}

# stats-loess
#' @export
nobs.loess <- function(object, ...) {
  object$n
}

# stats-prcomp
#' @export
nobs.prcomp <- function(object, ...) {
  NROW(object$x)
}

# stats-smooth.spline
#' @export
nobs.smooth.spline <- function(object, ...) {
  length(object$x)
}

# bbmle
#' @export
nobs.bbmle <- function(object, ...) {
  length(object@data[[1]])
}

# survival-aareg
#' @export
nobs.aareg <- function(object, ...) {
  object$n[1] # obs / event times / event times in computation
}

# survival-survfit
#' @export
nobs.survfit <- function(object, ...) {
  object$n
}

# survival-survfit.cox
#' @export
nobs.survfit.cox <- function(object, ...) {
  object$n
}

# survival-pyears
#' @export
nobs.pyears <- function(object, ...) {
  object$observations
}

# survival-survdiff
#' @export
nobs.survdiff <- function(object, ...) {
  s <- summary(object)
  s$nobs
}

# tseries
#' @export
nobs.garch <- function(object, ...) {
  object$n.used
}
