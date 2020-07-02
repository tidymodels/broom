#' Tidying methods for logit models
#' 
#' These methods tidy the coefficients of mnl and nl models generated
#' by the functions of the `mlogit` package.
#' 
#' @param x an object returned from [mlogit::mlogit()].
#' @template param_confint
#' @template param_unused_dots
#' 
#' @evalRd return_tidy(regression = TRUE)
#' 
#' @examples
#' \dontrun{
#' library(mlogit)
#' data("Fishing", package = "mlogit")
#' Fish <- dfidx(Fishing, varying = 2:9, shape = "wide", choice = "mode")
#' m <- mlogit(mode ~ price + catch | income, data = Fish)
#' }
#' 
#' @aliases mlogit_tidiers
#' @export
#' @family mlogit tidiers
#' @seealso [tidy()], [mlogit::mlogit()]
#' 
tidy.mlogit <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
  
  # construct parameter table
  s <- summary(x)
  ret <- as_tidy_tibble(
    s$CoefTable,
    new_names =  c("estimate", "std.error", "statistic", "p.value")
  )
  
  # calculate confidence interval
  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }
  
  ret
}



