#' Tidying methods for a brms model
#' 
#' `brms` tidiers will soon be deprecated in `broom` and there is no ongoing
#' development of these functions at this time. `brms` tidiers are being
#' developed in the `broom.mixed` package, which is not yet on CRAN.
#'
#' These methods tidy the estimates from
#' [brms::brmsfit()]
#' (fitted model objects from the \pkg{brms} package) into a summary.
#'
#' @return All tidying methods return a `data.frame` without rownames.
#' The structure depends on the method chosen.
#'
#' @seealso [brms::brms()], [brms::brmsfit()]
#'
#' @name brms_tidiers
#'
#' @param x Fitted model object from the \pkg{brms} package. See
#'   [brms::brmsfit-class()].
#' @examples
#' \dontrun{
#'  library(brms)
#'  fit <- brm(mpg ~ wt + (1|cyl) + (1+wt|gear), data = mtcars,
#'             iter = 500, chains = 2)
#'  tidy(fit)
#'  tidy(fit, parameters = "^sd_", intervals = FALSE)
#'  tidy(fit, par_type = "non-varying")
#'  tidy(fit, par_type = "varying")
#'  tidy(fit, par_type = "hierarchical", robust = TRUE)
#' }
#'
NULL

#' @rdname brms_tidiers
#' @param parameters Names of parameters for which a summary should be
#'   returned, as given by a character vector or regular expressions.
#'   If `NA` (the default) summarized parameters are specified
#'   by the `par_type` argument.
#' @param par_type One of `"all"`, `"non-varying"`,
#'   `"varying"`, or `"hierarchical"` (can be abbreviated).
#'   See the Value section for details.
#' @param robust Whether to use median and median absolute deviation rather
#'   than mean and standard deviation.
#' @param intervals If `TRUE` columns for the lower and upper bounds of
#'   posterior uncertainty intervals are included.
#' @param prob Defines the range of the posterior uncertainty intervals,
#'  such that `100 * prob`\% of the parameter's posterior distribution
#'  lies within the corresponding interval.
#'  Only used if `intervals = TRUE`.
#' @param ... Extra arguments, not used
#'
#' @return
#' When `parameters = NA`, the `par_type` argument is used
#' to determine which parameters to summarize.
#'
#' Generally, `tidy.brmsfit` returns
#' one row for each coefficient, with at least three columns:
#' \item{term}{The name of the model parameter.}
#' \item{estimate}{A point estimate of the coefficient (mean or median).}
#' \item{std.error}{A standard error for the point estimate (sd or mad).}
#'
#' When `par_type = "non-varying"`, only population-level
#' effects are returned.
#'
#' When `par_type = "varying"`, only group-level effects are returned.
#' In this case, two additional columns are added:
#' \item{group}{The name of the grouping factor.}
#' \item{level}{The name of the level of the grouping factor.}
#'
#' Specifying `par_type = "hierarchical"` selects the
#' standard deviations and correlations of the group-level parameters.
#'
#' If `intervals = TRUE`, columns for the `lower` and
#' `upper` bounds of the posterior intervals computed.
#'
#' @export
tidy.brmsfit <- function(x, parameters = NA,
                         par_type = c("all", "non-varying", "varying", "hierarchical"),
                         robust = FALSE, intervals = TRUE, prob = 0.9, ...) {
  use_par_type <- anyNA(parameters)
  if (use_par_type) {
    par_type <- match.arg(par_type)
    if (par_type == "all") {
      parameters <- NA
    } else if (par_type == "non-varying") {
      parameters <- "^b_"
    } else if (par_type == "varying") {
      parameters <- "^r_"
    } else if (par_type == "hierarchical") {
      parameters <- c("^sd_", "^cor_")
    }
  }
  samples <- brms::posterior_samples(x, parameters)
  if (is.null(samples)) {
    stop("No parameter name matches the specified pattern.",
      call. = FALSE
    )
  }
  out <- data.frame(term = names(samples), stringsAsFactors = FALSE)
  if (use_par_type) {
    if (par_type == "non-varying") {
      out$term <- gsub("^b_", "", out$term)
    } else if (par_type == "varying") {
      out$term <- gsub("^r_", "", out$term)
      out$group <- gsub("\\[.*", "", out$term)
      out$level <- gsub(".*\\[|,.*", "", out$term)
      out$term <- gsub(".*,|\\]", "", out$term)
    }
    # no renaming if par_type %in% c("all", "hierarchical")
  }
  if (robust) {
    out$estimate <- apply(samples, 2, stats::median)
    out$std.error <- apply(samples, 2, stats::mad)
  } else {
    out$estimate <- apply(samples, 2, base::mean)
    out$std.error <- apply(samples, 2, stats::sd)
  }
  if (intervals) {
    stopifnot(length(prob) == 1L)
    probs <- c((1 - prob) / 2, 1 - (1 - prob) / 2)
    out[, c("lower", "upper")] <-
      t(apply(samples, 2, stats::quantile, probs = probs))
  }
  out
}
