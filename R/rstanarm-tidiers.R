#' Tidying methods for an rstanarm model
#' 
#' `rstanarm` tidiers will soon be deprecated in `broom` and there is no
#' ongoing development of these functions at this time.
#'
#' These methods tidy the estimates from [rstanarm::stanreg-objects()]
#' (fitted model objects from the \pkg{rstanarm} package) into a summary.
#'
#'
#' @return All tidying methods return a `data.frame` without rownames.
#' The structure depends on the method chosen.
#'
#' @seealso [rstanarm::summary.stanreg()]
#'
#' @name rstanarm_tidiers
#'
#' @param x Fitted model object from the \pkg{rstanarm} package. See
#'   [rstanarm::stanreg-objects()].
#' @examples
#'
#' \dontrun{
#' fit <- stan_glmer(mpg ~ wt + (1|cyl) + (1+wt|gear), data = mtcars,
#'                   iter = 300, chains = 2)
#' # non-varying ("population") parameters
#' tidy(fit, intervals = TRUE, prob = 0.5)
#'
#' # hierarchical sd & correlation parameters
#' tidy(fit, parameters = "hierarchical")
#'
#' # group-specific deviations from "population" parameters
#' tidy(fit, parameters = "varying")
#'
#' # glance method
#' glance(fit)
#' glance(fit, looic = TRUE, cores = 1)
#' }
#'
NULL


