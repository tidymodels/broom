#' @templateVar class glht
#' @template title_desc_tidy
#'
#' @param x A `glht` object returned by [multcomp::glht()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy("contrast", "null.value", "estimate")
#'
#' @examples
#'
#' library(multcomp)
#' library(ggplot2)
#'
#' amod <- aov(breaks ~ wool + tension, data = warpbreaks)
#' wht <- glht(amod, linfct = mcp(tension = "Tukey"))
#'
#' tidy(wht)
#' ggplot(wht, aes(lhs, estimate)) +
#'   geom_point()
#'
#' CI <- confint(wht)
#' tidy(CI)
#' ggplot(CI, aes(lhs, estimate, ymin = lwr, ymax = upr)) +
#'   geom_pointrange()
#'
#' tidy(summary(wht))
#' ggplot(mapping = aes(lhs, estimate)) +
#'   geom_linerange(aes(ymin = lwr, ymax = upr), data = CI) +
#'   geom_point(aes(size = p), data = summary(wht)) +
#'   scale_size(trans = "reverse")
#'
#' cld <- cld(wht)
#' tidy(cld)
#' @aliases multcomp_tidiers
#' @export
#' @family multcomp tidiers
#' @seealso [tidy()], [multcomp::glht()]
#'
tidy.glht <- function(x, conf.int = FALSE, conf.level = .95, ...) {
  glht_summary <- summary(x, ...)

  tidy_glht_summary <- tidy.summary.glht(glht_summary, ...)

  if (conf.int) {
    tidy_glht_confint <- tidy.confint.glht(confint(x, level = conf.level, ...))

    tidy_glht_summary <- dplyr::select(tidy_glht_summary, -std.error) %>%
      dplyr::left_join(tidy_glht_confint) %>%
      select(
        term, contrast, null.value, estimate,
        conf.low, conf.high, dplyr::everything()
      )

    return(tidy_glht_summary)
  }

  tidy_glht_summary
}

#' @templateVar class confint.glht
#' @template title_desc_tidy
#'
#' @param x A `confint.glht` object created by calling
#'   [multcomp::confint.glht()] on a `glht` object created with
#'   [multcomp::glht()].
#' @template param_unused_dots
#'
#' @inherit tidy.glht examples
#' @evalRd return_tidy("contrast", "estimate", "conf.low", "conf.high")
#'
#' @export
#' @family multcomp tidiers
#' @seealso [tidy()], [multcomp::confint.glht()], [multcomp::glht()]
tidy.confint.glht <- function(x, ...) {
  lhs_rhs <- glht_lhr_rhs_tibble(x)

  coef <- as_tibble(x$confint)

  colnames(coef) <- c("estimate", "conf.low", "conf.high")
  coef$estimate <- as.vector(coef$estimate) # Remove attributes

  bind_cols(glht_term_column(x), lhs_rhs[, "contrast", drop = FALSE], coef)
}

#' @templateVar class summary.glht
#' @template title_desc_tidy
#'
#' @param x A `summary.glht` object created by calling
#'   [multcomp::summary.glht()] on a `glht` object created with
#'   [multcomp::glht()].
#' @template param_unused_dots
#'
#' @inherit tidy.glht examples
#' @evalRd return_tidy(
#'   "contrast",
#'   "null.value",
#'   "estimate",
#'   "std.error",
#'   "statistic",
#'   "p.value"
#' )
#'
#' @export
#' @family multcomp tidiers
#' @seealso [tidy()], [multcomp::summary.glht()], [multcomp::glht()]
tidy.summary.glht <- function(x, ...) {
  lhs_rhs <- glht_lhr_rhs_tibble(x)

  coef <- as_tibble(
    x$test[c("coefficients", "sigma", "tstat", "pvalues")]
  )

  if (x$test$type != "none") {
    pvalue_colname <- "adj.p.value"
  } else {
    pvalue_colname <- "p.value"
  }

  names(coef) <- c("estimate", "std.error", "statistic", pvalue_colname)

  bind_cols(glht_term_column(x), lhs_rhs, coef)
}


glht_lhr_rhs_tibble <- function(x) {
  tibble(
    contrast = stringr::str_replace(rownames(x$linfct), "^.+: ", ""),
    null.value = x$rhs
  )
}

glht_term_column <- function(x) {
  if (!is.null(x$focus) && length(x$focus) == 1) {
    tibble(term = rep(x$focus, nrow(x$linfct)))
  } else if (!is.null(x$focus) && length(x$focus) > 1) {
    term <- stringr::str_extract(rownames(x$linfct), "(^.+): .")
    term <- stringr::str_replace(term, ": .$", "")
    tibble(term = term)
  }
}


#' @templateVar class cld
#' @template title_desc_tidy
#'
#' @param x A `cld` object created by calling [multcomp::cld()] on a
#'   `glht`, `confint.glht()` or `summary.glht()` object.
#' @template param_unused_dots
#'
#' @inherit tidy.glht examples
#' @evalRd return_tidy("contrast", "letters")
#'
#' @export
#' @family multcomp tidiers
#' @seealso [tidy()], [multcomp::cld()], [multcomp::summary.glht()],
#'   [multcomp::confint.glht()], [multcomp::glht()]
tidy.cld <- function(x, ...) {
  vec <- x$mcletters$Letters
  tidy_cld <- tibble(names(vec), vec)
  colnames(tidy_cld) <- c(x$xname, "letters")
  tidy_cld
}
