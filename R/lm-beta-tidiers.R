#' @templateVar class lm.beta
#' @template title_desc_tidy
#'
#' @param x An `lm.beta` object created by [lm.beta::lm.beta].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @details If the linear model is an `mlm` object (multiple linear model),
#'   there is an additional column `response`.
#'
#'   If you have missing values in your model data, you may need to refit
#'   the model with `na.action = na.exclude`.
#'
#' @examples
#'
#' library(lm.beta)
#'
#' mod <- stats::lm(speed ~ ., data = cars)
#' std <- lm.beta(mod)
#' tidy(std, conf.int = TRUE)
#'
#' ctl <- c(4.17, 5.58, 5.18, 6.11, 4.50, 4.61, 5.17, 4.53, 5.33, 5.14)
#' trt <- c(4.81, 4.17, 4.41, 3.59, 5.87, 3.83, 6.03, 4.89, 4.32, 4.69)
#' group <- gl(2, 10, 20, labels = c("Ctl", "Trt"))
#' weight <- c(ctl, trt)
#' 
#' mod2 <- lm(weight ~ group)
#'
#' std2 <- lm.beta(mod2)
#' tidy(std2, conf.int = TRUE)
#' 
#' @export
#' @family lm tidiers
tidy.lm.beta <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
  
  ret <- as_tibble(summary(x)$coefficients, rownames = "term")
  colnames(ret) <- c("term", "estimate", "std_estimate",
                     "std.error", "statistic", "p.value")
  
  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }
  
  ret
}
