#' @templateVar class gam
#' @template title_desc_tidy
#' 
#' @param x A `gam` object returned from a call to [mgcv::gam()].
#' @param parametric Logical indicating if parametric or smooth terms should
#'   be tidied. Defaults to `FALSE`, meaning that smooth terms are tidied
#'   by default.
#' @template param_unused_dots
#'
#' @details To tidy `Gam` objects created by calls to [gam::gam()],
#'   see [tidy.Gam()].
#'
#' @examples
#'
#' g <- mgcv::gam(mpg ~ s(hp) + am + qsec, data = mtcars)
#'   
#' tidy(g)
#' tidy(g, parametric = TRUE)
#' glance(g)
#' 
#'
#' @rdname mgcv_tidy_gam
#' @export
#' @aliases mgcv_tidiers gam_tidiers tidy.gam
#' @family mgcv tidiers
#' @seealso [tidy()], [mgcv::gam()], [tidy.Gam()]
tidy.gam <- function(x, parametric = FALSE, ...) {
  if (parametric) {
    px <- summary(x)$p.table
    px <- as.data.frame(px)
    fix_data_frame(px, c("estimate", "std.error", "statistic", "p.value"))
  } else {
    sx <- summary(x)$s.table
    sx <- as.data.frame(sx)
    class(sx) <- c("anova", "data.frame")
    tidy(sx)
  }
}

#' @templateVar class gam
#' @template title_desc_glance
#' 
#' @inheritParams tidy.gam
#' 
#' @template return_finish_glance
#' 
#' @details To glance `Gam` objects created by calls to [gam::gam()], see
#'   [glance.Gam()].
#' 
#' @rdname mgcv_glance_gam
#' @export
#' @family mgcv tidiers
#' @seealso [glance()], [mgcv::gam()], [glance.Gam()]
glance.gam <- function(x, ...) {
  ret <- tibble(df = sum(x$edf))
  finish_glance(ret, x)
}
