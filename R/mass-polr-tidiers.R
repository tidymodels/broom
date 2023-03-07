#' @templateVar class polr
#' @template title_desc_tidy
#'
#' @param x A `polr` object returned from [MASS::polr()].
#' @template param_confint
#' @template param_exponentiate
#' @param p.values Logical. Should p-values be returned,
#' based on chi-squared tests from [MASS::dropterm()]. Defaults to FALSE.
#' @template param_unused_dots
#'
#' @examplesIf rlang::is_installed("MASS")
#'
#' # load libraries for models and data
#' library(MASS)
#'
#' # fit model
#' fit <- polr(Sat ~ Infl + Type + Cont, weights = Freq, data = housing)
#'
#' # summarize model fit with tidiers
#' tidy(fit, exponentiate = TRUE, conf.int = TRUE)
#'
#' glance(fit)
#' augment(fit, type.predict = "class")
#'
#' fit2 <- polr(factor(gear) ~ am + mpg + qsec, data = mtcars)
#'
#' tidy(fit, p.values = TRUE)
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @details In `broom 0.7.0` the `coefficient_type` column was renamed to
#'   `coef.type`, and the contents were changed as well. Now the contents
#'   are `coefficient` and `scale`, rather than `coefficient` and `zeta`.
#'
#'   Calculating p.values with the `dropterm()` function is the approach
#'   suggested by the MASS package author. This
#'   approach is computationally intensive so that p.values are only
#'   returned if requested explicitly. Additionally, it only works for
#'   models containing no variables with more than two categories. If this
#'   condition is not met, a message is shown and NA is returned instead of
#'   p-values.
#'
#' @aliases polr_tidiers
#' @export
#' @seealso [tidy], [MASS::polr()]
#' @family ordinal tidiers
tidy.polr <- function(x, conf.int = FALSE, conf.level = 0.95,
                      exponentiate = FALSE, p.values = FALSE, ...) {
  ret <- as_tibble(coef(summary(x)), rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic")

  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }

  if (exponentiate) {
    ret <- exponentiate(ret)
  }

  if (p.values) {
    sig <- MASS::dropterm(x, test = "Chisq")
    p <- sig %>%
      dplyr::select(`Pr(Chi)`) %>%
      dplyr::pull() %>%
      .[-1]
    terms <- purrr::map(rownames(sig)[-1], function(x) {
      ret$term[stringr::str_detect(ret$term, stringr::fixed(x))]
    }) %>% unlist()
    if (length(p) == length(terms)) {
      ret <- dplyr::left_join(ret, tibble::tibble(term = terms, p.value = p), by = "term")
    } else {
      message("p-values can presently only be returned for models that contain
              no categorical variables with more than two levels")
      ret$p.value <- NA
    }
  }

  mutate(
    ret,
    coef.type = if_else(term %in% names(x$zeta), "scale", "coefficient")
  )
}

#' @templateVar class polr
#' @template title_desc_glance
#'
#' @inherit tidy.polr params examples
#'
#' @evalRd return_glance(
#'  "edf",
#'  "logLik",
#'  "AIC",
#'  "BIC",
#'  "deviance",
#'  "df.residual",
#'  "nobs"
#' )
#'
#' @export
#' @seealso [tidy], [MASS::polr()]
#' @family ordinal tidiers
glance.polr <- function(x, ...) {
  as_glance_tibble(
    edf = x$edf,
    logLik = as.numeric(stats::logLik(x)),
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    deviance = stats::deviance(x),
    df.residual = stats::df.residual(x),
    nobs = stats::nobs(x),
    na_types = "irrrrii"
  )
}

#' @templateVar class polr
#' @template title_desc_augment
#'
#' @inherit tidy.polr params examples
#' @template param_data
#' @template param_newdata
#'
#' @param type.predict Which type of prediction to compute,
#'  passed to `MASS:::predict.polr()`. Only supports `"class"` at
#'  the moment.
#'
#' @export
#' @seealso [tidy()], [MASS::polr()]
#' @family ordinal tidiers
#'
augment.polr <- function(x, data = model.frame(x), newdata = NULL,
                         type.predict = c("class"), ...) {
  type <- rlang::arg_match(type.predict)

  df <- if (is.null(newdata)) data else newdata
  df <- as_augment_tibble(df)

  df$.fitted <- predict(object = x, newdata = df, type = type)

  df
}
