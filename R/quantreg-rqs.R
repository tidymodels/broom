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
#' @evalRd return_tidy(regression = TRUE,
#'   quantile = "Linear conditional quantile.")
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
#' @inherit tidy.rq examples
#'
tidy.rqs <- function(
  x,
  se.type = "rank",
  conf.int = FALSE,
  conf.level = 0.95,
  ...
) {
  check_ellipses("exponentiate", "tidy", "rqs", ...)

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
  cli::cli_abort(
    c(
      "{.fn glance} cannot handle objects of class {.cls rqs},
       i.e. models with more than one tau value.",
      "i" = "Please use a {.pkg purrr} {.fn map}-based workflow with
             {.cls rq} models instead."
    )
  )
}

#' @templateVar class rqs
#' @template title_desc_augment
#'
#' @inherit tidy.rqs examples
#' @inherit augment.rq return details
#'
#' @param x An `rqs` object returned from [quantreg::rq()].
#' @template param_data
#' @template param_newdata
#' @inheritDotParams quantreg::predict.rq
#'
#' @export
#' @seealso [augment], [quantreg::rq()], [quantreg::predict.rqs()]
#' @family quantreg tidiers
#' @inherit tidy.rq examples
augment.rqs <- function(x, data = model.frame(x), newdata, ...) {
  n_tau <- length(x[["tau"]])
  if (missing(newdata) || is.null(newdata)) {
    original <- data[rep(seq_len(nrow(data)), each = n_tau), , drop = FALSE]
    pred <- predict(x, stepfun = FALSE, ...)
    resid <- residuals(x)
    resid <- setNames(as.data.frame(resid), x[["tau"]])
    resid <- pivot_longer(
      resid,
      cols = dplyr::everything(),
      names_to = ".tau",
      values_to = ".resid"
    ) |>
      as.data.frame()
    original <- cbind(original, resid)
    pred <- setNames(as.data.frame(pred), x[["tau"]])
    pred <- pivot_longer(
      pred,
      cols = dplyr::everything(),
      names_to = ".tau",
      values_to = ".fitted"
    ) |>
      as.data.frame()
    ret <- unrowname(cbind(original, pred[, -1, drop = FALSE]))
  } else {
    original <- newdata[
      rep(seq_len(nrow(newdata)), each = n_tau),
      ,
      drop = FALSE
    ]
    pred <- predict(x, newdata = newdata, stepfun = FALSE, ...)
    pred <- setNames(as.data.frame(pred), x[["tau"]])
    pred <- pivot_longer(
      pred,
      cols = dplyr::everything(),
      names_to = ".tau",
      values_to = ".fitted"
    ) |>
      as.data.frame()
    ret <- unrowname(cbind(original, pred))
  }
  as_tibble(ret)
}
