#' tidying methods for objects produced by \pkg{multcomp}
#'
#' @param x an object of class `glht`, `confint.glht`,
#'  `summary.glht` or [multcomp::cld()]
#' @param ... extra arguments (not used)
#'
#' @name multcomp_tidiers
#' @examples
#'
#' if (require("multcomp") && require("ggplot2")) {
#'     amod <- aov(breaks ~ wool + tension, data = warpbreaks)
#'     wht <- glht(amod, linfct = mcp(tension = "Tukey"))
#'
#'     tidy(wht)
#'     ggplot(wht, aes(lhs, estimate)) + geom_point()
#'
#'     CI <- confint(wht)
#'     tidy(CI)
#'     ggplot(CI, aes(lhs, estimate, ymin = lwr, ymax = upr)) +
#'        geom_pointrange()
#'
#'     tidy(summary(wht))
#'     ggplot(mapping = aes(lhs, estimate)) +
#'        geom_linerange(aes(ymin = lwr, ymax = upr), data = CI) +
#'        geom_point(aes(size = p), data = summary(wht)) +
#'        scale_size(trans = "reverse")
#'
#'     cld <- cld(wht)
#'     tidy(cld)
#' }
NULL

#' @method tidy glht
#' @rdname multcomp_tidiers
#' @export
tidy.glht <- function(x, ...) {
  tibble(
    lhs = rownames(x$linfct),
    rhs = x$rhs,
    estimate = stats::coef(x)
  )
}

#' @rdname multcomp_tidiers
#' @method tidy confint.glht
#' @export
tidy.confint.glht <- function(x, ...) {
  
  lhs_rhs <- tibble(
    lhs = rownames(x$linfct),
    rhs = x$rhs
  )
  
  coef <- as_tibble(x$confint)
  colnames(coef) <- c("estimate", "conf.low", "conf.high")

  bind_cols(lhs_rhs, coef)
}

#' @method tidy summary.glht
#' @rdname multcomp_tidiers
#' @export
tidy.summary.glht <- function(x, ...) {
  
  lhs_rhs <- tibble(
    lhs = rownames(x$linfct),
    rhs = x$rhs
  )
  
  coef <- as_tibble(
    x$test[c("coefficients", "sigma", "tstat", "pvalues")]
  )
  names(coef) <- c("estimate", "std.error", "statistic", "p.value")

  bind_cols(lhs_rhs, coef)
}


#' @method tidy cld
#' @rdname multcomp_tidiers
#' @export
tidy.cld <- function(x, ...) {
  vec <- x$mcletters$Letters
  tibble(lhs = names(vec), letters = vec)
}
