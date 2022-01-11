#' @templateVar class summary.lm
#' @template title_desc_tidy
#'
#' @param x A `summary.lm` object created by [stats::summary.lm()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @details The `tidy.summary.lm()` method is a potentially useful alternative
#'   to [tidy.lm()]. For instance, if users have already converted large `lm` 
#'   objects into their leaner `summary.lm` equivalents to conserve memory.
#'   
#' @examples
#'
#' # fit model
#' mod <- lm(mpg ~ wt + qsec, data = mtcars)
#' modsumm <- summary(mod)
#'
#' # summarize model fit with tidiers
#' tidy(mod, conf.int = TRUE)
#' 
#' # equivalent to the above
#' tidy(modsumm, conf.int = TRUE) 
#' 
#' glance(mod)
#' 
#' # mostly the same, except for a few missing columns
#' glance(modsumm) 
#' 
#' @export
#' @seealso [tidy()], [stats::summary.lm()]
#' @family lm tidiers
tidy.summary.lm <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
  ret <- as_tibble(x$coefficients, rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")
  # aside: The x$coefficients will miss rank deficient rows (i.e. coefs that
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


# additional glance method for summary.lm objects
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
#'   objects into their leaner `summary.lm` equivalents to conserve memory. Note,
#'   however, that this method does not return all of the columns of the 
#'   non-summary method (e.g. AIC and BIC will be missing.)
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
      # We can back out one or two more stats that would normally come with tidy.lm
      df.residual = as.integer(x$fstatistic["dendf"]),
      nobs = sum(as.integer(x$fstatistic[c("numdf", "dendf")])) + 1
    )
  )
}

