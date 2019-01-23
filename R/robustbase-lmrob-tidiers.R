#' @templateVar class lmrob
#' @template title_desc_tidy_lm_wrapper
#'
#' @param x A `lmrob` object returned from [robustbase::lmrob()].
#' 
#' @details For tidiers for robust models from the \pkg{MASS} package see
#'   [tidy.rlm()]. For tidiers for robust models from the \pkg{robust} package
#'   see [tidy.lmRob()].
#' 
#' @examples
#'
#' # From the robustbase::lmrob examples:
#' data(coleman)
#' set.seed(0)
#' 
#' m <- robustbase::lmrob(Y ~ ., data=coleman)
#' tidy(m)
#' augment(m)
#' glance(m)
#'
#' TODO: glm
#' # From the robustbase::glmrob examples:
#' data(carrots)
#' Rfit <- glmrob(cbind(success, total-success) ~ logdose + block,
#'                 family = binomial, data = carrots, method= "Mqle",
#'                 control= glmrobMqle.control(tcc=1.2))
#' tidy(Rfit)
#'
#' @aliases robustbase_tidiers
#' @export
#' @family robustbase tidiers
#' @rdname tidy.robustbase.lmrob
#' @seealso [robustbase::lmrob()]
#' @include stats-lm-tidiers.R
tidy.lmrob <- function (x, ...) {
  dots <- enquos(...)
  dots$conf.int <- FALSE
  
  rlang::exec(tidy.lm, x, !!!dots)
}

#' @templateVar class lmrob
#' @template title_desc_augment
#'
#' @inherit tidy.lmrob params examples
#' @template param_data
#' @template param_newdata
#' 
#' @details For tidiers for robust models from the \pkg{MASS} package see
#'   [tidy.rlm()]. For tidiers for robust models from the \pkg{robust} package
#'   see [tidy.lmRob()].
#' 
#' @export
#' @rdname augment.robustbase.lmrob
#' @family robustbase tidiers
#' @seealso [robustbase::lmrob()]
augment.lmrob <- function(x, data = model.frame(x), newdata = NULL, ...) {
  
  # NOTES on predict.lmRob:
  #   - there's no na.action = na.pass argument
  #   - predict(x, single_row_df_with_missing_data) returns numeric(0)
  
  # passed_newdata <- !is.null(newdata)
  # df <- if (passed_newdata) newdata else data
  # df <- as_broom_tibble(df)
  # 
  # # this is a really ugly way to recover NA predictions
  # rows <- split(df, 1:nrow(df))
  # preds <- purrr::map(rows, ~predict(x, newdata = .x))
  # no_pred <- purrr::map_lgl(preds, ~length(.x) == 0)
  # preds[no_pred] <- NA
  # 
  # df$.fitted <- as.numeric(preds)
  # 
  # resp <- safe_response(x, df)
  # if (!is.null(resp))
  #   df$.resid <- df$.fitted - resp
  # df
  augment_newdata(x, data, newdata, .se_fit = FALSE)
}

#' @templateVar class lmrob
#' @template title_desc_glance
#' 
#' @inherit tidy.lmrob params examples
#' @template param_unused_dots
#' 
#' @details For tidiers for robust models from the \pkg{MASS} package see
#'   [tidy.rlm()]. For tidiers for robust models from the \pkg{robust} package
#'   see [tidy.lmRob()].
#'
#' @evalRd return_glance(
#'   "r.squared",
#'   "deviance",
#'   "sigma",
#'   "df.residual"
#' )
#' 
#' @export
#' @family robustbase tidiers
#' @rdname glance.robustbase.lmrob
#' @seealso [robustbase::lmrob()]
glance.lmrob <- function(x, ...) {
  s <- summary(x)
  tibble(
    r.squared = x$r.squared,
    deviance = x$dev,
    sigma = s$sigma,
    df.residual = x$df.residual
  )
}
