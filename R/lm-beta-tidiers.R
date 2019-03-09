#' @templateVar class lm.beta
#' @template title_desc_tidy
#' 
#' @param x An `lm.beta` object created by [lm.beta::lm.beta].
#' @template param_confint 
#' @template param_quick
#' @template param_exponentiate
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
#' 
#' # standardize
#' mod_standardized <- lm.beta::lm.beta(mod)
#' tidy(mod_standardized)
#'
#' ## Taken from lm/ lm.beta help
#' ##
#' ## Annette Dobson (1990) "An Introduction to Generalized Linear Models".
#' ## Page 9: Plant Weight Data.
#' ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
#' trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
#' group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
#' weight <- c(ctl, trt)
#' lm.D9 <- stats::lm(weight ~ group)
#' 
#' # standardize
#' lm.D9.beta <- lm.beta::lm.beta(lm.D9)
#' tidy(lm.D9.beta)
#'
#' @export
#' @family lm tidiers
tidy.lm.beta <- function (x, conf.int = FALSE, conf.level = 0.95,
                          exponentiate = FALSE, quick = FALSE, ...) {
  if (quick) {
    co <- stats::coef(x)
    ret <- data.frame(term = names(co), estimate = unname(co), 
                      stringsAsFactors = FALSE)
    return(process_lm(ret, x, conf.int = FALSE, exponentiate = exponentiate))
  }
  s <- summary(x)
  ret <- tidy.summary.lm.beta(s)
  process_lm(ret, x, conf.int = conf.int, conf.level = conf.level, 
             exponentiate = exponentiate)
}

#' @rdname tidy.lm.beta
#' @export
tidy.summary.lm.beta <- function (x, ...) {
  co <- stats::coef(x)
  nn <- c("estimate", "std_estimate", "std.error", "statistic", 
          "p.value")
  if (inherits(co, "listof")) {
    ret <- map_df(co, fix_data_frame, nn[1:ncol(co[[1]])], 
                  .id = "response")
    ret$response <- stringr::str_replace(ret$response, "Response ", 
                                         "")
  }
  else {
    ret <- fix_data_frame(co, nn[1:ncol(co)])
  }
  as_tibble(ret)
}

