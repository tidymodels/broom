#' @templateVar class biglm
#' @template title_desc_tidy
#'
#' @param x A `biglm` object created by a call to [biglm::biglm()] or 
#'   [biglm::bigglm()].
#' @template param_confint
#' @template param_exponentiate
#' @template param_quick
#' @template param_unused_dots
#' 
#' @evalRd return_tidy(regression = TRUE)
#'
#' @examples
#'
#' library(biglm)
#'
#' bfit <- biglm(mpg ~ wt + disp, mtcars)
#' tidy(bfit)
#' tidy(bfit, conf.int = TRUE)
#' tidy(bfit, conf.int = TRUE, conf.level = .9)
#'
#' glance(bfit)
#'
#' # bigglm: logistic regression
#' bgfit <- bigglm(am ~ mpg, mtcars, family = binomial())
#' tidy(bgfit)
#' tidy(bgfit, exponentiate = TRUE)
#' tidy(bgfit, conf.int = TRUE)
#' tidy(bgfit, conf.int = TRUE, conf.level = .9)
#' tidy(bgfit, conf.int = TRUE, conf.level = .9, exponentiate = TRUE)
#'
#' glance(bgfit)
#'
#' @export
#' @family biglm tidiers
#' @seealso [tidy()], [biglm::biglm()], [biglm::bigglm()]
tidy.biglm <- function(x, conf.int = FALSE, conf.level = .95,
                       exponentiate = FALSE, quick = FALSE, ...) {
  if (quick) {
    co <- stats::coef(x)
    ret <- tibble::enframe(co, name = "term", value = "estimate")
    return(ret)
  }
  
  mat <- summary(x)$mat
  nn <- c("estimate", "conf.low", "conf.high", "std.error", "p.value")
  ret <- fix_data_frame(mat, nn)
  
  # remove the 95% confidence interval and replace:
  # it isn't exactly 95% (uses 2 rather than 1.96), and doesn't allow
  # specification of confidence level in any case
  ret <- dplyr::select(ret, -conf.low, -conf.high)
  
  process_lm(ret, x,
             conf.int = conf.int, conf.level = conf.level,
             exponentiate = exponentiate
  )
}


#' @templateVar class biglm
#' @template title_desc_glance
#' 
#' @inherit tidy.biglm params examples
#' @template param_unused_dots
#' 
#' @evalRd return_glance("r.squared", 
#                        "AIC", 
#'                       "deviance", 
#'                       "df.residual",
#'                       "nobs")
#'
#' @export
#' @family biglm tidiers
#' @seealso [glance()], [biglm::biglm()], [biglm::bigglm()]
glance.biglm <- function(x, ...) {
  s <- summary(x)
  ret <- tibble(r.squared = s$rsq,
                AIC = stats::AIC(x),
                deviance = stats::deviance(x),
                df.residual = x$df.resid,
                nobs = stats::nobs(x))
  ret 
}
