skip_if_not_r_version <- function(min_version) {
  if (getRversion() < min_version) {
    testthat::skip(paste("R version at least", min_version, "is required."))
  }
}
