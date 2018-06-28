#' Tidying methods for quantile regression models
#'
#' These methods tidy the coefficients of a quantile regression
#' model into a summary, augment the original data with information
#' on the fitted values and residuals, and construct a glance of
#' the model's statistics.
#'
#' @template boilerplate
#'
#' @name rq_tidiers
#'
#' @param x model object returned by `rq` or `nlrq`
#' @param data Original data, defaults to extracting it from the model
#'
NULL

#' @rdname rq_tidiers
#'
#' @param se.type Type of standard errors to calculate; see `summary.rq`
#' @param conf.int boolean; should confidence intervals be calculated, ignored
#' if `se.type = "rank"`
#' @param conf.level confidence level for intervals
#' @param alpha confidence level when `se.type = "rank"`; defaults to the same
#' as `conf.level` although the specification is inverted
#' @param \dots other arguments passed on to `summary.rq`
#'
#' @details If `se.type = "rank"` confidence intervals are calculated by 
#' `summary.rq`. When only a single predictor is included in the model, 
#' no confidence intervals are calculated and the confidence limits are set to NA. 
#' If `se.type != 'rank'` and `conf.int = TRUE`, confidence intervals 
#' are standard t based intervals.
#'
#' @return `tidy.rq` returns a tibble with one row for each coefficient.
#' The columns depend upon the confidence interval method selected.
#'
#' @export
tidy.rq <- function(x, se.type = "rank", conf.int = TRUE, conf.level = 0.95, alpha = 1 - conf.level, ...) {
  # summary.rq often issues warnings when computing standard errors
  rq_summary <- suppressWarnings(quantreg::summary.rq(x, se = se.type, alpha = alpha, ...))
  process_rq(rq_obj = rq_summary, se.type = se.type, conf.int = conf.int, conf.level = conf.level, ...)
}

#' @rdname rq_tidiers
#'
#' @details Only models with a single `tau` value may be passed.
#'  For multiple values, please use a [purrr::map()] workflow instead, e.g.
#'  ```
#'  taus %>%
#'    map(function(tau_val) rq(y ~ x, tau = tau_val)) %>%
#'    map_dfr(glance)
#'  ```
#'
#' @return `glance.rq` returns one row for each quantile (tau)
#' with the columns:
#'  \item{tau}{quantile estimated}
#'  \item{logLik}{the data's log-likelihood under the model}
#'  \item{AIC}{the Akaike Information Criterion}
#'  \item{BIC}{the Bayesian Information Criterion}
#'  \item{df.residual}{residual degrees of freedom}
#' @export
glance.rq <- function(x, ...) {
  n <- length(fitted(x))
  s <- summary(x)
  
  tibble::tibble(
    tau = x[["tau"]],
    logLik = logLik(x),
    AIC = AIC(x),
    BIC = AIC(x, k = log(n)),
    df.residual = rep(s[["rdf"]], times = length(x[["tau"]]))
  )
}

#' @rdname rq_tidiers
#'
#' @param newdata If provided, new data frame to use for predictions
#'
#' @return `augment.rq` returns a row for each original observation
#' with the following columns added:
#'  \item{.resid}{Residuals}
#'  \item{.fitted}{Fitted quantiles of the model}
#'  \item{.tau}{Quantile estimated}
#'
#'  Depending on the arguments passed on to `predict.rq` via `\dots`
#'  a confidence interval is also calculated on the fitted values resulting in
#'  columns:
#'      \item{.conf.low}{Lower confidence interval value}
#'      \item{.conf.high}{Upper confidence interval value}
#'
#'  See `predict.rq` for details on additional arguments to specify
#'  confidence intervals. `predict.rq` does not provide confidence intervals
#'  when `newdata` is provided.
#'
#' @export
augment.rq <- function(x, data = model.frame(x), newdata = NULL, ...) {
  args <- list(...)
  force_newdata <- FALSE
  if ("interval" %in% names(args) && args[["interval"]] != "none") {
    force_newdata <- TRUE
  }
  if (is.null(newdata)) {
    original <- data
    original[[".resid"]] <- residuals(x)
    if (force_newdata) {
      pred <- predict(x, newdata = data, ...)
    } else {
      pred <- predict(x, ...)
    }
  } else {
    original <- newdata
    pred <- predict(x, newdata = newdata, ...)
  }
  
  if (NCOL(pred) == 1) {
    original[[".fitted"]] <- pred
    original[[".tau"]] <- x[["tau"]]
    return(as_tibble(original))
  } else {
    colnames(pred) <- c(".fitted", ".conf.low", ".conf.high")
    original[[".tau"]] <- x[["tau"]]
    return(as_tibble(cbind(original, pred)))
  }
}

#' Helper function for tidy.rq and tidy.rqs
#'
#' See documentation for `summary.rq` for complete description
#' of the options for `se.type`, `conf.int`, etc.
#'
#' @param rq_obj an object returned by `summary.rq` or `summary.rqs`
#' @param se.type type of standard errors used in `summary.rq` or `summary.rqs`
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level for confidence interval
#' @param \dots currently unused
process_rq <- function(rq_obj, se.type = "rank",
                       conf.int = TRUE,
                       conf.level = 0.95, ...) {
  nn <- c("estimate", "std.error", "statistic", "p.value")
  co <- as.data.frame(rq_obj[["coefficients"]])
  if (se.type == "rank") {
    # if only a single predictor is included, confidence interval is not calculated
    # set to NA to preserve dimensions of object
    if (1 == ncol(co)) {
      co <- cbind(co, NA, NA)
    } 
    co <- setNames(co, c("estimate", "conf.low", "conf.high"))
    conf.int <- FALSE
  } else {
    co <- setNames(co, nn)
  }
  if (conf.int) {
    a <- (1 - conf.level) / 2
    cv <- qt(c(a, 1 - a), df = rq_obj[["rdf"]])
    co[["conf.low"]] <- co[["estimate"]] + (cv[1] * co[["std.error"]])
    co[["conf.high"]] <- co[["estimate"]] + (cv[2] * co[["std.error"]])
  }
  co[["tau"]] <- rq_obj[["tau"]]
  tibble::as_tibble(fix_data_frame(co, colnames(co)))
}
