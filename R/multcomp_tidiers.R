#' tidying methods for objects produced by \pkg{multcomp}
#'
#' These methods originated in ggplot2, as "fortify." In broom,
#' they were renamed "tidy" because they summarize terms and
#' tests, rather than adding columns to a dataset.
#' 
#' @param x an object of class \code{glht}, \code{confint.glht},
#'  \code{summary.glht} or \code{\link[multcomp]{cld}}
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
    unrowname(data.frame(
        lhs = rownames(x$linfct),
        rhs = x$rhs,
        estimate = stats::coef(x),
        check.names = FALSE,
        stringsAsFactors = FALSE))
}

#' @rdname multcomp_tidiers
#' @method tidy confint.glht
#' @export
tidy.confint.glht <- function(x, ...) {
    coef <- x$confint
    colnames(coef) <- c("estimate", "conf.low", "conf.high")

    unrowname(data.frame(
        lhs = rownames(coef),
        rhs = x$rhs,
        coef,
        check.names = FALSE,
        stringsAsFactors = FALSE))
}

#' @method tidy summary.glht
#' @rdname multcomp_tidiers
#' @export
tidy.summary.glht <- function(x, ...) {
    coef <- as.data.frame(
        x$test[c("coefficients", "sigma", "tstat", "pvalues")])
    names(coef) <- c("estimate", "std.error", "statistic", "p.value")
    
    unrowname(data.frame(
        lhs = rownames(coef),
        rhs = x$rhs,
        coef,
        check.names = FALSE,
        stringsAsFactors = FALSE))
}


#' @method tidy cld
#' @rdname multcomp_tidiers
#' @export
tidy.cld <- function(x, ...) {
    unrowname(data.frame(
        lhs = names(x$mcletters$Letters),
        letters = x$mcletters$Letters,
        check.names = FALSE,
        stringsAsFactors = FALSE))
}
