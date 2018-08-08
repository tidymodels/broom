#' @templateVar class rq
#' @template title_desc_tidy
#' 
#' @param x An `rq` object returned from [quantreg::rq()].
#' @param se.type Character specifying the method to use to calculate
#'   standard errors. Passed to [quantreg::summary.rq()] `se` argument.
#'   Defaults to `"rank"` if the sample size is less than 1000,
#'   otherwise defaults to `"nid"`.
#' @template param_confint
#' @param ... Additional arguments passed to [quantreg::summary.rq()].
#'
#' @details If `se.type = "rank"` confidence intervals are calculated by 
#'   `summary.rq` and `statistic` and `p.value` values are not returned. When only a single predictor is included in the model, 
#'   no confidence intervals are calculated and the confidence limits are
#'   set to NA. 
#' 
#' @evalRd return_tidy(regression = TRUE)
#'
#' @aliases rq_tidiers quantreg_tidiers
#' @export
#' @seealso [tidy()], [quantreg::rq()]
#' @family quantreg tidiers
tidy.rq <- function(x, se.type = NULL, conf.int = FALSE,
                    conf.level = 0.95, ...) {
  
  # specification for confidence level inverted for summary.rq
  alpha <- 1 - conf.level
  
  #se.type default contingent on sample size
  n <- length(x$residuals)
  if (is.null(se.type))
    se.type <- if (n < 1001) "rank" else "nid"
  
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
#' @inherit tidy.rq examples params
#' @template param_unused_dots
#'
#' @evalRd return_glance(
#'   "tau",
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "df.residuals"
#' )
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
#' @inherit tidy.rq examples
#' 
#' @evalRd return_augment(".tau")
#'
#' @details Depending on the arguments passed on to `predict.rq` via `...`,
#'   a confidence interval is also calculated on the fitted values resulting in
#'   columns `.conf.low` and `.conf.high`. Does not provide confidence
#'   intervals when data is specified via the `newdata` argument.
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

process_rq <- function(rq_obj, se.type = NULL,
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
