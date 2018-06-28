#' @rdname rq_tidiers
#'
#' @return `tidy.rqs` returns a data frame with one row for each coefficient at
#' each quantile that was estimated. The columns depend upon the confidence interval
#' method selected.
#'
#' @export
tidy.rqs <- function(x, se.type = "rank", conf.int = TRUE, conf.level = 0.95, alpha = 1 - conf.level, ...) {
  # summary.rq often issues warnings when computing standard errors
  rq_summary <- suppressWarnings(quantreg::summary.rqs(x, se = se.type, alpha = alpha, ...))
  purrr::map_df(rq_summary, process_rq, se.type = se.type, conf.int = conf.int, conf.level = conf.level, ...)
}

#' @export
glance.rqs <- function(x, ...) {
  stop("`glance` cannot handle objects of class 'rqs',",
       " i.e. models with more than one tau value. Please",
       " use a purrr `map`-based workflow with 'rq' models instead.",
       call. = FALSE
  )
}

#' @rdname rq_tidiers
#'
#' @return `augment.rqs` returns a row for each original observation
#' and each estimated quantile (`tau`) with the following columns added:
#'  \item{.resid}{Residuals}
#'  \item{.fitted}{Fitted quantiles of the model}
#'  \item{.tau}{Quantile estimated}
#'
#'  `predict.rqs` does not return confidence interval estimates.
#'
#' @export
augment.rqs <- function(x, data = model.frame(x), newdata, ...) {
  n_tau <- length(x[["tau"]])
  if (missing(newdata) || is.null(newdata)) {
    original <- data[rep(seq_len(nrow(data)), n_tau), ]
    pred <- predict(x, stepfun = FALSE, ...)
    resid <- residuals(x)
    resid <- setNames(as.data.frame(resid), x[["tau"]])
    # resid <- reshape2::melt(resid,measure.vars = 1:ncol(resid),variable.name = ".tau",value.name = ".resid")
    resid <- tidyr::gather(data = resid, key = ".tau", value = ".resid")
    original <- cbind(original, resid)
    pred <- setNames(as.data.frame(pred), x[["tau"]])
    # pred <- reshape2::melt(pred,measure.vars = 1:ncol(pred),variable.name = ".tau",value.name = ".fitted")
    pred <- tidyr::gather(data = pred, key = ".tau", value = ".fitted")
    ret <- unrowname(cbind(original, pred[, -1, drop = FALSE]))
  } else {
    original <- newdata[rep(seq_len(nrow(newdata)), n_tau), ]
    pred <- predict(x, newdata = newdata, stepfun = FALSE, ...)
    pred <- setNames(as.data.frame(pred), x[["tau"]])
    # pred <- reshape2::melt(pred,measure.vars = 1:ncol(pred),variable.name = ".tau",value.name = ".fitted")
    pred <- tidyr::gather(data = pred, key = ".tau", value = ".fitted")
    ret <- unrowname(cbind(original, pred))
  }
  tibble::as_tibble(ret)
}

