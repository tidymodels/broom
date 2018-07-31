#' @title Glance at a(n) <%= class %> object
#' 
#' @description Glance accepts a model object and returns a [tibble::tibble()]
#'   with exactly one row of model summaries. The summaries are typically
#'   goodness of fit measures, p-values for hypothesis tests on residuals,
#'   or model convergence information.
#'   
#'   Glance never returns information from the original call to the modelling
#'   function. This includes the name of the modelling function or any
#'   arguments passed to the modelling function.
#'   
#'   Glance does not calculate summary measures. Rather, it farms out these
#'   computations to appropriate methods and gathers the results together.
#'   Sometimes a goodness of fit measure will be undefined. In these cases 
#'   the measure will be reported as `NA`.
#'   
#' @md
