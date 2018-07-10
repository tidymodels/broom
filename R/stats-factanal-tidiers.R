#' @templateVar class factanal
#' @template title_desc_tidy
#'
#' @param x A `factanal` object created by [stats::factanal()].
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with one row for each variable used in the 
#'   analysis and columns:
#'   
#'   \item{variable}{The variable being estimated in the factor analysis}
#'   \item{uniqueness}{Proportion of residual, or unexplained variance}
#'   \item{flX}{Factor loading of term on factor X. There will be as many
#'     columns of this format as there were factors fitted.}
#'
#' @examples
#'
#' mod <- factanal(mtcars, 3, scores = "regression")
#'
#' glance(mod)
#' tidy(mod)
#' augment(mod)
#' augment(mod, mtcars)
#'
#' @aliases factanal_tidiers
#' @export
#' @seealso [tidy()], [stats::factanal()]
#' @family factanal tidiers
#' 
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
#'   X, (`.fsX`). This is because [factanal()], unlike other
#'   stats methods like [lm()], does not retain the original data.
#'
#' When `data` is supplied, `augment.factanal` returns one row for
#' each observation, with a factor score column added for each factor X,
#' (`.fsX`).
#'
#' @export
#' @seealso [augment()], [stats::factanal()]
#' @family factanal tidiers
augment.factanal <- function(x, data, ...) {
  scores <- x$scores

  # Check scores were computed
  if (is.null(scores)) {
    stop(
      "Cannot augment factanal objects fit with `scores = 'none'`.",
      call. = FALSE
      )
  }

  # Place relevant values into a tidy data frame
  tidy_df <- data.frame(.rownames = rownames(scores), data.frame(scores)) %>%
    as_tibble()

  colnames(tidy_df) <- gsub("Factor", ".fs", colnames(tidy_df))

  # Check if original data provided
  if (missing(data)) {
    return(tidy_df)
  }

  # Bind to data
  data$.rownames <- rownames(data)
  tidy_df <- tidy_df %>% 
    dplyr::right_join(data, by = ".rownames")

  tidy_df %>% 
    dplyr::select(
      .rownames, everything(),
      -matches("\\.fs[0-9]*"), matches("\\.fs[0-9]*")
    )
}

#' @templateVar class factanal
#' @template title_desc_glance
#' 
#' @inheritParams tidy.factanal
#'
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{n.factors}{The number of fitted factors}
#'   \item{total.variance}{Total cumulative proportion of variance accounted
#'     for by all factors}
#'   \item{statistic}{Significance-test statistic}
#'   \item{p.value}{p-value from the significance test, describing whether the
#'     covariance matrix estimated from the factors is significantly different
#'     from the observed covariance matrix}
#'   \item{df}{Degrees of freedom used by the factor analysis}
#'   \item{n}{Sample size used in the analysis}
#'   \item{method}{The estimation method; always Maximum Likelihood, "mle"}
#'   \item{converged}{Whether the factor analysis converged}
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
  tibble(
    n.factors = x$factors,
    total.variance = total.variance,
    statistic = unname(x$STATISTIC),
    p.value = unname(x$PVAL),
    df = x$dof,
    n = x$n.obs,
    method = x$method,
    converged = x$converged
  )
}
