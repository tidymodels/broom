#' @templateVar class logistf
#' @template title_desc_tidy
#'
#' @param x A `logistf` object returned from [logistf::logistf()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#' 
#' @details The `logistf` package implements "logistic regression model using
#' Firth's bias reduction method."
#'
#' @examples
#' library(logistf)
#'
#' dat <- data.frame(time = 1:12, 
#'                   event = c(0,1,0,1,1,1,1,1,1,1,1,1))
#' mod <- logistf::logistf(event ~time, dat)
#' tidy(mod)
#' glance(mod)
#'
#' @export
#' @aliases logistf_tidiers
#' @family logistf tdiers
#' @seealso [tidy()], [logistf::logistf()]
tidy.logistf <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {

  trash <- utils::capture.output(s <- summary(x))
  ret <- tibble(
     term = names(s$coefficients),
     estimate = s$coefficients,
     std.error = sqrt(diag(s$var)),
     p.value = s$prob)
  
  if (conf.int) {
    if (conf.level != x$conflev) {
      warning("Models of class `logistf` do not allow `glance` to modify the alpha level after fitting the model. Please use the `alpha` argument of the `logistf::logistf` function.")
    }

    ## broom_confint_terms triggers a level-related argument 
    # ci <- broom_confint_terms(x, level = conf.level)
    # ret <- dplyr::left_join(ret, ci, by = "term")

    ci <- confint(x, level = conf.level)
    ci <- tibble::tibble(
      term = row.names(ci),
      conf.low = ci[, 1],
      conf.high = ci[, 2])

    ret <- dplyr::left_join(ret, ci, by = "term")
  }

  ret
}



#' @templateVar class logistf
#' @template title_desc_glance
#'
#' @inherit tidy.logistf params examples
#'
#' @evalRd return_glance(
#'   "df",
#'   "nobs"
#' )
#'
#' @export
glance.logistf <- function(x, ...) {
  trash <- utils::capture.output(s <- summary(x, ...))
  ret <- as_glance_tibble(
    df     = s$df,
    nobs   = s$n,
    na_types = "ii")
  ret
}
