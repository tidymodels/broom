#' Tidy an irlba list
#' 
#' A very thin wrapper around [tidy_svd()].
#'
#' @name svd_tidiers
tidy_irlba <- function(x, ...) {
  tidy_svd(x, ...)
}
