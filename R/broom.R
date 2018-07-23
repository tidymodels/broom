#' @title Convert Statistical Objects into Tidy Tibbles
#' @name broom
#' @description Convert statistical analysis objects from R into tidy tibbles,
#'   so that they can more easily be combined, reshaped and otherwise processed
#'   with tools like dplyr, tidyr and ggplot2. The package provides three S3
#'   generics: tidy, which summarizes a model's statistical findings such as
#'   coefficients of a regression; augment, which adds columns to the original
#'   data such as predictions, residuals and cluster assignments; and glance,
#'   which provides a one-row summary of model-level statistics.
#'
#' @importFrom stats AIC BIC coef confint fitted logLik model.frame 
#' @importFrom stats predict qnorm qt residuals setNames var na.omit
#' @importFrom stats model.response
#' 
#' @importFrom purrr map_df set_names
#' @importFrom tibble tibble as_tibble
#' 
#' @import dplyr
#'
#' @importFrom utils head
#'
#' @docType package
#' @aliases broom broom-package
NULL

#' @templateVar class statistical
#' @template title_desc_augment
#'
#' @param x Model object or other R object with information to append to
#'   observations.
#' @template param_data
#' @param ... Addition arguments to augment method.
#' 
#' @return A [tibble::tibble()] with information about data points.
#' 
#' @importFrom modelgenerics augment
#' @export
modelgenerics::augment

#' @templateVar class statistical
#' @template title_desc_tidy
#'
#' @param x An object to be converted into a tidy [tibble::tibble()].
#' @param ... Additional arguments to tidying method.
#' 
#' @return A [tibble::tibble()] with information about model components.
#'
#' @importFrom modelgenerics tidy
#' @export
modelgenerics::tidy

#' @templateVar class statistical
#' @template title_desc_glance
#'
#' @param x model or other R object to convert to single-row data frame
#' @param ... other arguments passed to methods
#' 
#' @importFrom modelgenerics glance
#' @export
modelgenerics::glance



