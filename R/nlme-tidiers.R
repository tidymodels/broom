#' Tidying methods for mixed effects models
#' 
#' `nlme` tidiers will soon be deprecated in `broom` and there is no ongoing
#' development of these functions at this time. `nlme` tidiers are being
#' developed in the `broom.mixed` package, which is not yet on CRAN.
#'
#' These methods tidy the coefficients of mixed effects models
#' of the `lme` class from functions  of the `nlme` package.
#'
#' @param x An object of class `lme`, such as those from `lme`
#' or `nlme`
#'
#' @return All tidying methods return a `data.frame` without rownames.
#' The structure depends on the method chosen.
#'
#' @name nlme_tidiers
#'
#' @examples
#'
#' \dontrun{
#' if (require("nlme") & require("lme4")) {
#'     # example regressions are from lme4 documentation, but used for nlme
#'     lmm1 <- lme(Reaction ~ Days, random=~ Days|Subject, sleepstudy)
#'     tidy(lmm1)
#'     tidy(lmm1, effects = "fixed")
#'     head(augment(lmm1, sleepstudy))
#'     glance(lmm1)
#'
#'
#'     startvec <- c(Asym = 200, xmid = 725, scal = 350)
#'     nm1 <- nlme(circumference ~ SSlogis(age, Asym, xmid, scal),
#'                   data = Orange,
#'                   fixed = Asym + xmid + scal ~1,
#'                   random = Asym ~1,
#'                   start = startvec)
#'     tidy(nm1)
#'     tidy(nm1, effects = "fixed")
#'     head(augment(nm1, Orange))
#'     glance(nm1)
#' }
#' }
#'
#' @rdname nlme_tidiers
#'
#' @param effects Either "random" (default) or "fixed"
#'
#' @return `tidy` returns one row for each estimated effect, either
#' random or fixed depending on the `effects` parameter. If
#' `effects = "random"`, it contains the columns
#'   \item{group}{the group within which the random effect is being estimated}
#'   \item{level}{level within group}
#'   \item{term}{term being estimated}
#'   \item{estimate}{estimated coefficient}
#'
#' If `effects="fixed"`, `tidy` returns the columns
#'   \item{term}{fixed term being estimated}
#'   \item{estimate}{estimate of fixed effect}
#'   \item{std.error}{standard error}
#'   \item{statistic}{t-statistic}
#'   \item{p.value}{P-value computed from t-statistic}
#'
#' @export
tidy.lme <- function(x, effects = "random", ...) {
  effects <- match.arg(effects, c("random", "fixed"))
  if (effects == "fixed") {
    # return tidied fixed effects rather than random
    ret <- summary(x)$tTable

    # p-values are always there in nlme before Douglas banned them in lme4
    nn <- c("estimate", "std.error", "statistic", "p.value")
    # remove DF
    return(fix_data_frame(ret[, -3], newnames = nn, newcol = "term"))
  }

  # fix to be a tidy data frame
  fix <- function(g) {
    newg <- fix_data_frame(g, newnames = colnames(g), newcol = "level")
    # fix_data_frame doesn't create a new column if rownames are numeric,
    # which doesn't suit our purposes
    newg$level <- rownames(g)
    cbind(.id = attr(g, "grpNames"), newg)
  }

  # combine them and gather terms
  ret <- fix(stats::coef(x)) %>%
    tidyr::gather(term, estimate, -.id, -level)
  colnames(ret)[1] <- "group"
  ret
}


#' @rdname nlme_tidiers
#'
#' @param data original data this was fitted on; if not given this will
#' attempt to be reconstructed
#' @param newdata new data to be used for prediction; optional
#'
#' @template augment_NAs
#'
#' @return `augment` returns one row for each original observation,
#' with columns (each prepended by a .) added. Included are the columns
#'   \item{.fitted}{predicted values}
#'   \item{.resid}{residuals}
#'   \item{.fixed}{predicted values with no random effects}
#'
#'
#' @export
augment.lme <- function(x, data = x$data, newdata, ...) {
  if (is.null(data)) {
    stop("augment.lme must be called with an explicit 'data' argument for this (n)lme fit  because of an inconsistency in nlme.")
  }
  # move rownames if necessary
  if (missing(newdata)) {
    newdata <- NULL
  }
  ret <- augment_columns(x, data, newdata, se.fit = NULL)

  # add predictions with no random effects (population means)
  predictions <- stats::predict(x, level = 0)
  if (length(predictions) == nrow(ret)) {
    ret$.fixed <- predictions
  }

  unrowname(ret)
}


#' @rdname nlme_tidiers
#'
#' @param ... extra arguments (not used)
#'
#' @return `glance` returns one row with the columns
#'   \item{sigma}{the square root of the estimated residual variance}
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'   \item{deviance}{returned as NA. To quote Brian Ripley on R-help:
#'  McCullagh & Nelder (1989) would be the authoritative reference, but the 1982
#' first edition manages to use 'deviance' in three separate senses on one
#' page. }
#'
#' @export
glance.lme <- function(x, ...) {
  ret <- unrowname(data.frame(sigma = x$sigma))
  ret <- finish_glance(ret, x)
  ret$deviance <- NA
  #    ret$deviance = -2 * x$logLik # Or better leave this out totally?
  ret
}
