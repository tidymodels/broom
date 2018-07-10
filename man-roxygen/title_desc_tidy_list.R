#' Tidying methods for singular value decomposition lists
#'
#' These methods tidy the U, D, and V matrices returned by the
#' [svd()] functions into a tidy format. Because `svd` returns
#' lists without classes, this function has to be called by
#' [tidy.list()] when it recognizes a list as an SVD.
