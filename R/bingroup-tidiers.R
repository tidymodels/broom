#' @templateVar class binWidth
#' @template title_desc_tidy
#'
#' @param x A [binGroup::binWidth()] object.
#' @template param_unused_dots
#'
#' @evalRd return_tidy("ci.width", "alternative", "p",
#'   n = "Total sample size"
#' )
#'
#' @examplesIf rlang::is_installed("binGroup")
#'
#' # load libraries
#' library(binGroup)
#'
#' # fit model
#' bw <- binWidth(100, .1)
#' 
#' bw
#'
#' # summarize model fit with tidiers
#' tidy(bw)
#' 
#' @export
#' @family bingroup tidiers
#' @aliases binwidth_tidiers
#' @seealso [tidy()], [binGroup::binWidth()]
tidy.binWidth <- function(x, ...) {
  ret <- as_tibble(unclass(x))
  rename(ret, ci.width = expCIWidth)
}


#' @templateVar class binDesign
#' @template title_desc_tidy
#'
#' @param x A [binGroup::binDesign()] object.
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   n = "Number of trials in given iteration.",
#'   power = "Power achieved for given value of n."
#' )
#'
#' @examplesIf rlang::is_installed(c("binGroup", "ggplot2"))
#'
#' library(binGroup)
#' des <- binDesign(
#'   nmax = 300, delta = 0.06,
#'   p.hyp = 0.1, power = .8
#' )
#'
#' glance(des)
#' tidy(des)
#'
#' # the ggplot2 equivalent of plot(des)
#' library(ggplot2)
#' ggplot(tidy(des), aes(n, power)) +
#'   geom_line()
#'   
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
#' @evalRd return_glance(
#'   power = "Power achieved by the analysis.",
#'   n = "Sample size used to achieve this power.",
#'   power.reached = "Whether the desired power was reached.",
#'   maxit = "Number of iterations performed."
#' )
#'
#' @examplesIf rlang::is_installed(c("binGroup", "ggplot2"))
#' 
#' # load libraries for models and data
#' library(binGroup)
#' 
#' des <- binDesign(
#'   nmax = 300, delta = 0.06,
#'   p.hyp = 0.1, power = .8
#' )
#'
#' glance(des)
#' tidy(des)
#'
#' library(ggplot2)
#' 
#' ggplot(tidy(des), aes(n, power)) +
#'   geom_line()
#' 
#' @export
#' @family bingroup tidiers
#' @seealso [glance()], [binGroup::binDesign()]
glance.binDesign <- function(x, ...) {
  
  ux <- unclass(x)
  
  as_glance_tibble(
    power = ux$powerout,
    n = ux$nout,
    power.reached = ux$power.reached,
    maxit = ux$maxit,
    na_types = "riri"
  )
}
