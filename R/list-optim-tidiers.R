#' @templateVar class optim
#' @template title_desc_tidy_list
#'
#' @param x A list returned from [stats::optim()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "parameter", 
#'   "value", 
#'   "std.error",
#'   .post = "\\code{std.error} is only provided as a column if the Hessian is calculated."
#' )
#'
#' @examples
#'
#' f <- function(x) (x[1] - 2)^2 + (x[2] - 3)^2 + (x[3] - 8)^2
#' o <- optim(c(1, 1, 1), f)
#'
#' tidy(o)
#' glance(o)
#'
#' @aliases optim_tidiers tidy.optim
#' @family list tidiers
#' @seealso [tidy()], [stats::optim()]
tidy_optim <- function(x, ...) {
  if (is.null(names(x$par))) {
    names(x$par) <- paste0("parameter", seq_along(x$par))
  }
  ret <- tibble(parameter = names(x$par), value = unname(x$par))
  if ("hessian" %in% names(x)) {
    ret$std.error <- sqrt(diag(solve(x$hessian)))
  }
  ret
}

#' @templateVar class optim
#' @template title_desc_tidy_list
#'
#' @inherit tidy_optim params examples
#'
#' @evalRd return_glance(
#'   "value",
#'   "function.count",
#'   "gradient.count",
#'   "convergence"
#' )
#'
#' @aliases glance.optim
#' @family list tidiers
#' @seealso [glance()], [optim()]
glance_optim <- function(x, ...) {
  tibble(
    value = x$value,
    function.count = x$counts["function"],
    gradient.count = x$counts["gradient"],
    convergence = x$convergence
  )
}
