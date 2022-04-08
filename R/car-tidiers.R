#' @templateVar class durbinWatsonTest
#' @template title_desc_tidy_glance
#'
#' @param x An object of class `durbinWatsonTest` created by a call to
#'   [car::durbinWatsonTest()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy("p.value", "autocorrelation", "alternative",
#'   statistic = "Test statistic for Durbin-Watson test.",
#'   method = "Always `Durbin-Watson Test`."
#' )
#'
#' @examples
#' 
#' if (requireNamespace("car", quietly = TRUE)) {
#'
#' # load modeling library
#' library(car)
#' 
#' # fit model
#' dw <- durbinWatsonTest(lm(mpg ~ wt, data = mtcars))
#' 
#' # summarize model fit with tidiers
#' tidy(dw)
#' 
#' # same output for all durbinWatsonTests
#' glance(dw) 
#' 
#' }
#' 
#' @name durbinWatsonTest_tidiers
#' @family car tidiers
#' @export
#' @seealso [tidy()], [glance()], [car::durbinWatsonTest()]
tidy.durbinWatsonTest <- function(x, ...) {
  tibble(
    statistic = x$dw,
    p.value = x$p,
    autocorrelation = x$r,
    method = "Durbin-Watson Test",
    alternative = x$alternative
  )
}

#' @rdname durbinWatsonTest_tidiers
#' @export
glance.durbinWatsonTest <- function(x, ...) tidy(x)


#' @templateVar class leveneTest
#' @template title_desc_tidy_glance
#'
#' @param x An object of class `anova` created by a call to
#'   [car::leveneTest()].
#' @template param_unused_dots
#'
#' @evalRd  return_tidy(
#'   "statistic",
#'   "p.value",
#'   "df",
#'   "df.residual" = "Residual degrees of freedom."
#' )
#'
#' @examples
#'
#' # feel free to ignore the following line—it allows {broom} to supply 
#' # examples without requiring the model-supplying package to be installed.
#' if (requireNamespace("car", quietly = TRUE)) {
#' 
#' # load libraries for models and data
#' library(car)
#' 
#' data(Moore)
#' 
#' lt <- with(Moore, leveneTest(conformity, fcategory))
#' 
#' tidy(lt)
#' glance(lt)
#' 
#' }
#' @name leveneTest_tidiers
#' @family car tidiers
#' @export
#' @seealso [tidy()], [glance()], [car::leveneTest()]
tidy.leveneTest <- function(x, ...) {
  ret <- tibble::tibble(
    statistic = x[["F value"]][1],
    p.value = x[["Pr(>F)"]][1],
    df = x[["Df"]][1],
    df.residual = x[["Df"]][2]
  )
  ret
}
