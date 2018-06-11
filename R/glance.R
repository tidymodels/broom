#' Construct a single row summary "glance" of a model, fit, or other
#' object
#'
#' glance methods always return either a one-row data frame (except on NULL, which
#' returns an empty data frame)
#'
#' @param x model or other R object to convert to single-row data frame
#' @param ... other arguments passed to methods
#' @export
glance <- function(x, ...) UseMethod("glance")

#' @export
glance.NULL <- function(x, ...) data.frame()

#' @export
glance.default <- function(x, ...) {
  stop("glance doesn't know how to deal with data of class ", class(x), call. = FALSE)
}

#' @export
#' @example
#' # Simulate some non-linear data
#' set.seed(1)
#' n <- 30
#' x <- rnorm(n)
#' e <- rnorm(n)
#' y <- sinpi(x) + e
#' df <- data.frame(y, x)
#' # Fit several models
#' fit.list <- list(
#'   "fit.d01" = lm(y ~ x, data = df),
#'   "fit.d02" = lm(y ~ poly(x, 2), data = df),
#'   "fit.d03" = lm(y ~ poly(x, 3), data = df),
#'   "fit.d04" = lm(y ~ poly(x, 4), data = df),
#'   "fit.d05" = lm(y ~ poly(x, 5), data = df),
#'   "fit.d06" = lm(y ~ poly(x, 6), data = df)
#' )
#' # Compare fit
#' glance(fit.list)
glance.list <- function(l, ...) {
  out <- lapply(seq_along(l), function(i) {
    x <- glance(l[[i]])
    x$x <- names(l)[i]
    x
  })
  out <- do.call(rbind.data.frame, out)
  out
}
