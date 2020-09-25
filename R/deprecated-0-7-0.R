# This script contains all functions and methods that will be deprecated 
# in 0.7.0 and removed in the next release.

# data.frame tidiers -------------------------------------------------------
# this one breaks some other functionality that new functions rely
# re: infinite recursion. Don't hard-deprecate, but trigger error.

#' Tidiers for data.frame objects
#'
#' Data frame tidiers are deprecated and will be removed from an upcoming
#' release of broom.
#'
#' These perform tidy summaries of data.frame objects. \code{tidy} produces
#' summary statistics about each column, while \code{glance} simply reports
#' the number of rows and columns. Note that \code{augment.data.frame} will
#' throw an error.
#'
#' @param x A data.frame
#' @param data data, not used
#' @param na.rm a logical value indicating whether \code{NA} values should
#'   be stripped before the computation proceeds.
#' @param trim the fraction (0 to 0.5) of observations to be trimmed from
#'   each end of \code{x} before the mean is computed.  Passed to the
#'   \code{trim} argument of \code{\link{mean}}
#' @param ... Additional arguments for other methods.
#'
#' @author David Robinson, Benjamin Nutter
#'
#' @source
#' Skew and Kurtosis functions are adapted from implementations in the \code{moments} package: \cr
#' Lukasz Komsta and Frederick Novomestky (2015). moments: Moments, cumulants, skewness,
#' kurtosis and related tests. R package version 0.14. \cr
#' https://CRAN.R-project.org/package=moments
#'
#' @examples
#'
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
#'
#' @name data.frame_tidiers


