#' Tidiers for lists returned from optim
#' 
#' Tidies objects returned by the \code{\link{optim}} function for
#' general-purpose minimization and maximization.
#' 
#' @param x list returned from \code{optim}
#' @param ... extra arguments
#' 
#' @template boilerplate
#' 
#' @return \code{tidy} returns a data frame with one row per parameter that
#' was estimated, with columns
#'   \item{parameter}{name of the parameter, or \code{parameter1},
#'   \code{parameter2}... if the input vector is not named}
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
#' @name optim_tidiers
tidy_optim <- function(x, ...) {
    if (is.null(names(x$par))) {
        names(x$par) <- paste0("parameter", seq_along(x$par))
    }
    data.frame(parameter = names(x$par), value = unname(x$par))
}


#' @rdname optim_tidiers
#' 
#' @return \code{glance} returns a one-row data frame with the columns
#'   \item{value}{minimized or maximized output value}
#'   \item{function.count}{number of calls to \code{fn}}
#'   \item{gradient.count}{number of calls to \code{gr}}
#'   \item{convergence}{convergence code representing the error state}
#' 
#' @seealso \code{\link{optim}}
glance_optim <- function(x, ...) {
    unrowname(data.frame(value = x$value,
                         function.count = x$counts["function"],
                         gradient.count = x$counts["gradient"],
                         convergence = x$convergence))
}
