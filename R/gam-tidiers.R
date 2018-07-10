#' @templateVar class Gam
#' @template title_desc_tidy
#' 
#' @param x A `Gam` object returned from a call to [gam::gam()].
#' @template param_unused_dots
#'
#' @return The tidied output of the parametric ANOVA for the GAM model as 
#'   a [tibble::tibble] with one row for each term in the model.
#'   
#' @details Tidy `gam` objects created by calls to [mgcv::gam()] with
#'   [tidy.gam()].
#'
#' @examples
#'
#' library(gam)
#' g <- gam(mpg ~ s(hp, 4) + am + qsec, data = mtcars)
#'   
#' tidy(g)
#' glance(g)
#' 
#' @export
#' @family gam tidiers
#' @aliases Gam_tidiers
#' @seealso [tidy()], [gam::gam()], [tidy.anova()], [tidy.gam()]
tidy.Gam <- function(x, ...) {
  tidy(summary(x)$parametric.anova)
}

#' @templateVar class Gam
#' @template title_desc_glance
#' 
#' @inheritParams tidy.Gam
#' 
#' @template return_finish_glance
#' 
#' @details Glance at `gam` objects created by calls to [mgcv::gam()] with
#'   [glance.gam()].
#' 
#' @family gam tidiers
#' @export
#' @seealso [glance()], [gam::gam()]
glance.Gam <- function(x, ...) {
  s <- summary(x)
  ret <- tibble(df = s$df[1])
  finish_glance(ret, x)
}
