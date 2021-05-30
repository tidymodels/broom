#' @templateVar class elm
#' @template title_desc_tidy
#'
#' @param x An `elm` object returned from [eflm::elm()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @examples
#'
#' mod <- eflm::elm(mpg ~ wt + qsec, data = mtcars, fitted = TRUE)
#'
#' tidy(mod)
#' glance(mod)
#' augment(mod)
#' @aliases elm_tidiers
#' @export
#' @family elm tidiers
#' @seealso [eflm::elm()], [tidy.lm()]
#' @include stats-lm-tidiers.R
tidy.elm <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
  stopifnot(any(class(x) %in% "elm"))
  
  ret <- as.data.frame(summary(x)$coefficients)
  rownames(ret) <- NULL
  ret <- cbind(rownames(summary(x)$coefficients), ret)
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")
  
  coefs <- as.data.frame(coef(x))
  rownames(coefs) <- NULL
  coefs <- cbind(names(coef(x)), coefs)
  colnames(coefs) <- c("term", "estimate")
  
  ret <- merge(coefs, ret, by = c("term", "estimate"))
  
  if (conf.int) {
    ci <- suppressMessages(as.data.frame(confint(x, level = conf.level)))
    rownames(ci) <- NULL
    ci <- cbind(names(coef(x)), ci)
    colnames(ci) <- c("term", "conf.low", "conf.high")
    
    ret <- merge(ret, ci, by = "term")
  }
  
  return(tibble::as_tibble(ret))
}

#' @templateVar class elm
#' @template title_desc_glance
#'
#' @inherit tidy.elm params examples
#' @template param_unused_dots
#'
#' @evalRd return_glance(
#'   "r.squared",
#'   "adj.r.squared",
#'   statistic = "F-statistic.",
#'   "p.value",
#'   "df",
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "deviance",
#'   "df.residual",
#'   "nobs"
#' )
#'
#' @export
#' @family elm tidiers
#' @seealso [eflm::elm()]
glance.elm <- function(x, ...) {
  stopifnot(any(class(x) %in% "elm"))
  
  # Check whether the model was fitted with only an intercept, in which
  # case drop the fstatistic related column
  int_only <- nrow(summary(x)$coefficients) == 1
  
  df <- with(
    summary(x),
    data.frame(
      r.squared = r.squared,
      adj.r.squared = adj.r.squared,
      sigma = sigma,
      statistic = if (!int_only) {
        fstatistic["value"]
      } else {
        NA_real_
      },
      p.value = if (!int_only) {
        pf(
          fstatistic["value"],
          fstatistic["numdf"],
          fstatistic["dendf"],
          lower.tail = FALSE
        )
      } else {
        NA_real_
      },
      df = if (!int_only) {
        fstatistic["numdf"]
      } else {
        NA_real_
      },
      logLik = as.numeric(stats::logLik(x)),
      AIC = stats::AIC(x),
      BIC = stats::BIC(x),
      deviance = stats::deviance(x),
      df.residual = df.residual(x),
      nobs = stats::nobs(x)
    )
  )
  
  return(tibble::as_tibble(df))
}

#' @templateVar class elm
#' @template title_desc_augment
#'
#' @inherit tidy.elm params examples
#' @template param_data
#' @template param_newdata
#' @template param_unused_dots
#'
#' @evalRd return_augment()
#'
#' @importFrom rlang expr enexpr
#' @export
#' @family elm tidiers
#' @seealso [eflm::elm()]
augment.elm <- function(x, data = model.frame(x), newdata = NULL,
                        se_fit = FALSE, interval = c("none", "confidence", "prediction"), ...) {
  stopifnot(any(class(x) %in% "elm"))
  
  interval <- match.arg(interval)
  df <- augment_newdata(x, data, newdata, se_fit, interval)
  
  if (is.null(newdata)) {
    tryCatch(
      {
        infl <- influence(x, do.coef = FALSE)
        df <- add_hat_sigma_cols(df, x, infl)
      },
      error = data_error
    )
  }
  
  return(tibble::as_tibble(df))
}
