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
#'   users can simply can the underlying model to  obtain the same information.
#'
#' @examples
#' library(margins)
#'
#' mod_log <- glm(am ~ cyl + hp + wt, data = mtcars, family = binomial)
#' marg_log <- margins(mod_log)
#'
#' tidy(marg_log)
#' tidy(marg_log, conf.int = TRUE)
#' glance(marg_log) ## Requires running the underlying model again. Quick for this example.
#' # augment(marg_log) ## Not supported.
#' augment(mod_log) ## But can get the same info by running on the underlying model.
#'
#' ## Threeway interaction effect example
#' mod_ie <- lm(mpg ~ wt * cyl * disp, data = mtcars)
#' 
#' marg_ie0 <- margins(mod_ie)
#' tidy(marg_ie0)
#' glance(marg_ie0)
#' 
#' marg_ie1 <- margins(mod_ie, variable = "wt")
#' tidy(marg_ie1)
#' 
#' ## Marginal effect of one interaction variable, modulated at specific values
#' ## of another interaction variable
#' marg_ie2 <- margins(mod_ie, at = list(cyl = c(4,6,8)))
#' tidy(marg_ie2)
#' 
#' ## As above, but this time modulated at specific values of two other 
#' ## interaction variables
#' marg_ie3 <- margins(mod_ie,
#'                     variables = "wt", ## Main var
#'                     at = list(cyl = c(4,6,8), drat = c(3, 3.5, 4))) ## Modulating vars
#' tidy(marg_ie3)
#' @export
#' @aliases margins_tidiers
#' @family margins tidiers
#' @seealso [tidy()], [margins::margins()]
tidy.margins <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
  
    ret <- as_tibble(summary(x, level = conf.level))
    
    ## IF statement for tidying any "at" variables.
    if (TRUE %in% grepl("at", names(attributes(x)))) {
      at_vars <- setdiff(names(attributes(x)$at), "index")
      std_cols <- c("factor", "AME", "SE", "z", "p", "lower", "upper")
      ret <-
        ret %>%
        {
          tryCatch(
            tidyr::pivot_longer(., at_vars, names_to = "at.variable", values_to = "at.value"),
            error = function(e) {
              mutate_at(
                ., setdiff(colnames(x_summ), std_cols), as.character,
                message("Warning: Mismatched types; `at.value` column coerced to character.")
                ) %>%
                tidyr::pivot_longer(at_vars, names_to = "at.variable", values_to = "at.value")
              }
            )
          }
      
    }
    ## End of IF statement for tidying any "at" variables.
    
    ## Rename and reorder variables
    ret <-
      ret %>%
      dplyr::select(
        term = factor, 
        contains("at."), 
        estimate = AME, 
        std.error = SE, 
        statistic = z, 
        p.value = p, 
        conf.low = lower, 
        conf.high = upper
        )
    
    ## Remove confidence interval if not specified
    if(!conf.int) {
      ret <- dplyr::select(ret, -c(conf.low, conf.high))
    }
    
    ## Return tidied tibble object
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
