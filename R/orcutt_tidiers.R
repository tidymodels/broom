#' Tidiers for Cochrane Orcutt object
#' 
#' Tidies a Cochrane Orcutt object, which estimates autocorrelation
#' and beta coefficients in a linear fit.
#' 
#' @param x An "orcutt" object returned by \code{cochrane.orcutt}
#' @param ... Extra arguments passed on to \code{\link{tidy.lm}}
#' 
#' @template boilerplate
#' 
#' @return \code{tidy} returns the same information as
#' \code{\link{tidy.lm}}, though without confidence interval options.
#' 
#' @return \code{glance}{}
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
#' @export
tidy.orcutt <- function(x, ...) {
    tidy.lm(x, ...)
}


#' @rdname orcutt_tidiers
#' 
#' @return \code{glance} returns a one-row data frame with the following columns:
#'   \item{r.squared}{R-squared}
#'   \item{adj.r.squared}{Adjusted R-squared}
#'   \item{rho}{Spearman's rho autocorrelation}
#'   \item{number.interaction}{Number of interactions}
#'   \item{dw.original}{Durbin-Watson statistic of original fit}
#'   \item{p.value.original}{P-value of original Durbin-Watson statistic}
#'   \item{dw.transformed}{Durbin-Watson statistic of transformed fit}
#'   \item{p.value.transformed}{P-value of autocorrelation after transformation}
#' 
#' @export
glance.orcutt <- function(x, ...) {
    ret <- data.frame(r.squared = x$r.squared,
                      adj.r.squared = x$adj.r.squared,
                      rho = x$rho,
                      number.interaction = x$number.interaction,
                      dw.original = x$DW[1],
                      p.value.original = x$DW[2],
                      dw.transformed = x$DW[3],
                      p.value.transformed = x$DW[4])
    
    ret$rho <- x$rho
    ret$number.interaction <- x$number.interaction
    
    ret
}
