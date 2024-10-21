#' @templateVar class kde
#' @template title_desc_tidy
#'
#' @param x A `kde` object returned from [ks::kde()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy("obs", "variable", "value", "estimate")
#'
#' @details Returns a data frame in long format with four columns. Use
#'   \code{tidyr::pivot_wider(..., names_from = variable, values_from = value)}
#'   on the output to return to a wide format.
#'
#' @examplesIf rlang::is_installed(c("ks", "ggplot2"))
#'
#' # load libraries for models and data
#' library(ks)
#'
#' # generate data
#' dat <- replicate(2, rnorm(100))
#' k <- kde(dat)
#'
#' # summarize model fit with tidiers + visualization
#' td <- tidy(k)
#' td
#'
#' library(ggplot2)
#' library(dplyr)
#' library(tidyr)
#'
#' td %>%
#'   pivot_wider(c(obs, estimate),
#'     names_from = variable,
#'     values_from = value
#'   ) %>%
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
  estimate <- x$estimate %>%
    as.data.frame.table(responseName = "value") %>%
    dplyr::mutate_if(is.factor, as.integer)

  dims <- seq_len(length(x$eval.points))

  purrr::map2(
    x$eval.points,
    estimate[dims],
    function(e, d) e[d]
  ) %>%
    purrr::set_names(paste0("x", dims)) %>%
    as_tibble() %>%
    mutate(
      estimate = estimate$value,
      obs = row_number()
    ) %>%
    pivot_longer(
      cols = c(dplyr::everything(), -estimate, -obs),
      names_to = "variable",
      values_to = "value"
    ) %>%
    arrange(variable, obs) %>%
    select(obs, variable, value, estimate)
}
