# scam subclasses glm and lm, so make sure to stop rather 
# than erroneously use the glm tidiers

#' @include null-and-default-tidiers.R
#' @export
tidy.scam <- tidy.default

#' @include null-and-default-tidiers.R
#' @export
glance.scam <- glance.default

#' @include null-and-default-tidiers.R
#' @export
augment.scam <- augment.default
