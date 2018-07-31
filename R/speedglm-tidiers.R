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
tidy.speedlm <- function(x, ...) {
  tidy.lm(x, ...)
}


#' @templateVar class speedlm
#' @template title_desc_glance
#'
#' @param x A `speedlm` object returned from [speedglm::speedlm()].
#' @template param_unused_dots
#' 
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{r.squared}{The percent of variance explained by the model}
#'   \item{adj.r.squared}{r.squared adjusted based on the degrees of freedom}
#'   \item{statistic}{F-statistic}
#'   \item{p.value}{p-value from the F test, describing whether the full
#'     regression is significant}
#'   \item{df}{Degrees of freedom used by the coefficients}
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'   \item{deviance}{deviance}
#'   \item{df.residual}{residual degrees of freedom}
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
#' @param x A `speedlm` object returned from [speedglm::speedlm()].
#' @template param_data
#' @template param_newdata
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] containing the original data and one additional
#'   column `.fitted`.
#'
#' @export
#' @family speedlm tidiers
#' @seealso [speedglm::speedlm()]
augment.speedlm <- function(x, data = model.frame(x), newdata = data, ...) {
  augment_columns(x, data, newdata)
}