#' @rdname rstanarm_tidiers
#' @param parameters One or more of `"non-varying"`, `"varying"`,
#'   `"hierarchical"`, `"auxiliary"` (can be abbreviated). See the
#'   Value section for details.
#' @param prob See [rstanarm::posterior_interval()].
#' @param intervals If `TRUE` columns for the lower and upper bounds of the
#'   `100*prob`\% posterior uncertainty intervals are included. See
#'   [rstanarm::posterior_interval()] for details.
#'
#' @return
#' When `parameters="non-varying"` (the default), `tidy.stanreg` returns
#' one row for each coefficient, with three columns:
#' \item{term}{The name of the corresponding term in the model.}
#' \item{estimate}{A point estimate of the coefficient (posterior median).}
#' \item{std.error}{A standard error for the point estimate based on
#' [stats::mad()]. See the *Uncertainty estimates* section in
#' [rstanarm::print.stanreg()] for more details.}
#'
#' For models with group-specific parameters (e.g., models fit with
#' [rstanarm::stan_glmer()]), setting `parameters="varying"`
#' selects the group-level parameters instead of the non-varying regression
#' coefficients. Additional columns are added indicating the `level` and
#' `group`. Specifying `parameters="hierarchical"` selects the
#' standard deviations and (for certain models) correlations of the group-level
#' parameters.
#'
#' Setting `parameters="auxiliary"` will select parameters other than those
#' included by the other options. The particular parameters depend on which
#' \pkg{rstanarm} modeling function was used to fit the model. For example, for
#' models fit using [rstanarm::stan_glm.nb()] the overdispersion
#' parameter is included if `parameters="aux"`, for
#' [rstanarm::stan_lm()] the auxiliary parameters include the residual
#' SD, R^2, and log(fit_ratio), etc.
#'
#' If `intervals=TRUE`, columns for the `lower` and `upper`
#' values of the posterior intervals computed with
#' [rstanarm::posterior_interval()] are also included.
#'
#' @export
tidy.stanreg <- function(x,
                         parameters = "non-varying",
                         intervals = FALSE,
                         prob = 0.9,
                         ...) {
  parameters <-
    match.arg(parameters,
      several.ok = TRUE,
      choices = c(
        "non-varying", "varying",
        "hierarchical", "auxiliary"
      )
    )
  if (any(parameters %in% c("varying", "hierarchical"))) {
    if (!inherits(x, "lmerMod")) {
      stop("Model does not have 'varying' or 'hierarchical' parameters.")
    }
  }

  nn <- c("estimate", "std.error")
  ret_list <- list()
  if ("non-varying" %in% parameters) {
    nv_pars <- names(rstanarm::fixef(x))
    ret <- cbind(
      rstanarm::fixef(x),
      rstanarm::se(x)[nv_pars]
    )

    if (inherits(x, "polr")) {
      # also include cutpoints
      cp <- x$zeta
      se_cp <- apply(as.matrix(x, pars = names(cp)), 2, stats::mad)
      ret <- rbind(ret, cbind(cp, se_cp))
      nv_pars <- c(nv_pars, names(cp))
    }

    if (intervals) {
      cifix <-
        rstanarm::posterior_interval(
          object = x,
          pars = nv_pars,
          prob = prob
        )
      ret <- data.frame(ret, cifix)
      nn <- c(nn, "lower", "upper")
    }
    ret_list$non_varying <- fix_data_frame(ret, newnames = nn)
  }
  if ("auxiliary" %in% parameters) {
    nn <- c("estimate", "std.error")
    parnames <- rownames(x$stan_summary)
    auxpars <- c(
      "sigma", "shape", "overdispersion", "R2", "log-fit_ratio",
      grep("mean_PPD", parnames, value = TRUE)
    )
    auxpars <- auxpars[which(auxpars %in% parnames)]
    ret <- summary(x, pars = auxpars)[, c("50%", "sd"), drop = FALSE]
    if (intervals) {
      ints <- rstanarm::posterior_interval(x, pars = auxpars, prob = prob)
      ret <- data.frame(ret, ints)
      nn <- c(nn, "lower", "upper")
    }
    ret_list$auxiliary <-
      fix_data_frame(ret, newnames = nn)
  }
  if ("hierarchical" %in% parameters) {
    ret <- as.data.frame(rstanarm::VarCorr(x))
    ret[] <- lapply(ret, function(x) if (is.factor(x)) {
        as.character(x)
      } else {
        x
      })
    rscale <- "sdcor" # FIXME
    ran_prefix <- c("sd", "cor") # FIXME
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
    ret_list$hierarchical <- fix_data_frame(ret[c("grp", rscale)],
      newnames = c("group", "estimate")
    )
  }

  if ("varying" %in% parameters) {
    nn <- c("estimate", "std.error")
    s <- summary(x, pars = "varying")
    ret <- cbind(s[, "50%"], rstanarm::se(x)[rownames(s)])

    if (intervals) {
      ciran <- rstanarm::posterior_interval(x,
        regex_pars = "^b\\[",
        prob = prob
      )
      ret <- data.frame(ret, ciran)
      nn <- c(nn, "lower", "upper")
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

  return(bind_rows(ret_list))
}


#' @rdname rstanarm_tidiers
#'
#' @param looic Should the LOO Information Criterion (and related info) be
#'   included? See [rstanarm::loo.stanreg()] for details. Note: for
#'   models fit to very large datasets this can be a slow computation.
#' @param ... For `glance`, if `looic=TRUE`, optional arguments to
#'   [rstanarm::loo.stanreg()].
#'
#' @return `glance` returns one row with the columns
#'   \item{algorithm}{The algorithm used to fit the model.}
#'   \item{pss}{The posterior sample size (except for models fit using
#'   optimization).}
#'   \item{nobs}{The number of observations used to fit the model.}
#'   \item{sigma}{The square root of the estimated residual variance, if
#'   applicable. If not applicable (e.g., for binomial GLMs), `sigma` will
#'   be given the value `1` in the returned object.}
#'
#'   If `looic=TRUE`, then the following additional columns are also
#'   included:
#'   \item{looic}{The LOO Information Criterion.}
#'   \item{elpd_loo}{The expected log predictive density (`elpd_loo = -2 *
#'   looic`).}
#'   \item{p_loo}{The effective number of parameters.}
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
    if (x$algorithm == "sampling") {
      pss <- sum(pss - x$stanfit@sim$warmup2)
    }
    ret <- data.frame(ret, pss = pss)
  }

  ret <- data.frame(ret, nobs = stats::nobs(x), sigma = sigma(x))
  if (looic) {
    if (x$algorithm == "sampling") {
      loo1 <- rstanarm::loo(x, ...)
      if (utils::packageVersion("rstanarm") <= "2.17.3") {
        ret <- data.frame(ret, loo1[c("looic", "elpd_loo", "p_loo")])
      } else {
        loo_ests <- t(loo1$estimates[c("looic", "elpd_loo", "p_loo"), "Estimate"])
        ret <- data.frame(ret, loo_ests)
      }
    } else {
      message("looic only available for models fit using MCMC")
    }
  }
  unrowname(ret)
}
