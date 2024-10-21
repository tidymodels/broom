#' @templateVar class factanal
#' @template title_desc_tidy
#'
#' @param x A `factanal` object created by [stats::factanal()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "variable",
#'   uniqueness = "Proportion of residual, or unexplained variance",
#'   flX = "Factor loading for level X."
#' )
#'
#' @examples
#'
#' set.seed(123)
#'
#' # generate data
#' library(dplyr)
#' library(purrr)
#'
#' m1 <- tibble(
#'   v1 = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 4, 5, 6),
#'   v2 = c(1, 2, 1, 1, 1, 1, 2, 1, 2, 1, 3, 4, 3, 3, 3, 4, 6, 5),
#'   v3 = c(3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 4, 6),
#'   v4 = c(3, 3, 4, 3, 3, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 5, 6, 4),
#'   v5 = c(1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 6, 4, 5),
#'   v6 = c(1, 1, 1, 2, 1, 3, 3, 3, 4, 3, 1, 1, 1, 2, 1, 6, 5, 4)
#' )
#'
#' # new data
#' m2 <- map_dfr(m1, rev)
#'
#' # factor analysis objects
#' fit1 <- factanal(m1, factors = 3, scores = "Bartlett")
#' fit2 <- factanal(m1, factors = 3, scores = "regression")
#'
#' # tidying the object
#' tidy(fit1)
#' tidy(fit2)
#'
#' # augmented dataframe
#' augment(fit1)
#' augment(fit2)
#'
#' # augmented dataframe (with new data)
#' augment(fit1, data = m2)
#' augment(fit2, data = m2)
#'
#' @aliases factanal_tidiers
#' @export
#' @seealso [tidy()], [stats::factanal()]
#' @family factanal tidiers

tidy.factanal <- function(x, ...) {
  # as.matrix() causes this to break. unsure if this is a hack or appropriate
  loadings <- stats::loadings(x)
  class(loadings) <- "matrix"

  tidy_df <- data.frame(
    variable = rownames(loadings),
    uniqueness = x$uniquenesses,
    data.frame(loadings)
  ) %>%
    as_tibble()

  tidy_df$variable <- as.character(tidy_df$variable)

  # Remove row names and clean column names
  colnames(tidy_df) <- gsub("Factor", "fl", colnames(tidy_df))

  tidy_df
}

#' @templateVar class factanal
#' @template title_desc_augment
#'
#' @inheritParams tidy.factanal
#' @template param_data
#'
#' @return When `data` is not supplied `augment.factanal` returns one
#'   row for each observation, with a factor score column added for each factor
#'   X, (`.fsX`). This is because [stats::factanal()], unlike other
#'   stats methods like [stats::lm()], does not retain the original data.
#'
#' When `data` is supplied, `augment.factanal` returns one row for
#' each observation, with a factor score column added for each factor X,
#' (`.fsX`).
#'
#' @export
#' @seealso [augment()], [stats::factanal()]
#' @family factanal tidiers
augment.factanal <- function(x, data, ...) {
  check_ellipses("newdata", "augment", "factanal", ...)

  scores <- x$scores

  # Check scores were computed
  if (is.null(scores)) {
    stop(
      "Cannot augment factanal objects fit with `scores = 'none'`.",
      call. = FALSE
    )
  }

  # Place relevant values into a tidy data frame
  if (has_rownames(scores)) {
    tidy_df <- data.frame(.rownames = rownames(scores), data.frame(scores)) %>%
      as_tibble() %>%
      dplyr::mutate(.rownames = as.character(.rownames))
  } else {
    tidy_df <- tibble::rownames_to_column(as.data.frame(scores), var = ".rownames") %>%
      as_tibble() %>%
      dplyr::mutate(.rownames = as.character(.rownames))
  }

  colnames(tidy_df) <- gsub("Factor", ".fs", colnames(tidy_df))

  # Check if original data provided
  if (missing(data)) {
    return(tidy_df)
  } else {
    data <- tibble::rownames_to_column(as.data.frame(data), var = ".rownames") %>%
      as_tibble() %>%
      dplyr::mutate(.rownames = as.character(.rownames))
  }

  # Bind to data
  tidy_df <- tidy_df %>%
    dplyr::right_join(x = ., y = data, by = ".rownames")

  # select all columns with name pattern `.fs` and move them to the end of the
  # augmented dataframe
  tidy_df %>%
    dplyr::select(
      .rownames, dplyr::everything(),
      -dplyr::matches("\\.fs[0-9]*"), dplyr::matches("\\.fs[0-9]*")
    )
}

#' @templateVar class factanal
#' @template title_desc_glance
#'
#' @inherit tidy.factanal params examples
#'
#' @evalRd return_glance(
#'   "n.factors",
#'   "total.variance",
#'   "statistic",
#'   "p.value",
#'   "df",
#'   "n",
#'   "method",
#'   "converged",
#'   "nobs"
#' )
#'
#' @export
#'
#' @seealso [glance()], [stats::factanal()]
#' @family factanal tidiers
glance.factanal <- function(x, ...) {
  # Compute total variance accounted for by all factors
  loadings <- stats::loadings(x)
  class(loadings) <- "matrix"
  total.variance <- sum(apply(loadings, 2, function(i) sum(i^2) / length(i)))

  # Results as single-row data frame
  as_glance_tibble(
    n.factors = x$factors,
    total.variance = total.variance,
    statistic = unname(x$STATISTIC),
    p.value = unname(x$PVAL),
    df = x$dof,
    n = x$n.obs,
    method = x$method,
    converged = x$converged,
    nobs = stats::nobs(x),
    na_types = "irrriicli"
  )
}
