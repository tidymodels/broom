#' @templateVar class kde
#' @template title_desc_tidy
#' 
#' @param x A `kde` object returned from [ks::kde()].
#' @template param_unused_dots
#' 
#' @evalRd return_tidy("obs", "variable", "value", "estimate")
#' 
#' @details Returns a data frame in long format with four columns. Use
#'   `tidyr::spread(..., variable, value)` on the output to return to a 
#'   wide format.
#'
#' @examples
#'
#' library(ks)
#' 
#' dat <- replicate(2, rnorm(100))
#' k <- kde(dat)
#'
#' td <- tidy(k)
#' td
#'
#' library(ggplot2)
#' library(dplyr)
#' library(tidyr)
#' 
#' td %>% 
#'   spread(variable, value) %>% 
#'   ggplot(aes(x1, x2, fill = estimate)) +
#'   geom_tile() +
#'   theme_void()
#'
#' # also works with 3 dimensions
#' dat3 <- replicate(3, rnorm(100))
#' k3 <- kde(dat3)
#'
#' td3 <- tidy(k3)
#' td3
#'
#' @export
#' @aliases kde_tidiers ks_tidiers
#' @seealso [tidy()], [ks::kde()]
tidy.kde <- function(x, ...) {
  
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
