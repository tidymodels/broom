#' @templateVar class rma
#' @template title_desc_tidy
#' 
#' @param x An `rma` created by the `metafor` package.
#' @inheritParams tidy.lm
#' @param include_studies Logical. Should individual studies be included in the
#'    output?
#' @param ... Additional arguments
#' @param measure Measure type. See [metafor::rma()]
#'
#' @return A `tibble`
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
tidy.rma <- function(x, conf.int = FALSE, conf.level = 0.95, exponentiate = FALSE,
                     include_studies = TRUE, measure = "GEN", ...) {
  
  estimates <- metafor::escalc(yi = x$yi.f, vi = x$vi.f, measure = measure) %>%
    summary(level = conf.level * 100) %>% 
    as.data.frame(stringsAsFactors = FALSE)
  
  n_studies <- length(x$slab)
  
  estimates <- dplyr::bind_cols(
    study = x$slab, 
    # dplyr::bind_cols is strict about recycling
    type = rep("study", n_studies), 
    estimates[, c("yi", "sei", "zi")], 
    p.value = rep(NA, n_studies),
    estimates[, c("ci.lb", "ci.ub")] 
  )
  
  names(estimates) <- c("study", "type", "estimate", "std.error", "statistic",
                        "p.value", "conf.low", "conf.high")
  estimates <- tibble::as_tibble(estimates)
  
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
  
  results <- tibble::tibble(study = study, type = "summary",
                            estimate = betas, std.error = x$se,
                            statistic = x$zval, p.value = x$pval,
                            conf.low = x$ci.lb, conf.high = x$ci.ub)
  .data <- if (include_studies) rbind(estimates, results) else results
  
  if (exponentiate) {
    .data$estimate <- exp(.data$estimate)
    .data$conf.low <- exp(.data$conf.low)
    .data$conf.high <- exp(.data$conf.high)
  }
  
  if (!conf.int) {
    .data <- .data[-which(names(.data) %in% c("conf.low", "conf.high"))]
  }
  
  attributes(.data$study) <- NULL
  
  .data
}

#' @templateVar class rma
#' @template title_desc_glance
#'
#' @param x An `rma` created by the `metafor` package.
#' @param ... Additional arguments
#'
#' @return a `tibble`
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
  fit_stats <- metafor::fitstats(x)
  fit_stats <- fit_stats %>%
    t() %>%
    as.data.frame()
  names(fit_stats) <-
    stringr::str_replace(names(fit_stats), "\\:", "")
  
  list(
    nobs = x$k,
    measure = x$measure,
    method = x$method,
    i.squared = x$I2,
    h.squared = x$H2,
    tau.squared = x$tau2,
    tau.squared.se = x$se.tau2,
    qe = x$QE,
    p.value.qe = x$QEp,
    qm = x$QM,
    p.value.qm = x$QMp,
    fit_stats
  ) %>%
    # get rid of null values
    purrr::discard(is.null) %>%
    # don't include multivariate model stats
    purrr::discard(~length(.x) >= 2) %>%
    # change to tibble with correct column and row names
    as.data.frame() %>%
    tibble::as_tibble()
}

#' @templateVar class rma
#' @template title_desc_augment
#'
#' @param x An `rma` created by the `metafor` package.
#' @param ... additional arguments
#'
#' @return a `tibble`
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
#' @rdname metafor_augmenters
augment.rma <- function(x, ...) {
  blup0 <- purrr::possibly(metafor::blup, NULL)
  residuals0 <- purrr::possibly(stats::residuals, NULL)
  influence0 <- purrr::possibly(stats::influence, NULL)
  
  y <- x$yi
  pred <- blup0(x)
  if (is.null(pred)) pred <- predict(x)
  pred <- as.data.frame(pred)
  
  # fix names
  names(pred)[1:4] <- c(".fitted", ".se.fit", ".conf.low", ".conf.high")
  credible_intervals <- names(pred) %in% c("cr.lb", "cr.ub")
  names(pred)[credible_intervals] <- c(".cred.low", ".cred.high")
  moderator <- names(pred) == "X"
  names(pred)[moderator] <- ".moderator"
  
  res <- residuals0(x)
  inf <- influence0(x)
  if (!is.null(inf)) {
    inf <- dplyr::bind_cols(as.data.frame(inf$inf), dfbetas = inf$dfbs$intrcpt)
    inf <- dplyr::select(
      inf, 
      .hat = hat, 
      .cooksd = cook.d, 
      .std.resid = rstudent,
      .dffits = dffits, 
      .cov.ratio = cov.r,
      .tau.squared.del = tau2.del, 
      .qe.del = QE.del,
      .weight = weight, 
      .dfbetas = dfbetas
    )
  }
  
  any_study_names <- all(x$slab == seq_along(x$slab))
  
  ret <- dplyr::bind_cols(
    .rownames = ifelse(any_study_names, x$slab, NULL),
    y = y,
    pred,
    .resid = res
  )
  
  tibble::as_tibble(ret)
}
