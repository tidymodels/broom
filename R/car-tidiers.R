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
#' dw <- car::durbinWatsonTest(lm(mpg ~ wt, data = mtcars))
#' tidy(dw)
#' glance(dw) # same output for all durbinWatsonTests
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
#' if (requireNamespace("car", quietly = TRUE)) {
#' 
#' library(car)
#' data(Moore)
#' lt <- with(Moore, leveneTest(conformity, fcategory))
#' tidy(lt)
#' glance(lt) # same output for all leveneTest
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
