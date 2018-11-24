#' @templateVar class regsubsets
#' @template title_desc_tidy
#' 
#' @param x A `regsubsets` object created by [leaps::regsubsets()].
#' @template param_unused_dots
#' 
#' @evalRd return_tidy(
#'   "r.squared",
#'   "adj.r.squared",
#'   "BIC",
#'   mallows_cp = "Mallow's Cp statistic."
#' )
#' 
#' @examples
#' 
#' all_fits <- leaps::regsubsets(hp ~ ., mtcars)
#' tidy(all_fits)
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
