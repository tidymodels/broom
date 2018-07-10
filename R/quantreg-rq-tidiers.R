#' @templateVar class rq
#' @template title_desc_tidy
#' 
#' @param x An `rq` object returned from [quantreg::rq()].
#' @param se.type Character specifying the method to use to calculate
#'   standard errors. Passed to [quantreg::summary.rq()] `se` argument.
#'   Defaults to `"rank"`.
#' @template param_confint
#' @param ... Additional arguments passed to [quantreg::summary.rq()].
#'
#' @details If `se.type = "rank"` confidence intervals are calculated by 
#'   `summary.rq`. When only a single predictor is included in the model, 
#'   no confidence intervals are calculated and the confidence limits are
#'   set to NA. 
#' 
#' @template return_tidy_regression
#'
#' @aliases rq_tidiers quantreg_tidiers
#' @export
#' @seealso [tidy()], [quantreg::rq()]
#' @family quantreg tidiers
tidy.rq <- function(x, se.type = "rank",
                    conf.int = TRUE, conf.level = 0.95, ...) {
  
  # specification for confidence level inverted for summary.rq
  alpha <- 1 - conf.level
  
  # summary.rq often issues warnings when computing standard error
  rq_summary <- suppressWarnings(
    quantreg::summary.rq(x, se = se.type, alpha = alpha, ...)
  )
  
  process_rq(
    rq_obj = rq_summary,
    se.type = se.type,
    conf.int = conf.int,
    conf.level = conf.level
  )
}

#' @templateVar class rq
#' @template title_desc_glance
#' 
#' @param x An `rq` object returned from [quantreg::rq()].
#' @template param_unused_dots
#'
#' @return A one-row [tibble::tibble] with columns:
#' 
#'  \item{tau}{quantile estimated}
#'  \item{logLik}{the data's log-likelihood under the model}
#'  \item{AIC}{the Akaike Information Criterion}
#'  \item{BIC}{the Bayesian Information Criterion}
#'  \item{df.residual}{residual degrees of freedom}
#' 
#' @details Only models with a single `tau` value may be passed.
#'  For multiple values, please use a [purrr::map()] workflow instead, e.g.
#'  ```
#'  taus %>%
#'    map(function(tau_val) rq(y ~ x, tau = tau_val)) %>%
#'    map_dfr(glance)
#'  ```
#'
#' @export
#' @seealso [glance()], [quantreg::rq()]
#' @family quantreg tidiers
glance.rq <- function(x, ...) {
  n <- length(fitted(x))
  s <- summary(x)
  
  tibble(
    tau = x[["tau"]],
    logLik = logLik(x),
    AIC = AIC(x),
    BIC = AIC(x, k = log(n)),
    df.residual = rep(s[["rdf"]], times = length(x[["tau"]]))
  )
}

#' @templateVar class rq
#' @template title_desc_augment
#'
#' @param x An `rq` object returned from [quantreg::rq()].
#' @template param_data
#' @template param_newdata
#' @inheritDotParams quantreg::predict.rq
#' 
#' @return A [tibble::tibble] with one row per obseration and columns:
#' 
#'   \item{.resid}{Residuals}
#'   \item{.fitted}{Fitted quantiles of the model}
#'   \item{.tau}{Quantile estimated}
#'
#'   Depending on the arguments passed on to `predict.rq` via `...`,
#'   a confidence interval is also calculated on the fitted values resulting in
#'   columns:
#'     \item{.conf.low}{Lower confidence interval value}
#'     \item{.conf.high}{Upper confidence interval value}
#'
#'   `predict.rq` does not provide confidence intervals when `newdata`
#'    is provided.
#'
#' @export
#' @seealso [augment], [quantreg::rq()], [quantreg::predict.rq()]
#' @family quantreg tidiers
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

process_rq <- function(rq_obj, se.type = "rank",
                       conf.int = TRUE,
                       conf.level = 0.95) {
  nn <- c("estimate", "std.error", "statistic", "p.value")
  co <- as.data.frame(rq_obj[["coefficients"]])
  if (se.type == "rank") {
    # if only a single predictor is included, confidence interval not calculated
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
  as_tibble(fix_data_frame(co, colnames(co)))
}
