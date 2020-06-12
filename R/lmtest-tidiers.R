#' @templateVar class coeftest
#' @template title_desc_tidy
#'
#' @param x A `coeftest` object returned from [lmtest::coeftest()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @examples
#'
#' library(lmtest)
#'
#' data(Mandible)
#' fm <- lm(length ~ age, data = Mandible, subset = (age <= 28))
#'
#' lmtest::coeftest(fm)
#' tidy(coeftest(fm))
#' @export
#' @seealso [tidy()], [lmtest::coeftest()]
#' @aliases lmtest_tidiers coeftest_tidiers
tidy.coeftest <- function(x, conf.int = FALSE, conf.level = .95, ...) {
  co <- as.data.frame(unclass(x))
  ret <- as_tidy_tibble(
    co, 
    new_names = c("estimate", "std.error", "statistic", "p.value")[1:ncol(co)]
  )
  
  if (conf.int) {
    if (utils::packageVersion("lmtest") < "0.9.37") {
      warning("Needs lmtest version >=0.9.37 for conf.int = TRUE")
      return(ret)
    }
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }
  ret
}
