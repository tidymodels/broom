#' @templateVar class kde
#' @template title_desc_tidy
#' 
#' @param x A `kde` object returned from [ks::kde()].
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with one row for each point in the
#'   estimated grid. The result contains one column (named `x1`,
#'   `x2`, etc) for each dimension, and an `estimate` column
#'   containing the estimated density.
#'
#' @examples
#'
#' if (requireNamespace("ks", quietly = TRUE)) {
#'   
#'   library(ks)
#'   
#'   dat <- replicate(2, rnorm(100))
#'   k <- kde(dat)
#'
#'   td <- tidy(k)
#'   td
#'
#'   library(ggplot2)
#'   ggplot(td, aes(x1, x2, fill = estimate)) +
#'     geom_tile() +
#'     theme_void()
#'
#'   # also works with 3 dimensions
#'   dat3 <- replicate(3, rnorm(100))
#'   k3 <- kde(dat3)
#'
#'   td3 <- tidy(k3)
#'   td3
#' }
#'
#' @export
#' @aliases kde_tidiers ks_tidiers
#' @seealso [tidy()], [ks::kde()]
tidy.kde <- function(x, ...) {
  
  # TODO: would like to use tidyr instead but melt is an arbitrary order array
  # so not sure how to make that change
  estimate <- reshape2::melt(x$estimate)
  dims <- seq_len(length(x$eval.points))
  
  purrr::map2(
    x$eval.points,
    estimate[dims],
    function(e, d) e[d]
  ) %>%
    purrr::set_names(paste0("x", dims)) %>%
    as_tibble() %>% 
    mutate(estimate = estimate$value,
           obs = row_number()) %>% 
    tidyr::gather(variable, value, -estimate, -obs) %>% 
    select(obs, variable, value, estimate)
}
