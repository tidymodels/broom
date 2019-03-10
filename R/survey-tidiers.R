#' @templateVar class svyglm
#' @template title_desc_tidy_lm_wrapper
#'
#' @param x A `svyglm` object returned from [survey::svyglm()].
#'
#' @export
#' @family lm tidiers
#' @seealso [survey::svyglm()], [stats::glm()]
# copied from tidy.glm, itself a copy of tidy.lm
tidy.svyglm <- function(x, conf.int = FALSE, conf.level = .95,
                        exponentiate = FALSE, quick = FALSE, ...) {
  if (quick) {
    co <- stats::coef(x)
    ret <- data.frame(term = names(co), estimate = unname(co),
                      stringsAsFactors = FALSE)
    return(process_lm(ret, x, conf.int = FALSE, exponentiate = exponentiate))
  }
  s <- summary(x)
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
  ret$AIC <- tryCatch(survey:::AIC.svyglm(x)["AIC"], error = function(e) NULL)
  
  # BIC
  #
  #   equivalent to stats::(x, maximal)
  #
  ret$BIC <- tryCatch(survey:::dBIC(x, maximal)["BIC"], error = function(e) NULL)
  
  # deviance
  #
  #   equivalent to stats::deviance(x)
  #
  ret$deviance <- tryCatch(x$deviance, error = function(e) NULL)
  
  # df.residual
  #
  #   equivalent to stats::df.residual(x)
  #
  ret$df.residual <- tryCatch(x$df.residual, error = function(e) NULL)
  
  ret
  
}

#' @rdname ordinal_tidiers
#' @export
tidy.svyolr <- tidy.polr

#' @rdname ordinal_tidiers
#' @export
glance.svyolr <- glance.clm

