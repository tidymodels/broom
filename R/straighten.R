#' @name straighten
#' @title Tidy or Glance Multiple Model Objects
#' 
#' @description Tidy multiple models and return the results in a single
#'   data frame.
#'   
#' @param ... Model objects. Any unnamed arguments will be identified in 
#'   the result by the object name.
#' @param fn One of \code{tidy}, \code{glance}, or \code{augment}.
#' 
#' @details Applies \code{fn} to each model and stacks the resulting 
#'   data frames. It is not required that models have the same class, 
#'   however, there is no guarantee that models of different classes 
#'   will produce similar columns.
#'   
#' @return Returns a data frame. The first column, \code{model}, designates
#'   the model
#'   
#' @examples 
#' 
#' fit1 <- lm(mpg ~ wt + disp, data = mtcars)
#' fit2 <- lm(mpg ~ wt + disp + factor(gear), data = mtcars)
#' 
#' straighten(fit1, fit2)
#' straighten(fit1, fit2, fn = glance)
#' straighten(fit1, fit2, fn = augment)
#' 
#' @export

straighten <- function(..., fn = tidy){
  match.arg(arg = as.character(substitute(fn)), 
            choices = c("tidy", "glance", "augment"))
    
  fit_list <- list(...)
  if (is.null(names(fit_list))) names(fit_list) <- character(length(fit_list))
    
  # If a fit isn't named, use the object name
  dots <- match.call(expand.dots = FALSE)$...
  obj_nms <- vapply(dots, deparse, character(1))
  names(fit_list)[names(fit_list) == ""] <- obj_nms[names(fit_list) == ""]
  
  res <- purrr::map2(.x = fits,
                     .y = names(fits),
                     .f = function(x, n){
                         data.frame(model = n, 
                                    fn(x),
                                    stringsAsFactors = FALSE)
                     })
  dplyr::bind_rows(res)
}
