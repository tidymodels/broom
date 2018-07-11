#' @templateVar class glht
#' @template title_desc_tidy
#' 
#' @param x A `glht` object returned by [multcomp::glht()].
#' @template param_unused_dots
#'
#' @examples
#'
#' if (require("multcomp") && require("ggplot2")) {
#' 
#'     library(multcomp)
#'     library(ggplot2)
#'     
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
#' 
#' @aliases multcomp_tidiers
#' @export
#' @family multcomp tidiers
#' @seealso [tidy()], [multcomp::glht()]
#' 
tidy.glht <- function(x, ...) {
  tibble(
    lhs = rownames(x$linfct),
    rhs = x$rhs,
    estimate = stats::coef(x)
  )
}

#' @templateVar class confint.glht
#' @template title_desc_tidy
#' 
#' @param x A `confint.glht` object created by calling 
#'   [multcomp::confint.glht()] on a `glht` object created with
#'   [multcomp::glht()].
#' @template param_unused_dots
#' 
#' @export
#' @family multcomp tidiers
#' @seealso [tidy()], [multcomp::confint.glht()], [multcomp::glht()]
tidy.confint.glht <- function(x, ...) {
  
  lhs_rhs <- tibble(
    lhs = rownames(x$linfct),
    rhs = x$rhs
  )
  
  coef <- as_tibble(x$confint)
  colnames(coef) <- c("estimate", "conf.low", "conf.high")

  bind_cols(lhs_rhs, coef)
}

#' @templateVar class summary.glht
#' @template title_desc_tidy
#' 
#' @param x A `summary.glht` object created by calling 
#'   [multcomp::summary.glht()] on a `glht` object created with
#'   [multcomp::glht()].
#' @template param_unused_dots
#' 
#' @export
#' @family multcomp tidiers
#' @seealso [tidy()], [multcomp::summary.glht()], [multcomp::glht()]
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


#' @templateVar class cld
#' @template title_desc_tidy
#' 
#' @param x A `cld` object created by calling [multcomp::cld()] on a 
#'   `glht`, `confint.glht()` or `summary.glht()` object.
#' @template param_unused_dots
#' 
#' @export
#' @family multcomp tidiers
#' @seealso [tidy()], [multcomp::cld()], [multcomp::summary.glht()],
#'   [multcomp::confint.glht()], [multcomp::glht()]
tidy.cld <- function(x, ...) {
  vec <- x$mcletters$Letters
  tibble(lhs = names(vec), letters = vec)
}
