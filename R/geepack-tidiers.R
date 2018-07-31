#' @templateVar class geeglm
#' @template title_desc_tidy
#'
#' @param x A `geeglm` object returned from a call to [geepack::geeglm()].
#' @template param_confint
#' @template param_quick
#' @template param_exponentiate
#' @template param_unused_dots
#'
#' @details If `conf.int = TRUE`, the confidence interval is computed with
#' the an internal `confint.geeglm()` function.
#'
#' If you have missing values in your model data, you may need to
#' refit the model with `na.action = na.exclude` or deal with the
#' missingness in the data beforehand.
#'
#' @examples
#'
#' if (requireNamespace("geepack", quietly = TRUE)) {
#'   library(geepack)
#'   data(state)
#'     
#'   ds <- data.frame(state.region, state.x77)
#'
#'   geefit <- geeglm(Income ~ Frost + Murder, id = state.region,
#'                    data = ds, family = gaussian,
#'                    corstr = "exchangeable")
#'
#'   tidy(geefit)
#'   tidy(geefit, quick = TRUE)
#'   tidy(geefit, conf.int = TRUE)
#' }
#'
#' @rdname geeglm_tidiers
#' @return A [tibble::tibble] with one row for each coefficient, with five
#'   columns:
#'   \item{term}{The term in the linear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error from the GEE model}
#'   \item{statistic}{Wald statistic}
#'   \item{p.value}{two-sided p-value}
#'
#' If `conf.int = TRUE`, includes includes columns `conf.low` and `conf.high`,
#' which are computed internally.
#'
#' @export
#' @aliases geeglm_tidiers geepack_tidiers
#' @seealso [tidy()], [geepack::geeglm()]
#' 
tidy.geeglm <- function(x, conf.int = FALSE, conf.level = .95,
                        exponentiate = FALSE, quick = FALSE, ...) {
  if (quick) {
    co <- stats::coef(x)
    ret <- tibble(term = names(co), estimate = unname(co))
    return(ret)
  }
  co <- stats::coef(summary(x))

  nn <- c("estimate", "std.error", "statistic", "p.value")
  ret <- fix_data_frame(co, nn[1:ncol(co)])

  process_geeglm(ret, x,
    conf.int = conf.int, conf.level = conf.level,
    exponentiate = exponentiate
  )
}

process_geeglm <- function(ret, x, conf.int = FALSE, conf.level = .95,
                           exponentiate = FALSE) {
  if (exponentiate) {
    # save transformation function for use on confidence interval
    if (is.null(x$family) ||
      (x$family$link != "logit" && x$family$link != "log")) {
      warning(paste(
        "Exponentiating coefficients, but model did not use",
        "a log or logit link function"
      ))
    }
    trans <- exp
  } else {
    trans <- identity
  }

  if (conf.int) {
    # avoid "Waiting for profiling to be done..." message
    CI <- suppressMessages(stats::confint(x, level = conf.level))
    colnames(CI) <- c("conf.low", "conf.high")
    ret <- cbind(ret, trans(unrowname(CI)))
  }
  ret$estimate <- trans(ret$estimate)

  as_tibble(ret)
}

#' Generate confidence intervals for geeglm objects
#'
#' @param object A `geeglm` object.
#' @param parm The parameter to calculate the confidence interval
#'   for. If not specified, the default is to calculate a confidence
#'   interval on all parameters (all variables in the model).
#' @param level Confidence level of the interval.
#' @param ... Additional parameters (ignored).
#' 
#' @details From http://stackoverflow.com/a/21221995/2632184.
#' 
#' @return Lower and upper confidence bounds in a data.frame(?).
#' 
#' @noRd
confint.geeglm <- function(object, parm, level = 0.95, ...) {
  cc <- stats::coef(summary(object))
  mult <- stats::qnorm((1 + level) / 2)
  citab <- with(
    as.data.frame(cc),
    cbind(
      lwr = Estimate - mult * Std.err,
      upr = Estimate + mult * Std.err
    )
  )
  rownames(citab) <- rownames(cc)
  citab[parm, ]
}
