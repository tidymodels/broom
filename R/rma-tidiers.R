#' @templateVar class rma
#' @template title_desc_tidy
#' 
#' @param x An `rma` object such as those created by [metafor::rma()],
#'   [metafor::rma.uni()], [metafor::rma.glmm()], [metafor::rma.mh()],
#'   [metafor::rma.mv()], or [metafor::rma.peto()].
#' @template param_confint
#' @template param_exponentiate
#' @param include_studies Logical. Should individual studies be included in the
#'    output? Defaults to `FALSE`.
#' @template param_unused_dots
#' @param measure Measure type. See [metafor::escalc()]
#'
#' @evalRd return_tidy(
#'   term = "The name of the individual study",
#'   type = "The estimate type  (summary vs individual study)",
#'   "estimate",
#'   "std.error",
#'   "statistic",
#'   "p.value",
#'   "conf.low",
#'   "conf.high"
#' )
#' @export
#'
#' @examples
#' 
#' library(metafor)
#' 
#' df <-
#'   escalc(
#'     measure = "RR",
#'     ai = tpos,
#'     bi = tneg,
#'     ci = cpos,
#'     di = cneg,
#'     data = dat.bcg
#'   )
#' 
#' meta_analysis <- rma(yi, vi, data = df, method = "EB")
#'
#' tidy(meta_analysis)
#'
#' @rdname metafor_tidiers
#' 
tidy.rma <- function(x, conf.int = FALSE, conf.level = 0.95,
                     exponentiate = FALSE, include_studies = FALSE,
                     measure = "GEN", ...) {
  # tidy summary estimates
  betas <- x$beta
  if (!is.null(nrow(betas)) && nrow(betas) > 1) {
    # get estimate type and fix spelling
    study <- rownames(betas)
    swap <- grepl("intrcpt", study)
    study[swap] <- "intercept"
    betas <- as.double(betas)
  } else {
    study <- "overall"
    betas <- betas[1]
  }
  
  results <- tibble::tibble(
    term = study, 
    type = "summary",
    estimate = betas, 
    std.error = x$se,
    statistic = x$zval, 
    p.value = x$pval,
    conf.low = x$ci.lb, 
    conf.high = x$ci.ub
  )
  
  # tidy individual studies
  if (include_studies) {
    # use `metafor::escalc` to standardize estimates and confidence intervals
    estimates <- metafor::escalc(yi = x$yi.f, vi = x$vi.f, measure = measure) %>%
      summary(level = conf.level * 100) %>% 
      as.data.frame(stringsAsFactors = FALSE)
    
    n_studies <- length(x$slab)
    
    estimates <- dplyr::bind_cols(
      term = as.character(x$slab), 
      # dplyr::bind_cols is strict about recycling, so repeat for each study
      type = rep("study", n_studies), 
      estimates[, c("yi", "sei", "zi")], 
      p.value = rep(NA, n_studies),
      estimates[, c("ci.lb", "ci.ub")] 
    )
    
    names(estimates) <- c("term", "type", "estimate", "std.error", "statistic",
                          "p.value", "conf.low", "conf.high")
    estimates <- as_tibble(estimates)
    results <- dplyr::bind_rows(estimates, results) 
  }
  
  if (exponentiate) {
    results <-  dplyr::mutate_at(results, dplyr::vars(estimate, conf.low, conf.high), exp)
  }
  
  if (!conf.int) {
    results <- dplyr::select(results, -conf.low, -conf.high)
  }
  
  results
}

#' @templateVar class rma
#' @template title_desc_glance
#'
#' @inheritParams tidy.rma
#'
#' @evalRd return_glance(
#'   "nobs", 
#'   "measure", 
#'   "method", 
#'   "i.squared", 
#'   "h.squared", 
#'   "tau.squared", 
#'   "tau.squared.se", 
#'   "cochran.qe", 
#'   "p.value.cochran.qe", 
#'   "cochran.qm", 
#'   "p.value.cochran.qm",
#'   "df.residual"
#' )
#' @export
#'
#' @examples
#'
#' library(metafor)
#' 
#' df <-
#'   escalc(
#'     measure = "RR",
#'     ai = tpos,
#'     bi = tneg,
#'     ci = cpos,
#'     di = cneg,
#'     data = dat.bcg
#'   )
#' 
#' meta_analysis <- rma(yi, vi, data = df, method = "EB")
#'
#' glance(meta_analysis)
#'
glance.rma <- function(x, ...) {
  # reshape model fit statistics and clean names
  fit_stats <- metafor::fitstats(x)
  fit_stats <- fit_stats %>%
    t() %>%
    as.data.frame()
  names(fit_stats) <-
    stringr::str_replace(names(fit_stats), "\\:", "")
  
  # metafor returns different fit statistics for different models
  # so use a list + `purrr::discard` to remove unrelated / missing statistics
  
  results <- list(
    i.squared = x$I2,
    h.squared = x$H2,
    tau.squared = x$tau2,
    tau.squared.se = x$se.tau2,
    cochran.qe = x$QE,
    p.value.cochran.qe = x$QEp,
    cochran.qm = x$QM,
    p.value.cochran.qm = x$QMp,
    df.residual = df.residual(x)
  ) %>%
    purrr::discard(is.null) %>%
    purrr::discard(purrr::is_empty) %>%
    # drop multivariate statistics
    purrr::discard(~length(.x) >= 2) %>%
    as_tibble()
  
  if (!purrr::is_empty(fit_stats) && nrow(fit_stats) == 1) {
    results <- dplyr::bind_cols(results, fit_stats)
  }
  
  results$nobs <- x$k
  
  results
}

