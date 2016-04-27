#' Tidiers for Cochrane Orcutt object
#' 
#' Tidies a Cochrane Orcutt object, which estimates autocorrelation
#' and beta coefficients.
#' This function is not exported and would not typically be called
#' directly: it is dispatched by \code{\link{tidy.list}} and
#' \code{\link{glance.list}}.
#' 
#' @param x A list returned by \code{cochrane.orcutt}
#' @param ... Extra arguments passed on to \code{\link{tidy.summary.lm}}
#' 
#' @template boilerplate
#' 
#' @return \code{tidy} returns the same information as
#' \code{\link{tidy.lm}}, though without confidence interval options.
#' 
#' @name orcutt_tidiers
#' 
#' @examples
#' 
#' reg <- lm(mpg ~ wt + qsec + disp, mtcars)
#' tidy(reg)
#' 
#' if (require("orcutt", quietly = TRUE)) {
#'   co <- cochrane.orcutt(reg)
#'   co
#'   
#'   tidy(co)
#'   glance(co)
#' }
#' 
#' @seealso \link{list_tidiers}
tidy_orcutt <- function(x, ...) {
    tidy(x$Cochrane.Orcutt, ...)
}


#' @rdname orcutt_tidiers
#' 
#' @return \code{glance} returns the same one-row data frame as
#' \code{\link{glance.summary.lm}}, along with columns \code{rho}
#' and \code{number.interaction}.
glance_orcutt <- function(x, ...) {
    ret <- glance.summary.lm(x$Cochrane.Orcutt)
    ret$rho <- x$rho
    ret$number.interaction <- x$number.interaction
    
    ret
}
