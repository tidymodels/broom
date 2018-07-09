#' @templateVar class glm
#' @template title_desc_tidy_lm_wrapper
#'
#' @param x A `glm` object returned from [stats::glm()].
#'
#' @export
#' @family lm tidiers
#' @seealso [stats::glm()]
tidy.glm <- function(x, ...) {
  NextMethod()
}

#' @templateVar class glm
#' @template title_desc_augment_lm_wrapper
#'
#' @param x A `glm` object returned from [stats::glm()].
#'
#' @export
#' @family lm tidiers
#' @seealso [stats::glm()]
augment.glm <- function(x, ...) {
  NextMethod()
}

#' @templateVar class glm
#' @template title_desc_glance
#' 
#'
#' @param x A `glm` object returned from [stats::glm()].
#' @template param_unused_dots
#'
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{null.deviance}{the deviance of the null model}
#'   \item{df.null}{the residual degrees of freedom for the null model}
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'   \item{deviance}{deviance}
#'   \item{df.residual}{residual degrees of freedom}
#'
#' @examples
#'
#' g <- glm(am ~ mpg, mtcars, family = "binomial")
#' glance(g)
#'
#' @export
#' @family lm tidiers
#' @seealso [stats::glm()]
glance.glm <- function(x, ...) {
  s <- summary(x)
  ret <- unrowname(as.data.frame(s[c("null.deviance", "df.null")]))
  finish_glance(ret, x)
}
