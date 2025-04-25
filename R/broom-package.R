# Custom package description for the package help file.
#' @name broom
#' @description
#' Convert statistical analysis objects from R into tidy tibbles,
#' so that they can more easily be combined, reshaped and otherwise processed
#' with tools like dplyr, tidyr and ggplot2. The package provides three S3
#' generics: tidy, which summarizes a model's statistical findings such as
#' coefficients of a regression; augment, which adds columns to the original
#' data such as predictions, residuals and cluster assignments; and glance,
#' which provides a one-row summary of model-level statistics.
#'
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom stats AIC BIC coef confint fitted logLik model.frame
#' @importFrom stats pnorm qnorm qt predict residuals setNames var
#' @importFrom stats quantile model.response terms na.pass na.omit
#' @importFrom stats influence rstandard cooks.distance nobs
#' @importFrom purrr map_df set_names possibly
#' @importFrom tibble tibble as_tibble
#' @importFrom tidyr pivot_longer pivot_wider
#'
#' @import rlang
#'
#' @importFrom utils head
#' @importFrom glue glue
#'
#' @import dplyr
## usethis namespace: end
NULL
