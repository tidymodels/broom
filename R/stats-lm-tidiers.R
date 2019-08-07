#' @templateVar class lm
#' @template title_desc_tidy
#'
#' @param x An `lm` object created by [stats::lm()].
#' @template param_confint 
#' @template param_exponentiate
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @details If the linear model is an `mlm` object (multiple linear model),
#'   there is an additional column `response`.
#'
#'   If you have missing values in your model data, you may need to refit
#'   the model with `na.action = na.exclude`.
#'
#' @examples
#'
#' library(ggplot2)
#' library(dplyr)
#'
#' mod <- lm(mpg ~ wt + qsec, data = mtcars)
#'
#' tidy(mod)
#' glance(mod)
#'
#' # coefficient plot
#' d <- tidy(mod) %>%
#'   mutate(
#'     low = estimate - std.error,
#'     high = estimate + std.error
#'   )
#'
#' ggplot(d, aes(estimate, term, xmin = low, xmax = high, height = 0)) +
#'   geom_point() +
#'   geom_vline(xintercept = 0) +
#'   geom_errorbarh()
#'
#' augment(mod)
#' augment(mod, mtcars)
#'
#' # predict on new data
#' newdata <- mtcars %>% head(6) %>% mutate(wt = wt + 1)
#' augment(mod, newdata = newdata)
#'
#' au <- augment(mod, data = mtcars)
#'
#' ggplot(au, aes(.hat, .std.resid)) +
#'   geom_vline(size = 2, colour = "white", xintercept = 0) +
#'   geom_hline(size = 2, colour = "white", yintercept = 0) +
#'   geom_point() + geom_smooth(se = FALSE)
#'
#' plot(mod, which = 6)
#' ggplot(au, aes(.hat, .cooksd)) +
#'   geom_vline(xintercept = 0, colour = NA) +
#'   geom_abline(slope = seq(0, 3, by = 0.5), colour = "white") +
#'   geom_smooth(se = FALSE) +
#'   geom_point()
#'
#' # column-wise models
#' a <- matrix(rnorm(20), nrow = 10)
#' b <- a + rnorm(length(a))
#' result <- lm(b ~ a)
#' tidy(result)
#' @aliases lm_tidiers
#' @export
#' @seealso [tidy()], [stats::summary.lm()]
#' @family lm tidiers
tidy.lm <- function(x, conf.int = FALSE, conf.level = .95,
                    exponentiate = FALSE, ...) {
  
  s <- summary(x)
  ret <- tidy.summary.lm(s)

  process_lm(ret, x,
    conf.int = conf.int, conf.level = conf.level,
    exponentiate = exponentiate
  )
}


#' @rdname tidy.lm
#' @export
tidy.summary.lm <- function(x, ...) {
  co <- stats::coef(x)
  nn <- c("estimate", "std.error", "statistic", "p.value")

  ret <- fix_data_frame(co, nn[1:ncol(co)])

  as_tibble(ret)
}

#' @templateVar class lm
#' @template title_desc_augment
#'
#' @template augment_NAs
#'
#' @inherit tidy.lm params examples
#' @template param_data
#' @template param_newdata
#' @template param_se_fit
#'
#' @evalRd return_augment(
#'   ".hat",
#'   ".sigma",
#'   ".cooksd",
#'   ".se.fit",
#'   ".std.resid"
#' )
#'
#' @details Some unusual `lm` objects, such as `rlm` from MASS, may omit
#'   `.cooksd` and `.std.resid`. `gam` from mgcv omits `.sigma`.
#'
#'   When `newdata` is supplied, only returns `.fitted`, `.resid` and
#'   `.se.fit` columns.
#'
#' @export
#' @seealso [augment()], [stats::predict.lm()]
#' @family lm tidiers
augment.lm <- function(x, data = model.frame(x), newdata = NULL,
                       se_fit = FALSE, ...) {
  df <- augment_newdata(x, data, newdata, se_fit)

  if (is.null(newdata)) {
    tryCatch({
      infl <- influence(x, do.coef = FALSE)
      df$.std.resid <- rstandard(x, infl = infl)
      df <- add_hat_sigma_cols(df, x, infl)
      df$.cooksd <- cooks.distance(x, infl = infl)
    }, error = data_error)
  }

  df
}


#' @templateVar class lm
#' @template title_desc_glance
#'
#' @inherit tidy.lm params examples
#'
#' @evalRd return_glance(
#'   "r.squared",
#'   "adj.r.squared",
#'   "sigma",
#'   "statistic",
#'   "p.value",
#'   df = "The degrees for freedom from the numerator of the overall F-statistic. This is new in broom 0.7.0. Previously, this reported the rank of the design matrix, which is one more than the numerator degrees of freedom of the overall F-statistic.",
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "deviance",
#'   "df.residual",
#'   "nobs"
#' )
#'
#'
#' @export
#' @seealso [glance()]
#' @family lm tidiers
glance.lm <- function(x, ...) {
  with(
    summary(x),
    tibble(
      r.squared = r.squared,
      adj.r.squared = adj.r.squared,
      sigma = sigma,
      statistic = fstatistic["value"],
      p.value = pf(
        fstatistic["value"],
        fstatistic["numdf"],
        fstatistic["dendf"],
        lower.tail = FALSE
      ),
      df = fstatistic["numdf"],
      logLik = as.numeric(stats::logLik(x)),
      AIC = stats::AIC(x),
      BIC = stats::BIC(x),
      deviance = stats::deviance(x),
      df.residual = df.residual(x),
      nobs = stats::nobs(x)
    )
  )
}

# getAnywhere('format.perc')
.format.perc <- function(probs, digits) {
  paste(
    format(
      100 * probs,
      trim = TRUE,
      scientific = FALSE,
      digits = digits
    ),
    "%"
  )
}


process_lm <- function(ret,
                       x,
                       conf.int = FALSE,
                       conf.level = .95,
                       exponentiate = FALSE) {
  if (exponentiate) {
    # save transformation function for use on confidence interval
    if (is.null(x$family) ||
      (x$family$link != "logit" && x$family$link != "log")) {
      warning(paste(
        "Exponentiating coefficients, but model did not use",
        "a log or logit link function."
      ))
    }
    trans <- exp
  } else {
    trans <- identity
  }

  if (conf.int) {

    # avoid "Waiting for profiling to be done..." message
    CI <- suppressMessages(stats::confint(x, level = conf.level))
    # Handle case if regression is rank deficient
    p <- x$rank
    if (!is.null(p) && !is.null(x$qr)) {
      piv <- x$qr$pivot[seq_len(p)]
      CI <- CI[piv, , drop = FALSE]
    }
    colnames(CI) <- c("conf.low", "conf.high")
    ret <- cbind(ret, trans(unrowname(CI)))
  }

  ret$estimate <- trans(ret$estimate)

  as_tibble(ret)
}
