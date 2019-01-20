#' @templateVar class lmRob
#' @template title_desc_tidy_lm_wrapper
#'
#' @param x A `lmRob` object returned from [robust::lmRob()].
#' 
#' @details For tidiers for robust models from the \pkg{MASS} package see
#'   [tidy.rlm()].
#'
#' @examples
#'
#' library(robust)
#' m <- lmRob(mpg ~ wt, data = mtcars)
#'
#' tidy(m)
#' augment(m)
#' glance(m)
#'
#' gm <- glmRob(am ~ wt, data = mtcars, family = "binomial")
#' glance(gm)
#'
#' @aliases robust_tidiers
#' @export
#' @family robust tidiers
#' @seealso [robust::lmRob()]
#' @include stats-lm-tidiers.R
tidy.lmRob <- function (x, ...) {
  dots <- enquos(...)
  dots$conf.int <- FALSE
  
  rlang::exec(tidy.lm, x, !!!dots)
}

#' @templateVar class lmRob
#' @template title_desc_augment
#'
#' @inherit tidy.lmRob params examples
#' @template param_data
#' @template param_newdata
#' 
#' @details For tidiers for robust models from the \pkg{MASS} package see
#'   [tidy.rlm()].
#'
#' @export
#' @family robust tidiers
#' @seealso [robust::lmRob()]
augment.lmRob <- function(x, data = model.frame(x), newdata = NULL, ...) {
  
  # NOTES on predict.lmRob:
  #   - there's no na.action = na.pass argument
  #   - predict(x, newdata = NULL) gives an error (i.e. newdata either must
  #     be a dataset or missing)
  #   - predict(x, single_row_df_with_missing_data) returns numeric(0)
  
  passed_newdata <- !is.null(newdata)
  df <- if (passed_newdata) newdata else data
  df <- as_broom_tibble(df)
  
  # this is a really ugly way to recover NA predictions
  rows <- split(df, 1:nrow(df))
  preds <- purrr::map(rows, ~predict(x, newdata = .x))
  no_pred <- purrr::map_lgl(preds, ~length(.x) == 0)
  preds[no_pred] <- NA
  
  df$.fitted <- as.numeric(preds)
  
  resp <- safe_response(x, df)
  if (!is.null(resp))
    df$.resid <- df$.fitted - resp
  df
}

#' @templateVar class lmRob
#' @template title_desc_glance
#' 
#' @inherit tidy.lmRob params examples
#' @template param_unused_dots
#' 
#' @evalRd return_glance(
#'   "r.squared",
#'   "deviance",
#'   "sigma",
#'   "df.residual"
#' )
#' 
#' @export
#' @family robust tidiers
#' @seealso [robust::lmRob()]
#' 
glance.lmRob <- function(x, ...) {
  s <- robust::summary.lmRob(x)
  tibble(
    r.squared = x$r.squared,
    deviance = x$dev,
    sigma = s$sigma,
    df.residual = x$df.residual
  )
}
