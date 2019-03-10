#' @templateVar class svyglm
#' @template title_desc_tidy_lm_wrapper
#'
#' @param x A `svyglm` object returned from [survey::svyglm()].
#'
#' @export
#' @family lm tidiers
#' @seealso [survey::svyglm()], [stats::glm()]
# [NOTES]
# - partly copies tidy.glm, which itself copies tidy.lm
# - depends on process_lm, but that might change in the future
tidy.svyglm <- function(x, conf.int = FALSE, conf.level = .95,
                        exponentiate = FALSE, ...) {
  
  s <- survey:::summary.svyglm(x)
  ret <- tidy.summary.lm(s)
  
  process_lm(ret, x,
             conf.int = conf.int, conf.level = conf.level,
             exponentiate = exponentiate
  )
  
}

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
#'   "AIC",
#'   "BIC,
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
#' @seealso [survey::svyglm()], [stats::glm()], [survey::anova.svyglm]
glance.svyglm <- function(x, maximal = x, ...) {
  
  ret <- with(x, tibble::tibble(null.deviance, df.null))
  
  # log-likelihood does not apply (returns deviance instead)
  #
  # > ret$logLik <- tryCatch(as.numeric(stats::logLik(x)), error = function(e) NULL)
  # Warning in logLik.svyglm(x) : svyglm not fitted by maximum likelihood.
  
  # AIC
  #
  #   equivalent to stats::AIC(x)
  #   not always directly computed by svyglm, e.g. if family = quasibinomial()
  #
  ret$AIC <- survey:::AIC.svyglm(x)["AIC"]
  
  # BIC
  #
  #   equivalent to stats::BIC(x, maximal)
  #
  ret$BIC <- survey:::dBIC(x, maximal)["BIC"]
  
  # deviance
  #
  #   equivalent to stats::deviance(x)
  #
  ret$deviance <- x$deviance
  
  # df.residual
  #
  #   equivalent to stats::df.residual(x)
  #
  ret$df.residual <- x$df.residual
  
  ret
  
}

#' @rdname ordinal_tidiers
#' @export
tidy.svyolr <- tidy.polr

#' @rdname ordinal_tidiers
#' @export
glance.svyolr <- glance.clm

