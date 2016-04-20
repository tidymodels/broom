#' Tidy a kernel density estimate object from the ks package
#' 
#' Tidy a kernel density estimate object, into a table with
#' one row for each point in the estimated grid, and one column
#' for each dimension (along with an \code{estimate} column with
#' the estimated density).
#' 
#' @param x A "ks" object from the kde package
#' @param ... Extra arguments, not used
#' 
#' @return A data frame with one row for each point in the
#' estimated grid. The result contains one column (named \code{x1},
#' \code{x2}, etc) for each dimension, and an \code{estimate} column
#' containing the estimated density.
#' 
#' @name kde_tidiers
#' 
#' @examples
#' 
#' if (require("ks", quietly = TRUE)) {
#'   dat <- replicate(2, rnorm(100))
#'   k <- kde(dat)
#'   
#'   td <- tidy(k)
#'   head(td)
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
#'   head(td3)
#' }
#' 
#' @export
tidy.kde <- function(x, ...) {
    estimate <- reshape2::melt(x$estimate)
    
    dims <- seq_len(length(x$eval.points))
    
    ret <- purrr::map2(x$eval.points, estimate[dims], function(e, d) e[d]) %>%
        as.data.frame() %>%
        setNames(paste0("x", dims)) %>%
        mutate(estimate = estimate$value)

    ret
}
