#' @templateVar class mlm
#' @template title_desc_tidy
#'
#' @param x An `mlm` object created by [stats::lm()] with a matrix as the
#'   response.
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @details In contrast to `lm` object (simple linear model), tidy output for
#'   `mlm` (multiple linear model) objects contain an additional column
#'   `response`.
#'
#'   If you have missing values in your model data, you may need to refit
#'   the model with `na.action = na.exclude`.
#'
#' @examples
#'
#' mod <- lm(cbind(mpg, disp) ~ wt, mtcars)
#' tidy(mod, conf.int = TRUE)
#' @importFrom dplyr bind_cols
#' @export
#' @seealso [tidy()]
#' @family lm tidiers
#' @export

tidy.mlm <- function(x,
                     conf.int = FALSE,
                     conf.level = .95,
                     ...) {

  # adding other details from summary object
  s <- summary(x)
  #ret <- tidy.summary.mlm(s)

  co <- stats::coef(s)
  nn <- c("estimate", "std.error", "statistic", "p.value")
  
  # multiple response variables
  ret <- purrr::map_df(co, fix_data_frame, nn[1:ncol(co[[1]])],
                       .id = "response"
  )
  ret$response <- stringr::str_replace(ret$response, "Response ", "")
  
  ret <- as_tibble(ret)
  
  # adding confidence intervals
  if (conf.int) {

    # S3 method for computing confidence intervals for `mlm` objects was
    # introduced in R 3.5
    CI <- tryCatch(
      expr = stats::confint(x, level = conf.level),
      error = function(x) {
        NULL
      }
    )

    # if R version is prior to 3.5, use the custom function
    if (is.null(CI)) {
      CI <- confint.mlm(x, level = conf.level)
    }

    colnames(CI) <- c("conf.low", "conf.high")
    ret <- bind_cols(ret, CI)
  }

  as_tibble(ret)
}

# mlm objects subclass lm objects so this gives a better error than
# letting augment.lm() fail
#' @include null-and-default-tidiers.R
augment.mlm <- augment.default

#' @export

glance.mlm <- glance.default

# compute confidence intervals for mlm object.
confint.mlm <- function(object, level = 0.95, ...) {
  cf <- coef(object)
  ncfs <- as.numeric(cf)
  a <- (1 - level) / 2
  a <- c(a, 1 - a)
  fac <- qt(a, object$df.residual)
  pct <- .format.perc(a, 3)
  ses <- sqrt(diag(stats::vcov(object)))
  ci <- ncfs + ses %o% fac
  setNames(data.frame(ci), pct)
}
