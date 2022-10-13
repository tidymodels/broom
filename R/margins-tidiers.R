#' @templateVar class margins
#' @template title_desc_tidy
#'
#' @param x A `margins` object returned from [margins::margins()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#' 
#' @details The `margins` package provides a way to obtain coefficient marginal 
#'   effects for a variety of (non-linear) models, such as logit or models with
#'   multiway interaction terms. Note that the `glance.margins()` method
#'   requires rerunning the underlying model again, which can take some time. 
#'   Similarly, an `augment.margins()` method is not currently supported, but
#'   users can simply run the underlying model to obtain the same information.
#'
#' @examplesIf rlang::is_installed("margins")
#' 
#' # load libraries for models and data
#' library(margins)
#' 
#' # example 1: logit model 
#' mod_log <- glm(am ~ cyl + hp + wt, data = mtcars, family = binomial)
#' 
#' # get tidied "naive" model coefficients
#' tidy(mod_log)
#' 
#' # convert to marginal effects with margins()
#' marg_log <- margins(mod_log)
#' 
#' # get tidied marginal effects
#' tidy(marg_log)
#' tidy(marg_log, conf.int = TRUE)
#' 
#' # requires running the underlying model again. quick for this example
#' glance(marg_log) 
#' 
#' # augmenting `margins` outputs isn't supported, but
#' # you can get the same info by running on the underlying model
#' augment(mod_log) 
#'
#' # example 2: threeway interaction terms
#' mod_ie <- lm(mpg ~ wt * cyl * disp, data = mtcars)
#' 
#' # get tidied "naive" model coefficients
#' tidy(mod_ie)
#' 
#' # convert to marginal effects with margins()
#' marg_ie0 <- margins(mod_ie)

#' # get tidied marginal effects 
#' tidy(marg_ie0)
#' glance(marg_ie0)
#' 
#' # marginal effects evaluated at specific values of a variable (here: cyl)
#' marg_ie1 <- margins(mod_ie, at = list(cyl = c(4,6,8)))
#' 
#' # summarize model fit with tidiers
#' tidy(marg_ie1)
#' 
#' # marginal effects of one interaction variable (here: wt), modulated at 
#' # specific values of the two other interaction variables (here: cyl and drat)
#' marg_ie2 <- margins(mod_ie,
#'                     variables = "wt",
#'                     at = list(cyl = c(4,6,8), drat = c(3, 3.5, 4)))
#' 
#' # summarize model fit with tidiers
#' tidy(marg_ie2)
#' 
#' @export
#' @aliases margins_tidiers
#' @family margins tidiers
#' @seealso [tidy()], [margins::margins()]
tidy.margins <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
    check_ellipses("exponentiate", "tidy", "margins", ...)
  
    ret <- as_tibble(summary(x, level = conf.level))
    
    # IF statement for tidying any "at" variables.
    if ("at" %in% names(attributes(x))) {
      at_vars <- setdiff(names(attributes(x)$at), "index")
      std_cols <- c("factor", "AME", "SE", "z", "p", "lower", "upper")
      ret <-
        ret %>%
        {
          tryCatch(
            tidyr::pivot_longer(., dplyr::all_of(at_vars), names_to = "at.variable", values_to = "at.value"),
            error = function(e) {
              mutate(
                ., dplyr::across(dplyr::all_of(at_vars), as.character),
                message("Warning: `at.value` column coerced to character.")
                ) %>%
                tidyr::pivot_longer(dplyr::all_of(at_vars), names_to = "at.variable", values_to = "at.value")
              }
            )
          }
      
    }
    # End of IF statement for tidying any "at" variables.
    
    # Rename and reorder variables
    ret <-
      ret %>%
      dplyr::select(
        term = factor, 
        dplyr::contains("at."), 
        estimate = AME, 
        std.error = SE, 
        statistic = z, 
        p.value = p, 
        conf.low = lower, 
        conf.high = upper
        )
    
    # Remove confidence interval if not specified
    if(!conf.int) {
      ret <- dplyr::select(ret, -c(conf.low, conf.high))
    }
    
    # Return tidied tibble object
    return(ret)
}

#' @templateVar class margins
#' @template title_desc_glance
#'
#' @inherit tidy.margins params examples
#'
#' @evalRd return_glance(
#'   "r.squared",
#'   "adj.r.squared",
#'   "sigma",
#'   "statistic",
#'   "p.value",
#'   "df",
#'   "df.residual",
#'   "nobs"
#' )
#'
#' @export
glance.margins <- function(x, ...) {
  orig_mod_call <- attributes(x)$call
  ret <- broom::glance(eval(orig_mod_call), ...)
  return(ret)
}

#' @include null-and-default-tidiers.R
#' @export
augment.margins <- augment.default
