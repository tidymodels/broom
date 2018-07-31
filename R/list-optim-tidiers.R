#' @templateVar class optim
#' @template title_desc_tidy_list
#'
#' @param x A list returned from [stats::optim()].
#' @template param_unused_dots
#'
#' @return A [tibble::tibble] with one row per parameter estimated by `optim`
#'   and columns:
#'   
#'   \item{parameter}{name of the parameter, or `parameter1`,
#'   `parameter2`... if the input vector is not named}
#'   \item{value}{parameter value that minimizes or maximizes the output}
#'
#' @examples
#'
#' func <- function(x) {
#'     (x[1] - 2)^2 + (x[2] - 3)^2 + (x[3] - 8)^2
#' }
#'
#' o <- optim(c(1, 1, 1), func)
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
  tibble(parameter = names(x$par), value = unname(x$par))
}


#' @templateVar class optim
#' @template title_desc_tidy_list
#'
#' @inheritParams tidy_optim
#'
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{value}{minimized or maximized output value}
#'   \item{function.count}{number of calls to `fn`}
#'   \item{gradient.count}{number of calls to `gr`}
#'   \item{convergence}{convergence code representing the error state}
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
