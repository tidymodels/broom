#' @templateVar class speedlm
#' @template title_desc_tidy_lm_wrapper
#'
#' @param x A `speedlm` object returned from [speedglm::speedlm()].
#'
#' @examples
#'
#' mod <- speedglm::speedlm(mpg ~ wt + qsec, data = mtcars)
#' 
#' tidy(mod)
#' glance(mod)
#' augment(mod)
#'
#' @aliases speedlm_tidiers speedglm_tidiers
#' @export
#' @family speedlm tidiers
#' @seealso [speedglm::speedlm()]
#' @include stats-lm-tidiers
tidy.speedlm <- tidy.lm

#' @templateVar class speedlm
#' @template title_desc_glance
#'
#' @inherit tidy.speedlm params examples
#' @template param_unused_dots
#' 
#' @evalRd return_glance(
#'   "r.squared",
#'   "adj.r.squared",
#'   statistic = "F-statistic.",
#'   "p.value",
#'   "df",
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "deviance",
#'   "df.residual"
#' )
#'
#' @export
#' @family speedlm tidiers
#' @seealso [speedglm::speedlm()]
glance.speedlm <- function(x, ...) {
  s <- summary(x)
  ret <- tibble(
    r.squared = s$r.squared,
    adj.r.squared = s$adj.r.squared,
    statistic = s$fstatistic[1],
    p.value = s$f.pvalue,
    df = x$nvar
  )
  ret <- finish_glance(ret, x)
  ret$deviance <- x$RSS  # overwritten by finish_glance
  ret
}

#' @templateVar class speedlm
#' @template title_desc_augment
#'
#' @inherit tidy.speedlm params examples
#' @template param_data
#' @template param_newdata
#' @template param_unused_dots
#' 
#' @evalRd return_augment(.resid = FALSE)
#'
#' @export
#' @family speedlm tidiers
#' @seealso [speedglm::speedlm()]
augment.speedlm <- function(x, data = model.frame(x), newdata = NULL, ...) {
  augment_columns(x, data, newdata)
}
