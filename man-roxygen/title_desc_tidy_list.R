#' @title Tidy a(n) <%= class %> object masquerading as list
#' 
#' @description Broom tidies a number of lists that are effectively S3
#'   objects without a class attribute. For example, [stats::optim()],
#'   [svd()][base::svd()] and [akima::interp()] produce consistent output, but 
#'   because they do not have a class attribute, they cannot be handled by S3 
#'   dispatch.
#' 
#'   These functions look at the elements of a list and determine if there is
#'   an appropriate tidying method to apply to the list. Those tidiers are
#'   themselves that are implemented as functions of the form `tidy_<function>`
#'   or `glance_<function>` and that are not exported (but they are documented!).
#' 
#'   If no appropriate tidying method is found, they throw an error.
#' 
#' @md
