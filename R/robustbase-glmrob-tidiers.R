#' @templateVar class glmrob
#' @template title_desc_tidy_lm_wrapper
#'
#' @param x A `glmrob` object returned from [robustbase::glmrob()].
#' 
#' @details For tidiers for robustbase models from the \pkg{MASS} package see
#'   [tidy.rlm()].
#'
#' @inherit tidy.lmrob examples
#'
#' @export
#' @family robustbase tidiers
#' @rdname tidy.robustbase.glmrob
#' @seealso [robustbase::glmrob()]
#' @include stats-lm-tidiers.R
tidy.glmrob <- function (x, ...) {
  dots <- rlang::enquos(...)
  dots$conf.int <- FALSE
  
  ret <- rlang::exec(tidy.lm, x, !!!dots)
  
  # tidy.glmrob(..., conf.int = TRUE) throws an error, 
  # so calc conf.int separately if requested
  conf.int <- rlang::`%||%`(rlang::dots_list(...)$conf.int, FALSE)
  
  if (conf.int) {
    level <- rlang::`%||%`(rlang::dots_list(...)$level, 0.95)
    ci <- stats::confint.default(x, level = level) %>% 
      as_tibble(rownames = NA)  %>% 
      tibble::rownames_to_column(var = 'term')
    names(ci)[2:3] <- c("conf.low", "conf.high")

    ret <- ret %>% 
      left_join(ci, by = 'term')
  }
  
  ret
}


#' @templateVar class glmrob
#' @template title_desc_augment
#' 
#' @inherit tidy.glmrob params 
#' @template param_data
#' @template param_newdata
#' @param se_fit a switch indicating if standard errors are required.
#' 
#' @details For tidiers for robustbase models from the \pkg{MASS} package see
#'   [tidy.rlm()].
#'
#' @export
#' @family robustbase tidiers
#' @rdname augment.robustbase.glmrob
#' @seealso [robustbase::glmrob()]
#' @include stats-lm-tidiers.R
augment.glmrob <- function(x, data = model.frame(x), newdata = NULL, se_fit = FALSE, ...) {
  augment_newdata(x, data, newdata, .se_fit = se_fit, ...)
}

#' @templateVar class glmrob
#' @template title_desc_glance
#' @template param_unused_dots
#' 
#' @param x Unused.
#' @param ... Unused.
#' 
#' @description `glance.glmrob()` has not yet been implemented in broom. The
#'   \pkg{robustbase} package does not provide the functionality necessary to
#'   implement a glance method.
#'
#' @export
#' @rdname glance.robustbase.glmrob
#' @family robustbase tidiers
#' @seealso [robustbase::glmrob()]
glance.glmrob <- function(x, ...) {
  stop(
    "`glance.glmrob()` has not yet been implemented. See the documentation.",
    call. = FALSE
  )
}
