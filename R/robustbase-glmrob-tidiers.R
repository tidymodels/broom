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
  conf.int <- list(...)$conf.int
  
  if (!is.null(conf.int) && conf.int) {
    level <- list(...)$level
    level <- ifelse(is.null(level), 0.95, level)
    ci <- stats::confint.default(x, level = level) %>% 
      as_tibble(rownames = NA) 
    names(ci) <- c("conf.low", "conf.high")
    ci$term <- rownames(ci)
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
#' 
#' @details For tidiers for robustbase models from the \pkg{MASS} package see
#'   [tidy.rlm()].
#'
#' @export
#' @family robustbase tidiers
#' @rdname augment.robustbase.glmrob
#' @seealso [robustbase::glmrob()]
#' @include stats-lm-tidiers.R
augment.glmrob <- function(x, data = model.frame(x), newdata = NULL, ...) {
  augment_newdata(x, data, newdata, .se_fit = FALSE, ...)
}

#' @templateVar class glmrob
#' @template title_desc_glance
#' 
#' @inherit tidy.glmrob params examples
#' @template param_unused_dots
#' 
#' @evalRd return_glance(
#'   "deviance",
#'   "null.deviance",
#'   "df.residual"
#' )
#' 
#' @export
#' @rdname glance.robustbase.glmrob
#' @family robustbase tidiers
#' @seealso [robustbase::glmrob()]
glance.glmrob <- function(x, ...) {
  ret <- tibble(
    deviance = x$deviance,
    null.deviance = x$null.deviance
  )
  finish_glance(ret, x)
}
