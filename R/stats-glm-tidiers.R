#' @templateVar class glm
#' @template title_desc_tidy
#'
#' @param x A `glm` object returned from [stats::glm()].
#' @template param_confint
#' @template param_exponentiate
#' @template param_unused_dots
#'
#' @export
#' @family lm tidiers
#' @seealso [stats::glm()]
tidy.glm <- function(x, conf.int = FALSE, conf.level = .95, 
                     exponentiate = FALSE, ...) {
  
  ret <- as_tibble(summary(x)$coefficients, rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")
  
  # summary(x)$coefficients misses rank deficient rows (i.e. coefs that
  # summary.lm() sets to NA), catch them here and add them back
  
  coefs <- tibble::enframe(stats::coef(x), name = "term", value = "estimate")
  ret <- left_join(coefs, ret, by = c("term", "estimate"))
  
  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }
  
  if (exponentiate)
    ret <- exponentiate(ret)
  
  ret
}

#' @templateVar class glm
#' @template title_desc_augment
#'
#' @param x A `glm` object returned from [stats::glm()].
#' @template param_data
#' @template param_newdata
#' @param type.predict Passed to [stats::predict.glm()] `type`
#'   argument. Defaults to `"link"`.
#' @param type.residuals Passed to [stats::residuals.glm()] and
#'   to [stats::rstandard.glm()] `type` arguments. Defaults to `"deviance"`.
#' @template param_se_fit
#' @template param_unused_dots
#' 
#' @evalRd return_augment(
#'   ".se.fit",
#'   ".hat",
#'   ".sigma",
#'   ".std.resid",
#'   ".cooksd"
#' )
#'
#' @details If the weights for any of the observations in the model
#'   are 0, then columns ".infl" and ".hat" in the result will be 0
#'   for those observations.
#'   
#'   A `.resid` column is not calculated when data is specified via
#'   the `newdata` argument.
#'
#' @export
#' @family lm tidiers
#' @seealso [stats::glm()]
#' @include stats-lm-tidiers.R
augment.glm <- function(x, 
  data = model.frame(x),
  newdata = NULL,
  type.predict = c("link", "response", "terms"),
  type.residuals = c("deviance", "pearson"),
  se_fit = FALSE, ...) {
  
  type.predict <- rlang::arg_match(type.predict)
  type.residuals <- rlang::arg_match(type.residuals)
  
  df <- if (is.null(newdata)) data else newdata
  df <- as_broom_tibble(df)
  
  # don't use augment_newdata here; don't want raw/response residuals in .resid
  if (se_fit) {
    pred_obj <- predict(x, newdata, type = type.predict, se.fit = TRUE)
    df$.fitted <- pred_obj$fit
    df$.se.fit <- pred_obj$se.fit
  } else {
    df$.fitted <- predict(x, newdata, type = type.predict)
  }
  
  if (is.null(newdata)) {
    
    tryCatch({
      infl <- influence(x, do.coef = FALSE)
      df$.resid <- residuals(x, type = type.residuals)
      df$.std.resid <- rstandard(x, infl = infl, type = type.residuals)
      df <- add_hat_sigma_cols(df, x, infl)
      df$.cooksd <- cooks.distance(x, infl = infl)
    }, error = data_error)
  }
  
  df
}



#' @templateVar class glm
#' @template title_desc_glance
#'
#' @param x A `glm` object returned from [stats::glm()].
#' @template param_unused_dots
#'
#' @evalRd return_glance(
#'   "null.deviance",
#'   "df.null",
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "deviance",
#'   "df.residual",
#'   "nobs"
#' )
#'
#' @examples
#'
#' g <- glm(am ~ mpg, mtcars, family = "binomial")
#' glance(g)
#'
#' @export
#' @family lm tidiers
#' @seealso [stats::glm()]
glance.glm <- function(x, ...) {
  s <- summary(x)
  tibble(
    null.deviance = x$null.deviance,
    df.null = x$df.null,
    logLik = as.numeric(stats::logLik(x)),
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    deviance = stats::deviance(x),
    df.residual = stats::df.residual(x),
    nobs = stats::nobs(x)
  )
}
