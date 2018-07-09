#' @templateVar class decomposed.ts
#' @template title_desc_augment
#'
#' @param x A `decomposed.ts` object returned from [stats::decompose()].
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with one row for each observation in the 
#'   original times series:
#'
#'   \item{`.seasonal`}{The seasonal component of the decomposition.}
#'   \item{`.trend`}{The trend component of the decomposition.}
#'   \item{`.remainder`}{The remainder, or "random" component of the
#'     decomposition.}
#'   \item{`.weight`}{The final robust weights (`stl` only).}
#'   \item{`.seasadj`}{The seasonally adjusted (or "deseasonalised")
#'     series.}
#'
#' @examples
#'
#' # Time series of temperatures in Nottingham, 1920-1939:
#' nottem
#'
#' # Perform seasonal decomposition on the data with both decompose
#' # and stl:
#' d1 <- stats::decompose(nottem)
#' d2 <- stats::stl(nottem, s.window = "periodic", robust = TRUE)
#'
#' # Compare the original series to its decompositions.
#'
#' cbind(broom::tidy(nottem), broom::augment(d1),
#'       broom::augment(d2))
#'
#' # Visually compare seasonal decompositions in tidy data frames.
#'
#' library(tibble)
#' library(dplyr)
#' library(tidyr)
#' library(ggplot2)
#'
#' decomps <- tibble(
#'     # Turn the ts objects into data frames.
#'     series = list(as.data.frame(nottem), as.data.frame(nottem)),
#'     # Add the models in, one for each row.
#'     decomp = c("decompose", "stl"),
#'     model = list(d1, d2)
#' ) %>%
#'     rowwise() %>%
#'     # Pull out the fitted data using broom::augment.
#'     mutate(augment = list(broom::augment(model))) %>%
#'     ungroup() %>%
#'     # Unnest the data frames into a tidy arrangement of
#'     # the series next to its seasonal decomposition, grouped
#'     # by the method (stl or decompose).
#'     group_by(decomp) %>%
#'     unnest(series, augment) %>%
#'     mutate(index = 1:n()) %>%
#'     ungroup() %>%
#'     select(decomp, index, x, adjusted = .seasadj)
#'
#' ggplot(decomps) +
#'     geom_line(aes(x = index, y = x), colour = "black") +
#'     geom_line(aes(x = index, y = adjusted, colour = decomp,
#'                   group = decomp))
#'
#' @aliases decompose_tidiers
#' @export
#' @family decompose tidiers
#' @seealso [augment()], [stats::decompose()]
augment.decomposed.ts <- function(x, ...) {
  ret <- tibble(
    seasonal = as.numeric(x$seasonal),
    trend = as.numeric(x$trend),
    remainder = as.numeric(x$random)
  )
  # Inspired by forecast::seasadj, this is the "deseasonalised" data:
  ret$seasadj <- if (x$type == "additive") {
    as.numeric(x$x) - ret$seasonal
  } else {
    as.numeric(x$x) / ret$seasonal
  }
  colnames(ret) <- paste0(".", colnames(ret))
  as_tibble(ret)
}

#' @templateVar class stl
#' @template title_desc_augment
#'
#' @param x An `stl` object returned from [stats::stl()].
#' @param weights Logical indicating whether or not to include the robust
#'   weights in the output.
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with one row for each observation in the 
#'   original times series:
#'
#'   \item{`.seasonal`}{The seasonal component of the decomposition.}
#'   \item{`.trend`}{The trend component of the decomposition.}
#'   \item{`.remainder`}{The remainder, or "random" component of the
#'     decomposition.}
#'   \item{`.weight`}{The final robust weights, if requested.}
#'   \item{`.seasadj`}{The seasonally adjusted (or "deseasonalised")
#'     series.}
#'
#' @export
#' @family decompose tidiers
#' @seealso [augment()], [stats::stl()]
augment.stl <- function(x, weights = TRUE, ...) {
  ret <- as_tibble(x$time.series)
  ret$weight <- x$weights
  # Inspired by forecast::seasadj, this is the "deseasonalised" data:
  ret$seasadj <- ret$trend + ret$remainder
  colnames(ret) <- paste0(".", colnames(ret))
  ret
}
