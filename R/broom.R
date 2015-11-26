#' @title Convert Statistical Analysis Objects into Tidy Data Frames
#' @name broom
#' @description Convert statistical analysis objects from R into tidy data frames,
#' so that they can more easily be combined, reshaped and otherwise processed
#' with tools like dplyr, tidyr and ggplot2. The package provides three S3
#' generics: tidy, which summarizes a model's statistical findings such as
#' coefficients of a regression; augment, which adds columns to the original
#' data such as predictions, residuals and cluster assignments; and glance,
#' which provides a one-row summary of model-level statistics.
#' 
#' @importFrom stats AIC coef confint fitted logLik model.frame na.omit
#' @importFrom stats predict qnorm qt residuals setNames var
#' 
#' @importFrom utils head
#' 
#' @docType package
#' @aliases broom broom-package
NULL
