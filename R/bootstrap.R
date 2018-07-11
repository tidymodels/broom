#' Set up bootstrap replicates of a dplyr operation
#'
#' The `bootstrap()` function is deprecated and will be removed from
#' an upcoming release of broom. For tidy resampling, please use the rsample
#' package instead.
#'
#' @param df a data frame
#' @param m number of bootstrap replicates to perform
#' @param by_group If `TRUE`, then bootstrap within each group if `df` is
#'    a grouped tbl.
#'
#' @details This code originates from Hadley Wickham (with a few small
#' corrections) here:
#'
#' https://github.com/hadley/dplyr/issues/269
#'
#' @examples
#'
#' \dontrun{
#' library(dplyr)
#' mtcars %>% bootstrap(10) %>% do(tidy(lm(mpg ~ wt, .)))
#' }
#'
#' @export
bootstrap <- function(df, m, by_group = FALSE) {
  .Deprecated()
  n <- nrow(df)
  attr(df, "indices") <-
    if (by_group && !is.null(groups(df))) {
      replicate(m,
        unlist(lapply(
          attr(df, "indices"),
          function(x) {
            sample(x, replace = TRUE)
          }
        ),
        recursive = FALSE, use.names = FALSE
        ),
        simplify = FALSE
      )
    } else {
      replicate(m, sample(n, replace = TRUE) -
        1, simplify = FALSE)
    }
  attr(df, "drop") <- TRUE
  attr(df, "group_sizes") <- rep(n, m)
  attr(df, "biggest_group_size") <- n
  attr(df, "labels") <- data.frame(replicate = 1:m)
  attr(df, "vars") <- list(quote(replicate))
  class(df) <- c("grouped_df", "tbl_df", "tbl", "data.frame")
  df
}
