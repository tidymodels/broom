#' @templateVar class lm
#' @template title_desc_tidy
#'
#' @param x An `lm` object created by [stats::lm()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @details If the linear model is an `mlm` object (multiple linear model),
#'   there is an additional column `response`. See [tidy.mlm()].
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
#' d <- tidy(mod, conf.int = TRUE)
#'
#' ggplot(d, aes(estimate, term, xmin = conf.low, xmax = conf.high, height = 0)) +
#'   geom_point() +
#'   geom_vline(xintercept = 0, lty = 4) +
#'   geom_errorbarh()
#'   
#' # Both tidy() and glance() support lm.summary objects too. This can be 
#' # useful when you want to conserve memory by converting large lm objects into 
#' # their leaner summary.lm equivalents.
#' s <- summary(mod)
#' tidy(s, conf.int = TRUE)
#' glance(s)
#'
#' augment(mod)
#' augment(mod, mtcars, interval = "confidence")
#'
#' # predict on new data
#' newdata <- mtcars %>%
#'   head(6) %>%
#'   mutate(wt = wt + 1)
#' augment(mod, newdata = newdata)
#' 
#' # ggplot2 example where we also construct 95% prediction interval
#' mod2 <- lm(mpg ~ wt, data = mtcars) ## simpler bivariate model since we're plotting in 2D
#' 
#' au <- augment(mod2, newdata = newdata, interval = "prediction")
#' 
#' ggplot(au, aes(wt, mpg)) + 
#'   geom_point() +
#'   geom_line(aes(y = .fitted)) + 
#'   geom_ribbon(aes(ymin = .lower, ymax = .upper), col = NA, alpha = 0.3)
#' 
#' # predict on new data without outcome variable. Output does not include .resid
#' newdata <- newdata %>%
#'   select(-mpg)
#' augment(mod, newdata = newdata)
#'
#' au <- augment(mod, data = mtcars)
#'
#' ggplot(au, aes(.hat, .std.resid)) +
#'   geom_vline(size = 2, colour = "white", xintercept = 0) +
#'   geom_hline(size = 2, colour = "white", yintercept = 0) +
#'   geom_point() +
#'   geom_smooth(se = FALSE)
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
tidy.lm <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {

  # error on inappropriate subclassing
  # TODO: undo gee / mclogit and other catches
  if (length(class(x)) > 1) {
    warning(
      "Tidiers for objects of class ", class(x)[1], 
      " are not maintained by the broom team, and are only supported through ",
      "the tidy.lm() method. Please be cautious in interpreting and reporting ",
      "broom output.",
      call. = FALSE
    )
  }

  ret <- as_tibble(summary(x)$coefficients, rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")

  # summary(x)$coefficients misses rank deficient rows (i.e. coefs that
  # summary.lm() sets to NA), catch them here and add them back
  coefs <- tibble::enframe(stats::coef(x), name = "term", value = "estimate")
  ret <- left_join(coefs, ret, by = c("term", "estimate"))

  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }

  ret
}


