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
#' @param maximal A `svyglm` object corresponding to the maximal model against
#' which to compute the BIC: see Lumley and Scott (2015) for details. Defaults
#' to \code{x}, which is equivalent to not using a maximal model.
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
#' @references Lumley T, Scott A (2015). AIC and BIC for modelling with complex 
#' survey data. *Journal of Survey Statistics and Methodology*, 3(1).
#' <https://doi.org/10.1093/jssam/smu021>.
#' 
#' @export
#' @family lm tidiers
#' @seealso [survey::svyglm()], [stats::glm()]
glance.svyglm <- function(x, maximal = x, ...) {
  
  s <- survey:::summary.svyglm(x)
  ret <- unrowname(as.data.frame(s[c("null.deviance", "df.null")]))
  
  # log-likelihood does not apply
  #
  # > ret$logLik <- tryCatch(as.numeric(stats::logLik(x)), error = function(e) NULL)
  # Warning in logLik.svyglm(x) : svyglm not fitted by maximum likelihood.
  
  # AIC
  #
  ret$AIC <- tryCatch(survey:::AIC.svyglm(mod)["AIC"], error = function(e) NULL)
  
  # BIC
  #
  ret$BIC <- tryCatch(stats::BIC(x, maximal = maximal)[2], error = function(e) NULL)
  
  # deviance
  #
  ret$deviance <- tryCatch(stats::deviance(x), error = function(e) NULL)
  
  # df.residual
  #
  ret$df.residual <- tryCatch(df.residual(x), error = function(e) NULL)
  
  as_tibble(ret, rownames = NULL)
  
}

#' @rdname ordinal_tidiers
#' @export
tidy.svyolr <- tidy.polr

#' @rdname ordinal_tidiers
#' @export
glance.svyolr <- glance.clm

