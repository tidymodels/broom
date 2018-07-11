#' @templateVar class summaryDefault
#' @template title_desc_tidy_glance
#'
#' @param x A `summaryDefault` object, created by calling [summary()] on a
#'   vector.
#' @template param_unused_dots
#' 
#' @return A one-row [tibble::tibble] with columns:
#'   \item{minimum}{Minimum value in original vector.}
#'   \item{q1}{First quartile of original vector.}
#'   \item{median}{Median of original vector.}
#'   \item{mean}{Mean of original vector.}
#'   \item{q3}{Third quartile of original vector.}
#'   \item{maximum}{Maximum value in original vector.}
#'   \item{na}{Number of `NA` values in original vector. Column present only
#'     when original vector had at least one `NA` entry.}
#' 
#'
#' @examples
#'
#' v <- rnorm(1000)
#' s <- summary(v)
#' s
#'
#' tidy(s)
#' glance(s)
#'
#' v2 <- c(v,NA)
#' tidy(summary(v2))
#'
#' @name summary_tidiers
#' @export
#' @seealso [tidy()], [summary()]
tidy.summaryDefault <- function(x, ...) {
  ret <- as.data.frame(t(as.matrix(x)))
  cnms <- c("minimum", "q1", "median", "mean", "q3", "maximum")
  if ("NA's" %in% names(x)) {
    cnms <- c(cnms, "na")
  }
  as_tibble(purrr::set_names(ret, cnms))
}

#' @rdname summary_tidiers
#' @export
glance.summaryDefault <- tidy.summaryDefault
