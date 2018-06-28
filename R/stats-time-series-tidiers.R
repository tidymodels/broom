

#' Tidy a ts timeseries object
#'
#' Turn a univariate or multivariate [ts()] object into a tidy data
#' frame.
#'
#' @param x An object of class "ts".
#' @param ... extra arguments (not used)
#'
#' @return `tidy` returns a data frame with one row for each observation, with the
#' following columns:
#'   \item{index}{Index (i.e. date or time) for the "ts" object.}
#'   \item{series}{Name of the series (multivariate "ts" objects only).}
#'   \item{value}{Value of the observation.}
#'
#' @examples
#'
#' set.seed(678)
#'
#' tidy(ts(1:10, frequency = 4, start = c(1959, 2)))
#'
#' z <- ts(matrix(rnorm(300), 100, 3), start = c(1961, 1), frequency = 12)
#' colnames(z) <- c("Aa", "Bb", "Cc")
#' tidy(z)
#'
#' @seealso \link{ts}, \link{zoo_tidiers}
#'
#' @export
tidy.ts <- function(x, ...) {
  # This generates the "index" column using the same approach as time(x), but
  # without converting to a ts object.
  xtsp <- stats::tsp(x)
  index <- seq(xtsp[1], xtsp[2], by = 1 / xtsp[3])
  # Turn multi-column time series into tidy data frames.
  if (is.matrix(x)) {
    res <- tibble::as_data_frame(as.data.frame(x))
    res <- tibble::add_column(res, index = index, .before = 1)
    tidyr::gather(res, series, value, -index)
  } else {
    tibble(index = index, value = as.vector(x))
  }
}

#' Tidying method for the acf function
#'
#' Tidy an "acf" object, which is the output of `acf` and the
#' related `pcf` and `ccf` functions.
#'
#' @name acf_tidiers
#'
#' @param x acf object
#' @param ... (not used)
#'
#' @return `data.frame` with columns
#'  \item{lag}{lag values}
#'  \item{acf}{calculated correlation}
#'
#' @examples
#'
#' # acf
#' result <- acf(lh, plot=FALSE)
#' tidy(result)
#'
#' # ccf
#' result <- ccf(mdeaths, fdeaths, plot=FALSE)
#' tidy(result)
#'
#' # pcf
#' result <- pacf(lh, plot=FALSE)
#' tidy(result)
#'
#' # lag plot
#' library(ggplot2)
#' result <- tidy(acf(lh, plot=FALSE))
#' p <- ggplot(result, aes(x=lag, y=acf)) +
#'          geom_bar(stat='identity', width=0.1) +
#'          theme_bw()
#' p
#'
#' # with confidence intervals
#' conf.level <- 0.95
#' # from `plot.acf` method
#' len.data <- length(lh) # same as acf$n.used
#' conf.int <- qnorm((1 + conf.level) / 2) / sqrt(len.data)
#' p + geom_hline(yintercept = c(-conf.int, conf.int),
#'                color='blue', linetype='dashed')
#'
#' @export
tidy.acf <- function(x, ...) {
  tibble(lag = as.numeric(x$lag), acf = as.numeric(x$acf))
}


#' tidy a spec objet
#'
#' Given a "spec" object, which shows a spectrum across a range of frequencies,
#' returns a tidy data frame with two columns: "freq" and "spec"
#'
#' @param x an object of class "spec"
#' @param ... extra arguments (not used)
#'
#' @return a data frame with "freq" and "spec" columns
#'
#' @examples
#'
#' spc <- spectrum(lh)
#' tidy(spc)
#'
#' library(ggplot2)
#' ggplot(tidy(spc), aes(freq, spec)) + geom_line()
#'
#' @export
tidy.spec <- function(x, ...) {
  as_tibble(x[c("freq", "spec")])
}