#' @rdname data.frame_tidiers
#'
#' @return \code{tidy.data.frame} produces a data frame with one
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
#' @family deprecated
tidy.data.frame <- function(x, ..., na.rm = TRUE, trim = 0.1) {
  .Deprecated(
    msg = "Data frame tidiers are deprecated and will be removed in an upcoming release of broom."
  )
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
#' @export
#' @family deprecated
augment.data.frame <- function(x, data, ...) {
  stop(paste("augment's first argument should be a model, not a data.frame"))
}


#' @rdname data.frame_tidiers
#'
#' @return \code{glance} returns a one-row data.frame with
#'   \item{nrow}{number of rows}
#'   \item{ncol}{number of columns}
#'   \item{complete.obs}{number of rows that have no missing values}
#'   \item{na.fraction}{fraction of values across all rows and columns that
#'   are missing}
#'
#' @export
#' @family deprecated
glance.data.frame <- function(x, ...) {
  .Deprecated(
    msg = "Data frame tidiers are deprecated and will be removed in an upcoming release of broom."
  )
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

# bootstrap --------------------------------------------------------------

#' Set up bootstrap replicates of a dplyr operation
#'
#' The \code{bootstrap()} function is deprecated and will be removed from
#' an upcoming release of broom. For tidy resampling, please use the rsample
#' package instead. Functionality is no longer supported for this method.
#'
#' @param df a data frame
#' @param m number of bootstrap replicates to perform
#' @param by_group If \code{TRUE}, then bootstrap within each group if \code{df} is
#'    a grouped tibble.
#'
#' @details This code originates from Hadley Wickham (with a few small
#' corrections) here:
#' \url{https://github.com/tidyverse/dplyr/issues/269}
#'
#' @export
#' @family deprecated
bootstrap <- function(df, m, by_group = FALSE) {
  .Deprecated(
    msg = "`bootstrap()` is deprecated and will be removed in an upcoming release of broom. See the rsample package instead."
  )
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

# fix_data_frame ----------------------------------------------------------

#' Ensure an object is a data frame, with rownames moved into a column
#'
#' This function is deprecated as of broom 0.7.0 and will be removed from
#' a future release. Please see \code{tibble::as_tibble}.
#'
#' @param x a data.frame or matrix
#' @param newnames new column names, not including the rownames
#' @param newcol the name of the new rownames column
#'
#' @return a data.frame, with rownames moved into a column and new column
#' names assigned
#' @family deprecated
#' @export
fix_data_frame <- function(x, newnames = NULL, newcol = "term") {
  
  .Deprecated(
    msg = "This function is deprecated as of broom 0.7.0 and will be removed from a future release. Please see tibble::as_tibble()."
  )
  
  if (!is.null(newnames) && length(newnames) != ncol(x)) {
    stop("newnames must be NULL or have length equal to number of columns")
  }
  
  if (all(rownames(x) == seq_len(nrow(x)))) {
    # don't need to move rownames into a new column
    ret <- data.frame(x, stringsAsFactors = FALSE)
    if (!is.null(newnames)) {
      colnames(ret) <- newnames
    }
  }
  else {
    ret <- data.frame(
      ...new.col... = rownames(x),
      unrowname(x),
      stringsAsFactors = FALSE
    )
    colnames(ret)[1] <- newcol
    if (!is.null(newnames)) {
      colnames(ret)[-1] <- newnames
    }
  }
  as_tibble(ret)
}

# summary objects -----------------------------------------------------

#' (Deprecated) Tidy summaryDefault objects
#' 
#' Tidiers for summaryDefault objects have been deprecated as of
#' broom 0.7.0 in favor of \code{skimr::skim()}.
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
#' @family deprecated
tidy.summaryDefault <- function(x, ...) {
  .Deprecated(msg = "`tidy.summaryDefault()` is deprecated. Please use `skimr::skim()` instead.")
  ret <- as.data.frame(t(as.matrix(x)))
  cnms <- c("minimum", "q1", "median", "mean", "q3", "maximum")
  if ("NA's" %in% names(x)) {
    cnms <- c(cnms, "na")
  }
  as_tibble(purrr::set_names(ret, cnms))
}

#' @rdname summary_tidiers
#' @export
#' @family deprecated
glance.summaryDefault <- tidy.summaryDefault

#' (Deprecated) Tidy ftable objects
#' 
#' @description This function is deprecated. Please use [tibble::as_tibble()] instead.
#'
#' @param x An `ftable` object returned from [stats::ftable()].
#' @template param_unused_dots
#' 
#' @return An ftable contains a "flat" contingency table. This melts it into a
#'   [tibble::tibble] with one column for each variable, then a `Freq`
#'   column.
#'
#' @export
#' @family deprecated
tidy.ftable <- function(x, ...) {
  .Deprecated()
  as_tibble(x)
}

#' (Deprecated) Tidy density objects
#'
#' @param x A `density` object returned from [stats::density()].
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with two columns: points `x` where the density
#'   is estimated, and estimated density `y`.
#'
#' @export
#' @family deprecated
tidy.density <- function(x, ...) {
  
  as_tibble(x[c("x", "y")])
}

#' (Deprecated) Tidy dist objects
#' 
#' @param x A `dist` object returned from [stats::dist()].
#' @param diagonal Logical indicating whether or not to tidy the diagonal 
#'   elements of the distance matrix. Defaults to whatever was based to the
#'   `diag` argument of [stats::dist()].
#' @param upper Logical indicating whether or not to tidy the upper half of
#'   the distance matrix. Defaults to whatever was based to the
#'   `upper` argument of [stats::dist()].
#' @template param_unused_dots
#'
#' @return A [tibble::tibble] with one row for each pair of items in the
#'   distance matrix, with columns:
#' 
#'   \item{item1}{First item}
#'   \item{item2}{Second item}
#'   \item{distance}{Distance between items}
#' 
#' @details If the distance matrix does not include an upper triangle and/or
#'   diagonal, the tidied version will not either.
#' 
#' @examples
#'
#' cars_dist <- dist(t(mtcars[, 1:4]))
#' cars_dist
#'
#' tidy(cars_dist)
#' tidy(cars_dist, upper = TRUE)
#' tidy(cars_dist, diagonal = TRUE)
#'
#' @export
#' @family deprecated
tidy.dist <- function(x, diagonal = attr(x, "Diag"),
                      upper = attr(x, "Upper"), ...) {
  
  ret <- as.matrix(x) %>%
    tibble::as_tibble(rownames = "item1") %>%
    tidyr::pivot_longer(cols = c(dplyr::everything(), -1)) %>%
    dplyr::rename(item2 = 2, distance = 3) %>%
    dplyr::mutate(item1 = as.factor(item1), item2 = as.factor(item2))
  
  if (!upper) {
    ret <- as.data.frame(ret)[!upper.tri(as.matrix(x)), ]
  }
  
  if (!diagonal) {
    ret <- filter(ret, item1 != item2)
  }
  as_tibble(ret)
}

# vector tidiers ------------------------------------------------------
#' Tidy atomic vectors
#'
#' Vector tidiers are deprecated and will be removed from an upcoming release
#' of broom.
#'
#' Turn atomic vectors into data frames, where the names of the vector (if they
#' exist) are a column and the values of the vector are a column.
#'
#' @param x An object of class "numeric", "integer", "character", or "logical".
#'   Most likely a named vector
#' @param ... Extra arguments (not used)
#'
#' @examples
#'
#' \dontrun{
#' x <- 1:5
#' names(x) <- letters[1:5]
#' tidy(x)
#' }
#' 
#' @export
#' @rdname vector_tidiers
#' @family deprecated
tidy.numeric <- function(x, ...) {
  .Deprecated()
  if (!is.null(names(x))) {
    dplyr::data_frame(names = names(x), x = unname(x))
  } else {
    dplyr::data_frame(x = x)
  }
}

#' @export
#' @rdname vector_tidiers
#' @family deprecated
tidy.character <- tidy.default

#' @export
#' @rdname vector_tidiers
#' @family deprecated
tidy.logical <- function(x, ...) {
  .Deprecated()
  if (!is.null(names(x))) {
    dplyr::data_frame(names = names(x), x = unname(x))
  } else {
    dplyr::data_frame(x = x)
  }
}

# confint_tidy ----------------------------------------------------------------

#' (Deprecated) Calculate confidence interval as a tidy data frame
#' 
#' This function is now deprecated and will be removed from a future
#' release of broom.
#'
#' Return a confidence interval as a tidy data frame. This directly wraps the
#' [confint()] function, but ensures it follows broom conventions:
#' column names of `conf.low` and `conf.high`, and no row names.
#' 
#' `confint_tidy`
#'
#' @param x a model object for which [confint()] can be calculated
#' @param conf.level confidence level
#' @param func A function to compute a confidence interval for `x`. Calling
#'   `func(x, level = conf.level, ...)` must return an object coercible to a
#'   tibble. This dataframe like object should have to columns corresponding
#'   the lower and upper bounds on the confidence interval.
#' @param ... extra arguments passed on to `confint`
#'
#' @return A tibble with two columns: `conf.low` and `conf.high`.
#'
#' @export
#' @family deprecated
confint_tidy <- function(x, conf.level = .95, func = stats::confint, ...) {
  .Deprecated(
    msg = "confint_tidy is now deprecated and will be removed from a future release of broom. Please use the applicable confint method."
  )
  
  # avoid "Waiting for profiling to be done..." message for some models
  ci <- suppressMessages(func(x, level = conf.level, ...))
  
  # protect against confidence intervals returned as named vectors
  if (is.null(dim(ci))) {
    ci <- matrix(ci, nrow = 1)
  }
  
  # remove rows that are all NA. *not the same* as na.omit which checks
  # for any NA.
  all_na <- apply(ci, 1, function(x) all(is.na(x)))
  ci <- ci[!all_na, , drop = FALSE]
  colnames(ci) <- c("conf.low", "conf.high")
  as_tibble(ci)
}

# finish_glance -------------------------------------------------------
#' (Deprecated) Add logLik, AIC, BIC, and other common measurements to a 
#' glance of a prediction
#' 
#' This function is now deprecated in favor of using custom logic and
#' the appropriate \code{nobs()} method.
#'
#'
#' @param ret a one-row data frame (a partially complete glance)
#' @param x the prediction model
#'
#' @return a one-row data frame with additional columns added, such as
#'   \item{logLik}{log likelihoods}
#'   \item{AIC}{Akaike Information Criterion}
#'   \item{BIC}{Bayesian Information Criterion}
#'   \item{deviance}{deviance}
#'   \item{df.residual}{residual degrees of freedom}
#'
#' @export
#' @family deprecated
finish_glance <- function(ret, x) {
  .Deprecated(
    msg = "finish_glance is now deprecated and will be removed from a future release of broom. Please only use the relevant `stats` functions for the given model type as needed."
  )
  ret$logLik <- tryCatch(as.numeric(stats::logLik(x)), error = function(e) NULL)
  ret$AIC <- tryCatch(stats::AIC(x), error = function(e) NULL)
  ret$BIC <- tryCatch(stats::BIC(x), error = function(e) NULL)
  
  # special case for REML objects (better way?)
  if (inherits(x, "lmerMod")) {
    ret$deviance <- tryCatch(stats::deviance(x, REML = FALSE),
                             error = function(e) NULL
    )
  } else {
    ret$deviance <- tryCatch(stats::deviance(x), error = function(e) NULL)
  }
  ret$df.residual <- tryCatch(df.residual(x), error = function(e) NULL)
  
  as_tibble(ret, rownames = NULL)
}
