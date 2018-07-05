#' Tidiers for data.frame objects
#'
#' Data frame tidiers are deprecated and will be removed from an upcoming
#' release of broom.
#'
#' These perform tidy summaries of data.frame objects. `tidy` produces
#' summary statistics about each column, while `glance` simply reports
#' the number of rows and columns. Note that `augment.data.frame` will
#' throw an error.
#'
#' @param x A data.frame
#' @param data data, not used
#' @param na.rm a logical value indicating whether `NA` values should
#'   be stripped before the computation proceeds.
#' @param trim the fraction (0 to 0.5) of observations to be trimmed from
#'   each end of `x` before the mean is computed.  Passed to the
#'   `trim` argument of [mean()]
#' @param ... Additional arguments for other methods.
#'
#' @author David Robinson, Benjamin Nutter
#'
#' @source
#' Skew and Kurtosis functions are adapted from implementations in the `moments` package: \cr
#' Lukasz Komsta and Frederick Novomestky (2015). moments: Moments, cumulants, skewness,
#' kurtosis and related tests. R package version 0.14. \cr
#' https://CRAN.R-project.org/package=moments
#'
#' @examples
#' 
#' \dontrun{
#' td <- tidy(mtcars)
#' td
#'
#' glance(mtcars)
#'
#' library(ggplot2)
#' # compare mean and standard deviation
#' ggplot(td, aes(mean, sd)) + geom_point() +
#'      geom_text(aes(label = column), hjust = 1, vjust = 1) +
#'      scale_x_log10() + scale_y_log10() + geom_abline()
#' }
#'
#' @name data.frame_tidiers


#' @rdname data.frame_tidiers
#'
#' @return `tidy.data.frame` produces a data frame with one
#' row per original column, containing summary statistics of each:
#'   \item{column}{name of original column}
#'   \item{n}{Number of valid (non-NA) values}
#'   \item{mean}{mean}
#'   \item{sd}{standard deviation}
#'   \item{median}{median}
#'   \item{trimmed}{trimmed mean, with trim defaulting to .1}
#'   \item{mad}{median absolute deviation (from the median)}
#'   \item{min}{minimum value}
#'   \item{max}{maximum value}
#'   \item{range}{range}
#'   \item{skew}{skew}
#'   \item{kurtosis}{kurtosis}
#'   \item{se}{standard error}
#'
#' @export

tidy.data.frame <- function(x, ..., na.rm = TRUE, trim = 0.1) {
  .Deprecated()
  ret <-
    tibble::data_frame(
      column = names(x),
      n = vapply(
        X = x,
        FUN = function(k) sum(!is.na(k)),
        FUN.VALUE = numeric(1)
      ),
      mean = vapply(
        X = x,
        FUN = mean,
        FUN.VALUE = numeric(1),
        na.rm = na.rm
      ),
      sd = vapply(
        X = x,
        FUN = stats::sd,
        FUN.VALUE = numeric(1),
        na.rm = na.rm
      ),
      median = vapply(
        X = x,
        FUN = stats::median,
        FUN.VALUE = numeric(1),
        na.rm = na.rm
      ),
      trimmed = vapply(
        X = x,
        FUN = mean,
        FUN.VALUE = numeric(1),
        na.rm = na.rm,
        trim = trim
      ),
      mad = vapply(
        X = x,
        FUN = median_abs_dev,
        FUN.VALUE = numeric(1),
        na.rm = na.rm
      ),
      min = vapply(
        X = x,
        FUN = min,
        FUN.VALUE = numeric(1),
        na.rm = na.rm
      ),
      max = vapply(
        X = x,
        FUN = max,
        FUN.VALUE = numeric(1),
        na.rm = na.rm
      ),
      range = vapply(
        X = x,
        FUN = function(k, na.rm) diff(range(k, na.rm = na.rm)),
        FUN.VALUE = numeric(1),
        na.rm = na.rm
      ),
      skew = vapply(
        X = x,
        FUN = skewness,
        FUN.VALUE = numeric(1),
        na.rm = na.rm
      ),
      kurtosis = vapply(
        X = x,
        FUN = kurtosis,
        FUN.VALUE = numeric(1),
        na.rm = na.rm
      )
    )

  ret$se <- ret$sd / sqrt(ret$n)

  ret
}

#' @rdname data.frame_tidiers
#'
#' @return `glance` returns a one-row data.frame with
#'   \item{nrow}{number of rows}
#'   \item{ncol}{number of columns}
#'   \item{complete.obs}{number of rows that have no missing values}
#'   \item{na.fraction}{fraction of values across all rows and columns that
#'   are missing}
#'
#' @export
glance.data.frame <- function(x, ...) {
  .Deprecated()
  ret <- tibble::data_frame(
    nrow = nrow(x),
    ncol = ncol(x)
  )
  ret$complete.obs <- sum(stats::complete.cases(x))
  ret$na.fraction <- mean(is.na(x))
  return(ret)
}


# Basic code inspired by moments::skew
skewness <- function(x, na.rm = FALSE) {
  n <- sum(!is.na(x))
  (sum((x - mean(x, na.rm = na.rm))^3) / n) /
    (sum((x - mean(x, na.rm = na.rm))^2) / n)^(3 / 2)
}

# Basic code inspired by moments::kurtosis
kurtosis <- function(x, na.rm = FALSE) {
  n <- sum(!is.na(x))
  n * sum((x - mean(x, na.rm = na.rm))^4) /
    (sum((x - mean(x, na.rm = na.rm))^2)^2)
}

median_abs_dev <- function(x, na.rm = FALSE) {
  stats::median(abs(x - stats::median(x, na.rm = na.rm)),
    na.rm = na.rm
  )
}
