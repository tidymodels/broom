# mclogit subclasses glm, make sure to stop rather than erroneously
# use the glm tidiers

#' @include null-and-default-tidiers.R
#' @export
tidy.gee <- tidy.default

#' @include null-and-default-tidiers.R
#' @export
glance.gee <- glance.default

#' @include null-and-default-tidiers.R
#' @export
augment.gee <- augment.default
