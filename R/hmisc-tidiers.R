#' @templateVar class rcorr
#' @template title_desc_tidy
#'
#' @param x An `rcorr` object returned from [Hmisc::rcorr()].
#' @param diagonal Logical indicating whether or not to include diagonal
#'   elements of the correlation matrix, or the correlation of a column with
#'   itself. For the elements, `estimate` is always 1 and `p.value` is always
#'   `NA`. Defaults to `FALSE`.
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "column1",
#'   "column2",
#'   "estimate",
#'   "p.value",
#'   n = "Number of observations used to compute the correlation"
#' )
#'
#' @details Suppose the original data has columns A and B. In the correlation
#'   matrix from `rcorr` there may be entries for both the `cor(A, B)` and
#'   `cor(B, A)`. Only one of these pairs will ever be present in the tidy
#'   output.
#'
#' @examples
#'
#' library(Hmisc)
#'
#' mat <- replicate(52, rnorm(100))
#' # add some NAs
#' mat[sample(length(mat), 2000)] <- NA
#' # also column names
#' colnames(mat) <- c(LETTERS, letters)
#'
#' rc <- rcorr(mat)
#'
#' td <- tidy(rc)
#' td
#'
#' library(ggplot2)
#' ggplot(td, aes(p.value)) +
#'   geom_histogram(binwidth = .1)
#'
#' ggplot(td, aes(estimate, p.value)) +
#'   geom_point() +
#'   scale_y_log10()
#' @export
#' @aliases rcorr_tidiers Hmisc_tidiers
#' @seealso [tidy()], [Hmisc::rcorr()]
tidy.rcorr <- function(x, diagonal = FALSE, ...) {
  ret <- x$r %>%
    as.data.frame() %>%
    tibble::rownames_to_column("column1") %>%
    pivot_longer(c(dplyr::everything(), -column1),
      names_to = "column2",
      values_to = "estimate"
    ) %>%
    as.data.frame() %>%
    mutate(n = as.vector(x$n), p.value = as.vector(x$P))

  # include only half the symmetric matrix.
  ret <- ret[upper.tri(x$r, diag = diagonal), ]
  as_tibble(ret)
}
