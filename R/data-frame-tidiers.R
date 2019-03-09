
#' @export
glance.data.frame <- function(x, ...) {
  stop(
    "There is no glance method for data frames. ",
    "Did you mean `dplyr::glimpse()`?",
    call. = FALSE
  )
}

#' @export
glance.tbl_df <- function(x, ...) {
  stop(
    "There is no glance method for tibbles. ",
    "Did you mean `dplyr::glimpse()`?",
    call. = FALSE
  )
}
