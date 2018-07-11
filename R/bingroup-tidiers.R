#' @templateVar class binWidth
#' @template title_desc_tidy
#'
#' @param x A [binGroup::binWidth()] object.
#' @template param_unused_dots
#' 
#' @return A one-row [tibble::tibble] with columns:
#'   \item{ci.width}{Expected width of confidence interval.}
#'   \item{alternative}{Alternative hypothesis.}
#'   \item{p}{True proportion.}
#'   \item{n}{Total sample size.}
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
#' @export
#' @family bingroup tidiers
#' @aliases binwidth_tidiers
#' @seealso [tidy()], [binGroup::binWidth()]
tidy.binWidth <- function(x, ...) {
  ret <- as_tibble(unclass(x))
  dplyr::rename(ret, ci.width = expCIWidth)
}


#' @templateVar class binDesign
#' @template title_desc_tidy
#'
#' @param x A [binGroup::binDesign()] object.
#' @template param_unused_dots
#'
#' @return A one-row [tibble::tibble] with columns:
#'   \item{n}{Number of trials in given iteration.}
#'   \item{power}{Power achieved for given value of n.}
#'
#' @examples
#'
#' if (require("binGroup", quietly = TRUE)) {
#'     des <- binDesign(nmax = 300, delta = 0.06,
#'                      p.hyp = 0.1, power = .8)
#'
#'     glance(des)
#'     tidy(des)
#'
#'     # the ggplot2 equivalent of plot(des)
#'     library(ggplot2)
#'     ggplot(tidy(des), aes(n, power)) +
#'         geom_line()
#' }
#'
#' @export
#' @family bingroup tidiers
#' @aliases bindesign_tidiers
#' @seealso [tidy()], [binGroup::binDesign()]
tidy.binDesign <- function(x, ...) {
  ret <- tibble(n = x$nit, power = x$powerit)
  # only up to the number of iterations performed
  head(ret, x$maxit)
}

#' @templateVar class binDesign
#' @template title_desc_glance
#'
#' @param x A [binGroup::binDesign] object.
#' @template param_unused_dots
#'
#' @return A one-row [tibble::tibble] with columns:
#'   \item{power}{Power achieved by the analysis.}
#'   \item{n}{Sample size uzed to achieve this power.}
#'   \item{power.reached}{Whether the desired power was reached.}
#'   \item{maxit}{Number of iterations performed.}
#'
#' @examples
#'
#' if (require("binGroup", quietly = TRUE)) {
#'     des <- binDesign(nmax = 300, delta = 0.06,
#'                      p.hyp = 0.1, power = .8)
#'
#'     glance(des)
#'     tidy(des)
#'
#'     # the ggplot2 equivalent of plot(des)
#'     library(ggplot2)
#'     ggplot(tidy(des), aes(n, power)) +
#'         geom_line()
#' }
#'
#' @export
#' @family bingroup tidiers
#' @seealso [glance()], [binGroup::binDesign()]
glance.binDesign <- function(x, ...) {
  with(unclass(x), tibble(
    power = powerout,
    n = nout,
    power.reached,
    maxit = maxit
  ))
}