#' @templateVar class rma
#' @template title_desc_augment
#'
#' @inheritParams tidy.rma
#'
#' @evalRd return_augment(
#'   .observed = "The observed values for the individual studies", 
#'   ".fitted", 
#'   ".se.fit", 
#'   ".conf.low", 
#'   ".conf.high", 
#'   ".cred.low", 
#'   ".cred.high", 
#'   ".resid",
#'   ".moderator",
#'   ".moderator.level"
#' )
#' 
#' @export
#'
#' @examples
#'
#' library(metafor)
#' 
#' df <-
#'   escalc(
#'     measure = "RR",
#'     ai = tpos,
#'     bi = tneg,
#'     ci = cpos,
#'     di = cneg,
#'     data = dat.bcg
#'   )
#' 
#' meta_analysis <- rma(yi, vi, data = df, method = "EB")
#'
#' augment(meta_analysis)
#'
augment.rma <- function(x, ...) {
  # metafor generally handles these for different models through the monolith
  # `rma` class; using `purrr::possibly` primarily helps discard unused
  # components but also helps get the right component for each model
  blup0 <- purrr::possibly(metafor::blup, NULL)
  residuals0 <- purrr::possibly(stats::residuals, NULL)
  influence0 <- purrr::possibly(stats::influence, NULL)
  
  y <- x$yi.f
  # get best linear unbiased predictors if available
  pred <- blup0(x)
  # otherwise use `predict.rma()`
  if (is.null(pred)) pred <- predict(x)
  pred <- as.data.frame(pred)
  
  # fix names
  names(pred)[1:4] <- c(".fitted", ".se.fit", ".conf.low", ".conf.high")
  credible_intervals <- names(pred) %in% c("cr.lb", "cr.ub")
  names(pred)[credible_intervals] <- c(".cred.low", ".cred.high")
  moderator <- names(pred) == "X"
  names(pred)[moderator] <- ".moderator"
  moderator_level <- names(pred) == "tau2.level"
  names(pred)[moderator_level] <- ".moderator.level"
  
  res <- residuals0(x)
  inf <- influence0(x)
  # if model has influence statistics, bind them and clean their names
  if (!is.null(inf)) {
    inf <- dplyr::bind_cols(as.data.frame(inf$inf), dfbetas = inf$dfbs$intrcpt)
    inf <- dplyr::select(
      inf, 
      .hat = hat, 
      .cooksd = cook.d, 
      .std.resid = rstudent,
      .dffits = dffits, 
      .cov.ratio = cov.r,
      .tau.squared.loo = tau2.del, 
      .cochran.qe.loo = QE.del,
      .weight = weight, 
      .dfbetas = dfbetas
    )
  }
  
  if (nrow(pred) == 1) {
    # Some metafor models only return a single prediction
    # based on the summary estimate. `dplyr::bind_cols()` requires
    # `pred` to be the same length as other results, so replicate
    # prediction for each row
    pred <- purrr::map_dfr(seq_along(x$slab), ~pred)
  }
  
  ret <- dplyr::bind_cols(
    .rownames = as.character(x$slab),
    .observed = y,
    pred
  )
  
  
  # join residuals, if they exist for the model
  if (!is.null(res)) {
    res <- tibble::enframe(res, name = ".rownames", value = ".resid")
    ret <- dplyr::left_join(ret, res, by = ".rownames")
  }
  
  # don't return rownames if they are just row numbers
  no_study_names <- all(x$slab == as.character(seq_along(x$slab)))
  if (no_study_names) ret$.rownames <- NULL
  
  tibble::as_tibble(ret)
}
