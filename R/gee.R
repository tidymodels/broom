# mclogit subclasses glm, make sure to stop rather than erroneously
# use the glm tidiers

#' @export
tidy.gee <- tidy.default

#' @export
glance.gee <- glance.default

#' @export
augment.gee <- augment.default
