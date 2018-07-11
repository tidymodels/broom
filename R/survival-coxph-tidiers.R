#' @templateVar class coxph
#' @template title_desc_tidy
#'
#' @param x A `coxph` object returned from [survival::coxph()].
#' @template param_confint
#' @template param_exponentiate
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with one row for each term and columns:
#' 
#'   \item{estimate}{estimate of slope}
#'   \item{std.error}{standard error of estimate}
#'   \item{statistic}{test statistic}
#'   \item{p.value}{p-value}
#'
#' @examples 
#' 
#' library(survival)
#' 
#' cfit <- coxph(Surv(time, status) ~ age + sex, lung)
#'
#' tidy(cfit)
#' tidy(cfit, exponentiate = TRUE)
#'
#' lp <- augment(cfit, lung)
#' risks <- augment(cfit, lung, type.predict = "risk")
#' expected <- augment(cfit, lung, type.predict = "expected")
#'
#' glance(cfit)
#'
#' # also works on clogit models
#' resp <- levels(logan$occupation)
#' n <- nrow(logan)
#' indx <- rep(1:n, length(resp))
#' logan2 <- data.frame(
#'   logan[indx,],
#'   id = indx,
#'   tocc = factor(rep(resp, each=n))
#' )
#' 
#' logan2$case <- (logan2$occupation == logan2$tocc)
#'
#' cl <- clogit(case ~ tocc + tocc:education + strata(id), logan2)
#' tidy(cl)
#' glance(cl)
#'
#' library(ggplot2)
#' 
#' ggplot(lp, aes(age, .fitted, color = sex)) +
#'   geom_point()
#' 
#' ggplot(risks, aes(age, .fitted, color = sex)) + 
#'   geom_point()
#'   
#' ggplot(expected, aes(time, .fitted, color = sex)) + 
#'   geom_point()
#' 
#' 
#' @aliases coxph_tidiers
#' @export
#' @seealso [tidy()], [survival::coxph()]
#' @family coxph tidiers
#' @family survival tidiers
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


#' @templateVar class coxph
#' @template title_desc_augment
#' 
#' @param x A `coxph` object returned from [survival::coxph()].
#' @template param_data
#' @template param_newdata
#' @template param_type_residuals
#' @template param_type_predict
#' @template param_unused_dots
#'
#' @template augment_NAs
#'
#' @return A [tibble::tibble] with the passed data and additional columns:
#' 
#'   \item{.fitted}{Fitted values of model}
#'   \item{.se.fit}{Standard errors of fitted values}
#'   \item{.resid}{Residuals (not present if `newdata` specified.)}
#'
#' @export
#' @seealso [augment()], [survival::coxph()]
#' @family coxph tidiers
#' @family survival tidiers
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

#' @templateVar class coxph
#' @template title_desc_glance
#' 
#' @inheritParams tidy.coxph
#' 
#' @return A one-row [tibble::tibble] with columns: TODO.
#'
#' @export
#' @seealso [glance()], [survival::coxph()]
#' @family coxph tidiers
#' @family survival tidiers
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
