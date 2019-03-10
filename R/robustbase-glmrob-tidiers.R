#' @templateVar class glmrob
#' @template title_desc_tidy
#'
#' @param x A `glmrob` object returned from [robustbase::glmrob()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @details For tidiers for robust models from the \pkg{MASS} package see
#'   [tidy.rlm()]. For tidiers for robust models from the \pkg{robust} package
#'   see [tidy.lmRob()].
#'
#' @inherit tidy.lmrob examples
#'
#' @export
#' @family robustbase tidiers
#' @rdname tidy.robustbase.glmrob
#' @seealso [robustbase::glmrob()]
tidy.glmrob <- function (x, conf.int = FALSE, conf.level = 0.95, ...) {
  ret <- coef(summary(x)) %>% 
    tibble::as_tibble(rownames = "term")
  names(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")

  if (conf.int) {
    ci <- stats::confint.default(x, level = conf.level) %>% 
      tibble::as_tibble(rownames = NULL) %>% 
      dplyr::rename(
        conf.low = `2.5 %`
        ,conf.high = `97.5 %`
      )
    ret <- ret %>% 
      cbind(ci)
  }
  
  ret
}


#' @templateVar class glmrob
#' @template title_desc_augment
#' 
#' @inherit tidy.glmrob params 
#' @template param_data
#' @template param_newdata
#' @template param_se_fit
#' @template param_unused_dots
#'
#' @details For tidiers for robust models from the \pkg{MASS} package see
#'   [tidy.rlm()]. For tidiers for robust models from the \pkg{robust} package
#'   see [tidy.lmRob()].
#'
#' @export
#' @family robustbase tidiers
#' @rdname augment.robustbase.glmrob
#' @seealso [robustbase::glmrob()]
augment.glmrob <- function(x, data = model.frame(x), newdata = NULL,
                           type.predict = c("link", "response"),
                           type.residuals = c("deviance", "pearson"),
                           se_fit = FALSE, ...) {
  # TODO: add "terms" back into the possibilities for `type.predict`. Currently,
  # predict.glmrob(x, type = "terms") throws an error and specifying `type.predict`
  # = "terms" returns the same tibble as when `type.predict` = "response"
  augment_newdata(
    x, data, newdata,
    type.predict = type.predict,
    type.residuals = type.residuals,
    .se_fit = se_fit
  )
}

#' @templateVar class glmrob
#' @template title_desc_glance
#' @template param_unused_dots
#' 
#' @param x Unused.
#' @param ... Unused.
#' 
#' @details For tidiers for robust models from the \pkg{MASS} package see
#'   [tidy.rlm()]. For tidiers for robust models from the \pkg{robust} package
#'   see [tidy.lmRob()].

#' @description `glance.glmrob()` has not yet been implemented in broom. The
#'   \pkg{robustbase} package does not provide the functionality necessary to
#'   implement a glance method.
#'
#' @rdname glance.robustbase.glmrob
#' @family robustbase tidiers
#' @seealso [robustbase::glmrob()]
glance.glmrob <- function(x, ...) {
  stop(
    "`glance.glmrob` has not yet been implemented. See the documentation.",
    call. = FALSE
  )
}
