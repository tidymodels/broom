#' @templateVar class rqs
#' @template title_desc_tidy
#' 
#' @param x An `rqs` object returned from [quantreg::rq()].
#' @param se.type Character specifying the method to use to calculate
#'   standard errors. Passed to [quantreg::summary.rq()] `se` argument.
#'   Defaults to `"rank"`.
#' @template param_confint
#' @param ... Additional arguments passed to [quantreg::summary.rqs()]
#' 
#' @template return_tidy_regression
#' 
#' @return An additional `quantile` column indicating with quantile the 
#'   coefficient corresponds to.
#'   
#' @details If `se.type = "rank"` confidence intervals are calculated by 
#'   `summary.rq`. When only a single predictor is included in the model, 
#'   no confidence intervals are calculated and the confidence limits are
#'   set to NA. 
#'   
#' @aliases rqs_tidiers
#' @export
#' @seealso [tidy()], [quantreg::rq()]
#' @family quantreg tidiers
#' 
tidy.rqs <- function(x, se.type = "rank", conf.int = TRUE,
                     conf.level = 0.95, ...) {
  
  rq_summary <- suppressWarnings(
    quantreg::summary.rqs(x, se = se.type, alpha = 1 - conf.level, ...)
  )
  
  purrr::map_df(
    rq_summary,
    process_rq,
    se.type = se.type,
    conf.int = conf.int,
    conf.level = conf.level
  )
}

#' @export
glance.rqs <- function(x, ...) {
  stop("`glance` cannot handle objects of class 'rqs',",
       " i.e. models with more than one tau value. Please",
       " use a purrr `map`-based workflow with 'rq' models instead.",
       call. = FALSE
  )
}

#' @templateVar class rqs
#' @template title_desc_augment
#'
#' @param x An `rqs` object returned from [quantreg::rq()].
#' @template param_data
#' @template param_newdata
#' @inheritDotParams quantreg::predict.rqs
#' 
#' @return A [tibble::tibble] with one row per obseration and columns:
#' 
#'   \item{.resid}{Residuals}
#'   \item{.fitted}{Fitted quantiles of the model}
#'   \item{.tau}{Quantile estimated}
#'
#'   Depending on the arguments passed on to `predict.rqs` via `...`,
#'   a confidence interval is also calculated on the fitted values resulting in
#'   columns:
#'     \item{.conf.low}{Lower confidence interval value}
#'     \item{.conf.high}{Upper confidence interval value}
#'
#'   `predict.rqs` does not provide confidence intervals when `newdata`
#'    is provided.
#'
#' @export
#' @seealso [augment], [quantreg::rq()], [quantreg::predict.rqs()]
#' @family quantreg tidiers
augment.rqs <- function(x, data = model.frame(x), newdata, ...) {
  n_tau <- length(x[["tau"]])
  if (missing(newdata) || is.null(newdata)) {
    original <- data[rep(seq_len(nrow(data)), n_tau), ]
    pred <- predict(x, stepfun = FALSE, ...)
    resid <- residuals(x)
    resid <- setNames(as.data.frame(resid), x[["tau"]])
    resid <- tidyr::gather(data = resid, key = ".tau", value = ".resid")
    original <- cbind(original, resid)
    pred <- setNames(as.data.frame(pred), x[["tau"]])
    pred <- tidyr::gather(data = pred, key = ".tau", value = ".fitted")
    ret <- unrowname(cbind(original, pred[, -1, drop = FALSE]))
  } else {
    original <- newdata[rep(seq_len(nrow(newdata)), n_tau), ]
    pred <- predict(x, newdata = newdata, stepfun = FALSE, ...)
    pred <- setNames(as.data.frame(pred), x[["tau"]])
    pred <- tidyr::gather(data = pred, key = ".tau", value = ".fitted")
    ret <- unrowname(cbind(original, pred))
  }
  as_tibble(ret)
}

