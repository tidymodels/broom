#' @templateVar class regsubsets
#' @template title_desc_tidy
#'
#' @param x A `regsubsets` object created by [leaps::regsubsets()].
#' @template param_unused_dots
#'
#  # define the documentation manually since r-squared and BIC are unusual
#  # elements of a tidy method output
#' @evalRd return_tidy(
#'   r.squared = "R squared statistic, or the percent of variation explained by the model.",
#'   adj.r.squared = "Adjusted R squared statistic",
#'   BIC = "Bayesian information criterion for the component.",
#'   mallows_cp = "Mallow's Cp statistic."
#' )
#'
#' @examples
#' 
#' # feel free to ignore the following line—it allows {broom} to supply 
#' # examples without requiring the model-supplying package to be installed.
#' if (requireNamespace("leaps", quietly = TRUE)) {
#'
#' # load libraries for models and data
#' library(leaps)
#'
#' # fit model
#' all_fits <- regsubsets(hp ~ ., mtcars)
#' 
#' # summarize model fit with tidiers
#' tidy(all_fits)
#' 
#' }
#' 
#' @aliases leaps_tidiers
#' @export
#' @seealso [tidy()], [leaps::regsubsets()]
tidy.regsubsets <- function(x, ...) {
  s <- summary(x)
  inclusions <- as_tibble(s$which)
  metrics <- with(
    s,
    tibble(
      r.squared = rsq,
      adj.r.squared = adjr2,
      BIC = bic,
      mallows_cp = cp
    )
  )
  bind_cols(inclusions, metrics)
}
