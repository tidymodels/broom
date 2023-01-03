
tidy_mat <- function(x, type) {
  ret <- tibble::as_tibble(x, rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")
  ret$type <- type
  dplyr::relocate(ret, type, .after = "term")
}

.tidy <- function(x, type = "count", ...) {
  type <- rlang::arg_match0(type, c("count", "zero", "all"), "type")
  x <- summary(x)
  if (type == "count") {
    res <- tidy_mat(x$coefficients$count, "count")
  } else if (type == "zero") {
    res <- tidy_mat(x$coefficients$zero, "zero")
  } else {
    res <-
      dplyr::bind_rows(
        tidy_mat(x$coefficients$count, "count"),
        tidy_mat(x$coefficients$zero, "zero")
      )
  }
  res
}


#' Turn zero-inflated model results into a tidy tibble
#'
#' @param x A `hurdle` or `zeroinfl` model object.
#' @param type A character string for which model coefficients to return:
#' "all", "count", or "zero".
#' @param ... Not currently used.
#' @return A tibble
#'
#' @name tidy_zip
#' @export
tidy.zeroinfl <- .tidy

#' @export
#' @rdname tidy_zip
tidy.hurdle <- .tidy
