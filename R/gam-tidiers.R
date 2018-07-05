#' @templateVar class Gam
#' @template title_desc_tidy
#' 
#' @param x A `Gam` object returned from a call to [gam::gam()].
#' @template param_unused_dots
#'
#' @return The tidied output of the parametric ANOVA for the GAM model as 
#'   a [tibble::tibble] with one row for each term in the model.
#'   
#' @details To tidy `gam` objects created by calls to [mgcv::gam()],
#'   see [tidy.gam()].
#'
#' @examples
#'
#' if (requireNamespace("gam", quietly = TRUE)) {
#'   data(kyphosis)
#'   g <- gam::gam(Kyphosis ~ s(Age, 4), family = binomial, data = kyphosis)
#'   
#'   tidy(g)
#'   glance(g)
#' }
#'
#' @export
#' @family Gam tidiers
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
#' @details To glance `gam` objects created by calls to [mgcv::gam()],
#'   see [glance.gam()].
#' 
#' @export
#' @family Gam tidiers
#' @seealso [glance()], [gam::gam()], [glance.gam()]
glance.Gam <- function(x, ...) {
  s <- summary(x)
  ret <- tibble(df = s$df[1])
  finish_glance(ret, x)
}