# Additional tidy method for summary.lm objects
#' @templateVar class summary.lm
#' @template title_desc_tidy
#'
#' @param x A `summary.lm` object created by [summary(stats::lm())].
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @details The `glance.summary.lm()` method is a potentially useful alternative
#'   to [glance.lm()]. For instance, if users have already converted large `lm` 
#'   objects into their leaner `summary.lm` equivalents to conserve memory.
#' @export
#' @seealso [tidy()], [stats::summary.lm()]
#' @family lm tidiers
tidy.summary.lm <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
  ret <- as_tibble(x$coefficients, rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")
  # Aside: The x$coefficients will miss rank deficient rows (i.e. coefs that
  # summary.lm() sets to NA). We can't do much about that here, though since the
  # user has already passed the summary(x) object into the tidy call...
  
  # There's no confint() method for summary.lm object, but these are easy enough
  # to calculate manually
  if (conf.int) {
    ret <- ret %>%
      dplyr::mutate(
        conf.low = estimate - stats::qt(1-(1-conf.level)/2, df=x$df[2])*std.error,
        conf.high = estimate + stats::qt(1-(1-conf.level)/2, df=x$df[2])*std.error
      )
  }
  
  ret
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
#' @template param_interval
#'
#' @evalRd return_augment(
#'   ".hat",
#'   ".lower",
#'   ".upper", 
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
                       se_fit = FALSE, interval =  c("none", "confidence", "prediction"), ...) {
  interval <- match.arg(interval)
  df <- augment_newdata(x, data, newdata, se_fit, interval)

  if (is.null(newdata)) {
    tryCatch({
        infl <- influence(x, do.coef = FALSE)
        df$.std.resid <- rstandard(x, infl = infl) %>% unname()
        df <- add_hat_sigma_cols(df, x, infl)
        df$.cooksd <- cooks.distance(x, infl = infl) %>% unname()
      },
      error = data_error
    )
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
#'   df = "The degrees for freedom from the numerator of the overall 
#'     F-statistic. This is new in broom 0.7.0. Previously, this reported 
#'     the rank of the design matrix, which is one more than the numerator 
#'     degrees of freedom of the overall F-statistic.",
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
#' @seealso [glance()], [glance.summary.lm()]
#' @family lm tidiers
glance.lm <- function(x, ...) {
  # check whether the model was fitted with only an intercept, in which
  # case drop the fstatistic related columns
  int_only <- nrow(summary(x)$coefficients) == 1
  
  with(
    summary(x),
    tibble(
      r.squared = r.squared,
      adj.r.squared = adj.r.squared,
      sigma = sigma,
      statistic = if (!int_only) {fstatistic["value"]} else {NA_real_},
      p.value = if (!int_only) {
        pf(
          fstatistic["value"],
          fstatistic["numdf"],
          fstatistic["dendf"],
          lower.tail = FALSE
          )
        } else {NA_real_},
      df = if (!int_only) {fstatistic["numdf"]} else {NA_real_},
      logLik = as.numeric(stats::logLik(x)),
      AIC = stats::AIC(x),
      BIC = stats::BIC(x),
      deviance = stats::deviance(x),
      df.residual = df.residual(x),
      nobs = stats::nobs(x)
    )
  )
}


# Additional glance method for summary.lm objects
#' @templateVar class summary.lm
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
#'   df = "The degrees for freedom from the numerator of the overall 
#'     F-statistic. This is new in broom 0.7.0. Previously, this reported 
#'     the rank of the design matrix, which is one more than the numerator 
#'     degrees of freedom of the overall F-statistic.",
#'   "df.residual",
#'   "nobs"
#'   ) 
#' @details The `glance.summary.lm()` method is a potentially useful alternative
#'   to [glance.lm()]. For instance, if users have already converted large `lm` 
#'   objects into their leaner `summary.lm` equivalents to conserve memory. Note
#'   that this method doesn't return all of the columns of the non-summary 
#'   method (e.g. AIC and BIC will be missing.)
#' @export
#' @seealso [glance()], [glance.summary.lm()]
#' @family lm tidiers
glance.summary.lm <- function(x, ...) {
  # check whether the model was fitted with only an intercept, in which
  # case drop the fstatistic related columns
  int_only <- nrow(x$coefficients) == 1
  with(
    x,
    tibble(
      r.squared = r.squared,
      adj.r.squared = adj.r.squared,
      sigma = sigma,
      statistic = if (!int_only) {fstatistic["value"]} else {NA_real_},
      p.value = if (!int_only) {
        pf(
          fstatistic["value"],
          fstatistic["numdf"],
          fstatistic["dendf"],
          lower.tail = FALSE
        )
      } else {NA_real_},
      df = if (!int_only) {fstatistic["numdf"]} else {NA_real_},
      ## We can back out one or two more stats that would normally come with tidy.lm
      df.residual = as.integer(x$fstatistic["dendf"]),
      nobs = sum(as.integer(x$fstatistic[c("numdf", "dendf")])) + 1
    )
  )
}
