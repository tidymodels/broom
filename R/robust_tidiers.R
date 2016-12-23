#' Tidiers for lmRob and glmRob objects
#' 
#' Tidying robust regression methods from the robust package. The tidy and augment
#' methods simply pass it on to the lm tidiers.
#' 
#' @examples
#' 
#' if (requireNamespace("robust", quietly = TRUE)) {
#'   data(stack.dat)
#'   m <- lmRob(Loss ~ ., data = stack.dat)
#'   
#'   tidy(m)
#'   augment(m)
#'   glance(m)
#' }
#' 
#' @name robust_tidiers
#' 
#' @export
tidy.lmRob <- function(x, ...) {
    tidy.lm(x)
}

#' @rdname robust_tidiers
#' @export
augment.lmRob <- function(x, ...) {
    augment.lm(x)
}

#' @rdname robust_tidiers
#' @export
glance.lmRob <- function(x, ...) {
    s <- robust::summary.lmRob(x)
    finish_glance(data.frame(r.squared = x$r.squared, sigma = s$sigma), x)
}

#' @name robust_tidiers
#' 
#' @export
tidy.glmRob <- function(x, ...) {
    tidy.lm(x)
}

#' @rdname robust_tidiers
#' @export
augment.glmRob <- function(x, ...) {
    augment.lm(x)
}

#' @rdname robust_tidiers
#' @export
glance.glmRob <- function(x, ...) {
    s <- robust::summary.glmRob(x)
    finish_glance(data.frame(r.squared = x$r.squared, sigma = s$sigma), x)
}

