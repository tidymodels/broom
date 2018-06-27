
#' Tidiers for coxph object
#'
#' Tidy the coefficients of a Cox proportional hazards regression model,
#' construct predictions, or summarize the entire model into a single row.
#'
#' @param x "coxph" object
#' @param data original data for `augment`
#' @param exponentiate whether to report the estimate and confidence intervals
#' on an exponential scale
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level of the interval, used only if `conf.int=TRUE`
#' @param newdata new data on which to do predictions
#' @param type.predict type of predicted value (see [predict.coxph()])
#' @param type.residuals type of residuals (see [residuals.coxph()])
#' @param ... Extra arguments, not used
#'
#' @name coxph_tidiers
#'
#' @examples
#'
#' if (require("survival", quietly = TRUE)) {
#'     cfit <- coxph(Surv(time, status) ~ age + sex, lung)
#'
#'     tidy(cfit)
#'     tidy(cfit, exponentiate = TRUE)
#'
#'     lp <- augment(cfit, lung)
#'     risks <- augment(cfit, lung, type.predict = "risk")
#'     expected <- augment(cfit, lung, type.predict = "expected")
#'
#'     glance(cfit)
#'
#'     # also works on clogit models
#'     resp <- levels(logan$occupation)
#'     n <- nrow(logan)
#'     indx <- rep(1:n, length(resp))
#'     logan2 <- data.frame(logan[indx,],
#'                          id = indx,
#'                          tocc = factor(rep(resp, each=n)))
#'     logan2$case <- (logan2$occupation == logan2$tocc)
#'
#'     cl <- clogit(case ~ tocc + tocc:education + strata(id), logan2)
#'     tidy(cl)
#'     glance(cl)
#'
#'     library(ggplot2)
#'     ggplot(lp, aes(age, .fitted, color = sex)) + geom_point()
#'     ggplot(risks, aes(age, .fitted, color = sex)) + geom_point()
#'     ggplot(expected, aes(time, .fitted, color = sex)) + geom_point()
#' }


#' @rdname coxph_tidiers
#'
#' @return `tidy` returns a data.frame with one row for each term,
#' with columns
#'   \item{estimate}{estimate of slope}
#'   \item{std.error}{standard error of estimate}
#'   \item{statistic}{test statistic}
#'   \item{p.value}{p-value}
#'
#' @export

tidy.coxph <- function(x, exponentiate = FALSE, conf.int = TRUE, conf.level = .95, ...) {
  # backward compatibility (in previous version, conf.int was used instead of conf.level)
  if (is.numeric(conf.int)) {
    conf.level <- conf.int
    conf.int <- TRUE
  }
  
  if (conf.int) {
    s <- summary(x, conf.int = conf.level)
  } else {
    s <- summary(x, conf.int = FALSE)
  }
  co <- stats::coef(s)
  
  if (s$used.robust) {
    nn <- c("estimate", "std.error", "robust.se", "statistic", "p.value")
  } else {
    nn <- c("estimate", "std.error", "statistic", "p.value")
  }
  
  ret <- fix_data_frame(co[, -2, drop = FALSE], nn)
  
  if (exponentiate) {
    ret$estimate <- exp(ret$estimate)
  }
  if (!is.null(s$conf.int)) {
    CI <- as.matrix(unrowname(s$conf.int[, 3:4, drop = FALSE]))
    colnames(CI) <- c("conf.low", "conf.high")
    if (!exponentiate) {
      CI <- log(CI)
    }
    ret <- cbind(ret, CI)
  }
  
  as_tibble(ret)
}


#' @rdname coxph_tidiers
#'
#' @template augment_NAs
#'
#' @return `augment` returns the original data.frame with additional
#' columns added:
#'   \item{.fitted}{predicted values}
#'   \item{.se.fit}{standard errors }
#'   \item{.resid}{residuals (not present if `newdata` is provided)}
#'
#' @export
augment.coxph <- function(x, data = NULL, newdata = NULL,
                          type.predict = "lp", type.residuals = "martingale",
                          ...) {
  if (is.null(data) && is.null(newdata)) {
    stop("Must specify either `data` or `newdata` argument.", call. = FALSE)
  }
  
  augment_columns(x, data, newdata,
                  type.predict = type.predict,
                  type.residuals = type.residuals
  )
}


#' @rdname coxph_tidiers
#'
#' @return `glance` returns a one-row data.frame with statistics
#' calculated on the cox regression.
#'
#' @export
glance.coxph <- function(x, ...) {
  s <- summary(x)
  
  # including all the test statistics and p-values as separate
  # columns. Admittedly not perfect but does capture most use cases.
  ret <- list(
    n = s$n,
    nevent = s$nevent,
    statistic.log = s$logtest[1],
    p.value.log = s$logtest[3],
    statistic.sc = s$sctest[1],
    p.value.sc = s$sctest[3],
    statistic.wald = s$waldtest[1],
    p.value.wald = s$waldtest[3],
    statistic.robust = s$robscore[1],
    p.value.robust = s$robscore[3],
    r.squared = s$rsq[1],
    r.squared.max = s$rsq[2],
    concordance = s$concordance[1],
    std.error.concordance = s$concordance[2]
  )
  ret <- as.data.frame(compact(ret))
  finish_glance(ret, x)
}
