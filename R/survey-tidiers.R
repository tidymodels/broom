#' @templateVar class svyglm
#' @template title_desc_tidy_lm_wrapper
#'
#' @param x A `svyglm` object returned from [survey::svyglm()].
#'
#' @export
#' @family lm tidiers
#' @seealso [survey::svyglm()], [stats::glm()]
tidy.svyglm <- tidy.lm # since tidy.glm is itself a copy of tidy.lm

#' @templateVar class svyglm
#' @template title_desc_glance
#'
#' @param x A `svyglm` object returned from [survey::svyglm()].
#' @template param_unused_dots
#'
#' @evalRd return_glance(
#'   "null.deviance",
#'   "df.null",
#'   "logLik",
#'   "AIC",
#'   "deviance",
#'   "df.residual"
#' )
#'
#' @examples
#'
#' library(survey)
#' 
#' set.seed(123)
#' data(api)
#' 
#' # survey design
#' dstrat <-
#'   svydesign(
#'     id =  ~ 1,
#'     strata =  ~ stype,
#'     weights =  ~ pw,
#'     data = apistrat,
#'     fpc =  ~ fpc
#'   )
#' 
#' # model
#' m <- survey::svyglm(
#'   formula = sch.wide ~ ell + meals + mobility,
#'   design = dstrat,
#'   family = quasibinomial()
#' )
#' 
#' glance(m)
#'
#' @export
#' @family lm tidiers
#' @seealso [survey::svyglm()], [stats::glm()]
glance.svyglm <- function(x, ...) {
  s <- survey:::summary.svyglm(x)
  ret <- unrowname(as.data.frame(s[c("null.deviance", "df.null")]))
  finish_glance(ret, x)
}

#' @rdname ordinal_tidiers
#' @export
tidy.svyolr <- tidy.polr

#' @rdname ordinal_tidiers
#' @export
glance.svyolr <- glance.clm

