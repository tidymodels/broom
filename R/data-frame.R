#' @export
glance.data.frame <- function(x, ...) {
  cli::cli_abort(c(
      "There is no {.fn glance} method for data frames.",
      "i" = "Did you mean {.fn tibble::glimpse}?"
  ))
}

#' @export
glance.tbl_df <- function(x, ...) {
  cli::cli_abort(c(
      "There is no glance method for tibbles.",
      "i" = "Did you mean {.fn tibble::glimpse}?"
  ))
}
