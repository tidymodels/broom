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
#'   [tidy.rlm()].
#'
#' @inherit tidy.lmrob examples
#'
#' @export
#' @family robustbase tidiers
#' @rdname tidy.robustbase.glmrob
#' @seealso [robustbase::glmrob()]
tidy.glmrob <- function (x, conf.int = FALSE, conf.level = 0.95, ...) {
  ret <- coef(summary(x)) %>% 
    as_tibble(rownames = "term")
  names(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")

  if (conf.int) {
    ci <- stats::confint.default(x, level = conf.level) %>% 
      as_tibble()

    names(ci) <- c("conf.low", "conf.high")
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
#' @template param_type_predict
#' @template param_type_residuals
#' @template param_unused_dots
#'
#' @evalRd return_augment()
#' @details For tidiers for robust models from the \pkg{MASS} package see
#'   [tidy.rlm()].
#'
#' @export
#' @family robustbase tidiers
#' @rdname augment.robustbase.glmrob
#' @seealso [robustbase::glmrob()]
augment.glmrob <- function(x, data = model.frame(x), newdata = NULL,
                           type.predict = c("link", "response"),
                           type.residuals = c("deviance", "pearson"),
                           se_fit = FALSE, ...) {
  augment_newdata(
    x, data, newdata,
    type.predict = type.predict,
    type.residuals = type.residuals,
    .se_fit = se_fit
  )
}

