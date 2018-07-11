#' @templateVar class irlba
#' @template title_desc_tidy_list
#'
#' @param x A list returned from [irlba::irlba()].
#' @inheritDotParams tidy_svd
#' 
#' @inherit tidy_svd return
#' 
#' @details A very thin wrapper around [tidy_svd()].
#'
#' @aliases tidy.irlba irlba_tidiers
#' @family list tidiers
#' @family svd tidiers
#' @seealso [tidy()], [irlba::irlba()]
#' @export
tidy_irlba <- function(x, ...) {
  tidy_svd(x, ...)
}
