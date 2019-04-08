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

#' @importFrom generics augment
#' @export
#' @seealso [augment.lm()]
generics::augment

#' @importFrom generics tidy
#' @export
#' @seealso [tidy.lm()]
generics::tidy

#' @importFrom generics glance
#' @export
#' @seealso [glance.lm()]
generics::glance

