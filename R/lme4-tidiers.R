#' Tidying methods for mixed effects models
#' 
#' `lme4` tidiers will soon be deprecated in `broom` and there is no ongoing
#' development of these functions at this time. `lme4` tidiers are being
#' developed in the `broom.mixed` package, which is not yet on CRAN.
#'
#' These methods tidy the coefficients of mixed effects models, particularly
#' responses of the `merMod` class
#'
#' @param x An object of class `merMod`, such as those from `lmer`,
#' `glmer`, or `nlmer`
#'
#' @return All tidying methods return a `data.frame` without rownames.
#' The structure depends on the method chosen.
#'
#' @name lme4_tidiers
#'
#' @examples
#'
#' \dontrun{
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
#' }
NULL


#' @rdname lme4_tidiers
#'
#' @param effects A character vector including one or more of "fixed" (fixed-effect parameters), "ran_pars" (variances and covariances or standard deviations and correlations of random effect terms) or "ran_modes" (conditional modes/BLUPs/latent variable estimates)
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level for CI
#' @param conf.method method for computing confidence intervals (see `lme4::confint.merMod`)
#' @param scales scales on which to report the variables: for random effects, the choices are \sQuote{"sdcor"} (standard deviations and correlations: the default if `scales` is `NULL`) or \sQuote{"vcov"} (variances and covariances). `NA` means no transformation, appropriate e.g. for fixed effects; inverse-link transformations (exponentiation
#' or logistic) are not yet implemented, but may be in the future.
#' @param ran_prefix a length-2 character vector specifying the strings to use as prefixes for self- (variance/standard deviation) and cross- (covariance/correlation) random effects terms
#'
#' @return `tidy` returns one row for each estimated effect, either
#' with groups depending on the `effects` parameter.
#' It contains the columns
#'   \item{group}{the group within which the random effect is being estimated: `"fixed"` for fixed effects}
#'   \item{level}{level within group (`NA` except for modes)}
#'   \item{term}{term being estimated}
#'   \item{estimate}{estimated coefficient}
#'   \item{std.error}{standard error}
#'   \item{statistic}{t- or Z-statistic (`NA` for modes)}
#'   \item{p.value}{P-value computed from t-statistic (may be missing/NA)}
#'
#' @importFrom tidyr gather spread
#' @importFrom nlme VarCorr ranef
## FIXME: is it OK/sensible to import these from (priority='recommended')
## nlme rather than (priority=NA) lme4?
#'
#' @export
tidy.merMod <- function(x, effects = c("ran_pars", "fixed"),
                        scales = NULL, ## c("sdcor",NA),
                        ran_prefix=NULL,
                        conf.int = FALSE,
                        conf.level = 0.95,
                        conf.method = "Wald",
                        ...) {
  effect_names <- c("ran_pars", "fixed", "ran_modes")
  if (!is.null(scales)) {
    if (length(scales) != length(effects)) {
      stop(
        "if scales are specified, values (or NA) must be provided ",
        "for each effect"
      )
    }
  }
  if (length(miss <- setdiff(effects, effect_names)) > 0) {
    stop("unknown effect type ", miss)
  }
  base_nn <- c("estimate", "std.error", "statistic", "p.value")
  ret_list <- list()
  if ("fixed" %in% effects) {
    # return tidied fixed effects rather than random
    ret <- stats::coef(summary(x))

    # p-values may or may not be included
    nn <- base_nn[1:ncol(ret)]

    if (conf.int) {
      cifix <- confint(x, parm = "beta_", method = conf.method, ...)
      ret <- data.frame(ret, cifix)
      nn <- c(nn, "conf.low", "conf.high")
    }
    if ("ran_pars" %in% effects || "ran_modes" %in% effects) {
      ret <- data.frame(ret, group = "fixed")
      nn <- c(nn, "group")
    }
    ret_list$fixed <-
      fix_data_frame(ret, newnames = nn)
  }
  if ("ran_pars" %in% effects) {
    if (is.null(scales)) {
      rscale <- "sdcor"
    } else {
      rscale <- scales[effects == "ran_pars"]
    }
    if (!rscale %in% c("sdcor", "vcov")) {
      stop(sprintf("unrecognized ran_pars scale %s", sQuote(rscale)))
    }
    ret <- as.data.frame(VarCorr(x))
    ret[] <- lapply(ret, function(x) if (is.factor(x)) {
        as.character(x)
      } else {
        x
      })
    if (is.null(ran_prefix)) {
      ran_prefix <- switch(rscale,
        vcov = c("var", "cov"),
        sdcor = c("sd", "cor")
      )
    }
    pfun <- function(x) {
      v <- na.omit(unlist(x))
      if (length(v) == 0) v <- "Observation"
      p <- paste(v, collapse = ".")
      if (!identical(ran_prefix, NA)) {
        p <- paste(ran_prefix[length(v)], p, sep = "_")
      }
      return(p)
    }

    rownames(ret) <- paste(apply(ret[c("var1", "var2")], 1, pfun),
      ret[, "grp"],
      sep = "."
    )

    ## FIXME: this is ugly, but maybe necessary?
    ## set 'term' column explicitly, disable fix_data_frame
    ##  rownames -> term conversion
    ## rownames(ret) <- seq(nrow(ret))

    if (conf.int) {
      ciran <- confint(x, parm = "theta_", method = conf.method, ...)
      ret <- data.frame(ret, ciran)
      nn <- c(nn, "conf.low", "conf.high")
    }


    ## replicate lme4:::tnames, more or less
    ret_list$ran_pars <- fix_data_frame(ret[c("grp", rscale)],
      newnames = c("group", "estimate")
    )
  }
  if ("ran_modes" %in% effects) {
    ## fix each group to be a tidy data frame

    nn <- c("estimate", "std.error")
    re <- ranef(x, condVar = TRUE)
    getSE <- function(x) {
      v <- attr(x, "postVar")
      setNames(
        as.data.frame(sqrt(t(apply(v, 3, diag)))),
        colnames(x)
      )
    }
    fix <- function(g, re, .id) {
      newg <- fix_data_frame(g, newnames = colnames(g), newcol = "level")
      # fix_data_frame doesn't create a new column if rownames are numeric,
      # which doesn't suit our purposes
      newg$level <- rownames(g)
      newg$type <- "estimate"

      newg.se <- getSE(re)
      newg.se$level <- rownames(re)
      newg.se$type <- "std.error"

      data.frame(rbind(newg, newg.se),
        .id = .id,
        check.names = FALSE
      )
      ## prevent coercion of variable names
    }

    mm <- do.call(rbind, Map(fix, coef(x), re, names(re)))

    ## block false-positive warnings due to NSE
    type <- spread <- est <- NULL
    mm %>%
      gather(term, estimate, -.id, -level, -type) %>%
      spread(type, estimate) -> ret

    ## FIXME: doesn't include uncertainty of population-level estimate

    if (conf.int) {
      if (conf.method != "Wald") {
        stop("only Wald CIs available for conditional modes")
      }

      mult <- qnorm((1 + conf.level) / 2)
      ret <- transform(ret,
        conf.low = estimate - mult * std.error,
        conf.high = estimate + mult * std.error
      )
    }

    ret <- dplyr::rename(ret, group = .id)
    ret_list$ran_modes <- ret
  }
  bind_rows(ret_list)
}



#' @rdname lme4_tidiers
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
#' Also added for "merMod" objects, but not for "mer" objects,
#' are values from the response object within the model (of type
#' `lmResp`, `glmResp`, `nlsResp`, etc). These include `".mu",
#' ".offset", ".sqrtXwt", ".sqrtrwt", ".eta"`.
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
  cols <- as.data.frame(compact(cols)) # remove missing fields

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
#' @return `glance` returns one row with the columns
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
