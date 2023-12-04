#' @templateVar class svyolr
#' @template title_desc_tidy
#'
#' @param x A `svyolr` object returned from [survey::svyolr()].
#' @template param_confint
#' @template param_exponentiate
#' @template param_unused_dots
#'
#' @details
#'
#' The `tidy.svyolr()` tidier is a light wrapper around
#' [tidy.polr()]. However, the implementation for p-value calculation
#' in [tidy.polr()] is both computationally intensive and specific to that
#' model, so the `p.values` argument to `tidy.svyolr()` is currently ignored,
#' and will raise a warning when passed.
#'
#' @examplesIf rlang::is_installed(c("survey", "MASS"))
#' library(broom)
#' library(survey)
#'
#' data(api)
#' dclus1 <- svydesign(id = ~dnum, weights = ~pw, data = apiclus1, fpc = ~fpc)
#' dclus1 <- update(dclus1, mealcat = cut(meals, c(0, 25, 50, 75, 100)))
#'
#' m <- svyolr(mealcat ~ avg.ed + mobility + stype, design = dclus1)
#'
#' m
#'
#' tidy(m, conf.int = TRUE)
#'
#' @export
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @aliases svyolr_tidiers
#' @export
#' @seealso [tidy], [survey::svyolr()]
#' @family ordinal tidiers
tidy.svyolr <- function(x, conf.int = FALSE, conf.level = 0.95,
                        exponentiate = FALSE, ...) {
  check_ellipses("p.values", "tidy", "svyolr", ...)

  return(
    tidy.polr(
      x,
      conf.int = conf.int,
      conf.level = conf.level,
      exponentiate = exponentiate
    )
  )
}

#' @templateVar class svyolr
#' @template title_desc_glance
#'
#' @inherit tidy.svyolr params examples
#'
#' @evalRd return_glance(
#'   "edf",
#'   "df.residual",
#'   "nobs"
#' )
#'
#' @export
#' @seealso [tidy], [survey::svyolr()]
#' @family ordinal tidiers
glance.svyolr <- function(x, ...) {
  tibble(
    edf = x$edf,
    df.residual = stats::df.residual(x),
    nobs = stats::nobs(x)
  )
}

#' @templateVar class svyglm
#' @template title_desc_tidy
#'
#' @param x A `svyglm` object returned from [survey::svyglm()].
#' @template param_confint
#' @template param_exponentiate
#' @template param_unused_dots
#'
#' @export
#' @family survey tidiers
#' @seealso [survey::svyglm()], [stats::glm()]
tidy.svyglm <- function(x, conf.int = FALSE, conf.level = 0.95,
                        exponentiate = FALSE, ...) {
  ret <- as_tibble(summary(x)$coefficients, rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")

  # summary(x)$coefficients misses rank deficient rows (i.e. coefs that
  # summary.lm() sets to NA), catch them here and add them back

  coefs <- tibble::enframe(stats::coef(x), name = "term", value = "estimate")
  ret <- left_join(coefs, ret, by = c("term", "estimate"))

  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level, ...)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }

  if (exponentiate) {
    ret <- exponentiate(ret)
  }

  ret
}

#' @templateVar class svyglm
#' @template title_desc_glance
#'
#' @param x A `svyglm` object returned from [survey::svyglm()].
#' @param maximal A `svyglm` object corresponding to the maximal
#'   model against which to compute the BIC. See Lumley and Scott
#'   (2015) for details. Defaults to `x`, which is equivalent
#'   to not using a maximal model.
#'
#' @template param_unused_dots
#'
#' @evalRd return_glance(
#'   "null.deviance",
#'   "df.null",
#'   "AIC",
#'   "BIC",
#'   "deviance",
#'   "df.residual"
#' )
#'
#' @examplesIf rlang::is_installed("survey")
#'
#' # load libraries for models and data
#' library(survey)
#'
#' set.seed(123)
#' data(api)
#'
#' # survey design
#' dstrat <-
#'   svydesign(
#'     id = ~1,
#'     strata = ~stype,
#'     weights = ~pw,
#'     data = apistrat,
#'     fpc = ~fpc
#'   )
#'
#' # model
#' m <- svyglm(
#'   formula = sch.wide ~ ell + meals + mobility,
#'   design = dstrat,
#'   family = quasibinomial()
#' )
#'
#' glance(m)
#'
#' @references Lumley T, Scott A (2015). AIC and BIC for modelling with complex
#'   survey data. *Journal of Survey Statistics and Methodology*, 3(1).
#'
#' @export
#' @family lm tidiers
#' @seealso [survey::svyglm()], [stats::glm()], [survey::anova.svyglm]
glance.svyglm <- function(x, maximal = x, ...) {
  # NOTES:
  #
  # (1) log-likelihood does not apply (returns deviance instead)
  #   logLik.svyglm() should result in a warning:
  #
  #   > Warning in logLik.svyglm(x) : svyglm not fitted by maximum likelihood.
  #
  # (2) AIC is not always directly computed by svyglm,
  #   e.g. if family = quasibinomial()

  as_glance_tibble(
    null.deviance = x$null.deviance,
    df.null = x$df.null,
    AIC = stats::AIC(x)["AIC"],
    BIC = stats::BIC(x, maximal = maximal)["BIC"],
    deviance = x$deviance,
    df.residual = x$df.residual,
    nobs = stats::nobs(x),
    na_types = "rirrrii"
  )
}
