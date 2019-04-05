#' Tidying methods for meta-analyis objects
#'
#' These methods tidy the results of meta-analysis objects
#'
#' @param x a meta-analysis object. Currently supports `rma.uni` from the
#'   `metafor` package.
#' @param conf.int logical. Include confidence intervals?
#' @param exponentiate logical. Should the estimates and (if `conf.int` =
#'   `TRUE`) confidence intervals be exponentiated?
#' @param include_studies logical. Should individual studies be included in the
#'    output?
#' @param ... additional arguments
#' @param measure measure type. See [metafor::rma()]
#'
#' @return a `data.frame`
#' @export
#'
#' @examples
#'
#' example_ma %>%
#'   tidy()
#'
#' @rdname tidiers
#' 
tidy.rma <- function(x, conf.int = TRUE, exponentiate = FALSE,
                     include_studies = TRUE, measure = "GEN", ...) {
  
  estimates <- metafor::escalc(yi = x$yi.f, vi = x$vi.f, measure = measure) %>%
    metafor2df()
  
  estimates <- cbind(x$slab, "study", estimates[, c("yi", "sei", "zi")], NA,
                     estimates[, c("ci.lb", "ci.ub")], stringsAsFactors = FALSE)
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
  
  tibble::remove_rownames(.data)
}

#' Construct a one-row summary of meta-analysis model fit statistics.
#'
#' `glance()` computes a one-row summary of  meta-analysis objects,
#'  including estimates of heterogenity and model fit.
#'
#' @param x a meta-analysis object. Currently supports `rma.uni` from the
#'   `metafor` package.
#' @param ... additional arguments
#'
#' @return a `data.frame`
#' @export
#'
#' @examples
#'
#' example_ma %>%
#'   glance()
#'
glance.rma <- function(x, ...) {
  fit_stats <- metafor::fitstats(x)
  fit_stats <- fit_stats %>%
    t() %>%
    as.data.frame()
  names(fit_stats) <-
    stringr::str_replace(names(fit_stats), "\\:", "")
  
  list(
    k = x$k,
    measure = x$measure,
    method = x$method,
    i.squared = x$I2,
    h.squared = x$H2,
    tau.squared = x$tau2,
    tau.squared.se = x$se.tau2,
    QE = x$QE,
    QE_p = x$QEp,
    QM = x$QM,
    QM_p = x$QMp,
    fit_stats
  ) %>%
    # get rid of null values
    purrr::discard(is.null) %>%
    # change to tibble with correct column and row names
    as.data.frame() %>%
    tibble::as_tibble() %>%
    tibble::remove_rownames()
}

#' Augment data with values from a meta-analysis model
#'
#' Augment the original data with model residuals, fitted values, and influence
#' statistics.
#'
#' @param x a meta-analysis object. Currently supports `rma.uni` from the
#'   `metafor` package.
#' @param ... additional arguments
#'
#' @return a `data.frame`
#' @export
#'
#' @examples
#'
#' example_ma %>%
#'   augment()
#'
#' @rdname augmenters
augment.rma <- function(x, ...) {
  blup0 <- purrr::possibly(metafor::blup, NULL)
  residuals0 <- purrr::possibly(stats::residuals, NULL)
  influence0 <- purrr::possibly(stats::influence, NULL)
  
  
  y <- x$yi
  pred <- blup0(x)
  if (is.null(pred)) pred <- predict(x)
  pred <- as.data.frame(pred)
  
  # fix names
  names(pred)[1:4] <- c(".fitted", ".se.fit", "conf.low.fit", "conf.high.fit")
  credible_intervals <- names(pred) %in% c("cr.lb", "cr.ub")
  names(pred)[credible_intervals] <- c("cred.low.fit", "cred.high.fit")
  moderator <- names(pred) == "X"
  names(pred)[moderator] <- "moderator"
  
  res <- residuals0(x)
  inf <- influence0(x)
  if (!is.null(inf)) {
    inf <- cbind(as.data.frame(inf$inf), dfbetas = inf$dfbs$intrcpt)
    inf <- dplyr::select(
      inf, .hat = hat, .cooksd = cook.d, .std.resid = rstudent,
      .dffits = dffits, .cov.ratio = cov.r,
      tau.squared.del = tau2.del, qe.del = QE.del,
      .weight = weight, .dfbetas = dfbetas)
  }
  
  ret <- cbind(
    .rownames = x$slab,
    y,
    pred,
    .resid = res
  )
  
  ret <- tibble::as_tibble(ret) %>%
    tibble::remove_rownames()
  
  if (all(ret$.rownames == seq_along(ret$.rownames))) {
    ret$.rownames <- NULL
  }
  
  ret
}
