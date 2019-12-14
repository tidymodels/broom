# mclogit subclasses lm, make sure to stop rather than erroneously
# use the lm tidiers

#' @export
tidy.mclogit <- tidy.default

#' @export
glance.mclogit <- glance.default

#' @export
augment.mclogit <- augment.default
