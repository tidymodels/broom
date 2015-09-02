#' Tidy a binWidth object
#' 
#' Tidy a binWidth object from the "binGroup" package,
#' which calculates the expected width of a confidence
#' interval from a binomial test.
#' 
#' @param x A "binWidth" object
#' @param ... Extra arguments (not used)
#' 
#' @return A one-row data.frame with columns:
#'   \item{ci.width}{Expected width of confidence interval}
#'   \item{alternative}{Alternative hypothesis}
#'   \item{p}{True proportion}
#'   \item{n}{Total sample size}
#' 
#' @examples
#' 
#' if (require("binGroup", quietly = TRUE)) {
#'     bw <- binWidth(100, .1)
#'     bw
#'     tidy(bw)
#'     
#'     library(dplyr)
#'     d <- expand.grid(n = seq(100, 800, 100),
#'                      p = .5,
#'                      method = c("CP", "Blaker", "Score", "Wald"),
#'                      stringsAsFactors = FALSE) %>%
#'         group_by(n, p, method) %>%
#'         do(tidy(binWidth(.$n, .$p, method = .$method)))
#'     
#'     library(ggplot2)
#'     ggplot(d, aes(n, ci.width, color = method)) +
#'         geom_line() +
#'         xlab("Total Observations") +
#'         ylab("Expected CI Width")
#' }
#' 
#' @name binWidth_tidiers
#' 
#' @export
tidy.binWidth <- function(x, ...) {
    ret <- as.data.frame(unclass(x))
    dplyr::rename(ret, ci.width = expCIWidth)
}


#' Tidy a binDesign object
#' 
#' Tidy a binDesign object from the "binGroup" package,
#' which determines the sample size needed for
#' a particular power. 
#' 
#' @param x A "binDesign" object
#' @param ... Extra arguments (not used)
#' 
#' @template boilerplate
#' 
#' @return The \code{tidy} method returns a data.frame
#' with one row for each iteration that was performed,
#' with columns
#'     \item{n}{Number of trials in this iteration}
#'     \item{power}{The power achieved for this n}
#' 
#' The \code{glance} method returns a one-row data.frame
#' with columns
#'     \item{power}{The power achieved by the analysis}
#'     \item{n}{The sample size used to achieve this power}
#'     \item{power.reached}{Whether the desired power was reached}
#'     \item{maxit}{Number of iterations performed}
#' 
#' @examples
#' 
#' if (require("binGroup", quietly = TRUE)) {
#'     des <- binDesign(nmax = 300, delta = 0.06,
#'                      p.hyp = 0.1, power = .8)
#' 
#'     glance(des)
#'     head(tidy(des))
#'     
#'     # the ggplot2 equivalent of plot(des)
#'     library(ggplot2)
#'     ggplot(tidy(des), aes(n, power)) +
#'         geom_line()
#' }
#' @name binDesign_tidiers
#' 
#' @export
tidy.binDesign <- function(x, ...) {
    ret <- data.frame(n = x$nit, power = x$powerit)
    # only up to the number of iterations performed
    head(ret, x$maxit)
}


#' @rdname binDesign_tidiers
#' @export
glance.binDesign <- function(x, ...) {
    with(unclass(x), data.frame(power = powerout,
                                n = nout,
                                power.reached,
                                maxit = maxit))
}
