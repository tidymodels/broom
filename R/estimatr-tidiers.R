# This file contains `tidy` methods for the four main `estimatr` objects

tidy_data_frame <- function(object, digits = NULL) {
  vec_cols <- c(
    "coefficients",
    "std.error",
    "statistic",
    "p.value",
    "conf.low",
    "conf.high",
    "df"
  )

  tidy_mat <- do.call("cbind", lapply(object[vec_cols], as.vector))
  vec_cols[vec_cols == "coefficients"] <- "estimate"
  colnames(tidy_mat) <- vec_cols
  return_frame <- data.frame(
    term = object[["term"]],
    tidy_mat,
    stringsAsFactors = FALSE
  )

  return_frame$outcome <- rep(
    object[["outcome"]],
    each = length(object[["term"]])
  )

  rownames(return_frame) <- NULL
  as_tibble(return_frame)
}

warn_singularities <- function(object) {
  if (object$rank < object$k) {
    singularities <- object$k - object$rank
    what <- ifelse(singularities > 1, " coefficients ", " coefficient ")
    message(
      singularities, what,
      " not defined because the design matrix is rank deficient\n"
    )
  }
}

#' Tidy an estimatr object
#' @templateVar class lm_robust
#' @template title_desc_tidy
#' @name estimatr_tidiers
#'
#' @return A [tibble::tibble()] with columns for coefficient names, estimates, standard
#' errors, confidence intervals, p-values, degrees of freedom, and the
#' name of the outcome variable
#'
#' @export
#' @seealso [tidy()], [estimatr::lm_robust()], [estimatr::iv_robust()],  [estimatr::difference_in_means()], [estimatr::horvitz_thompson()]
#' @family estimatr tidiers
tidy.lm_robust <- function(object, ...) {
  warn_singularities(object)
  tidy_data_frame(object)
}

#' @rdname estimatr_tidiers
#' @templateVar class iv_robust
#'
#' @export
#' @family estimatr tidiers
tidy.iv_robust <- function(object, ...) {
  warn_singularities(object)
  tidy_data_frame(object)
}

#' @rdname estimatr_tidiers
#' @templateVar class difference_in_means
#'
#' @export
#' @family estimatr tidiers
tidy.difference_in_means <- tidy_data_frame

#' @rdname estimatr_tidiers
#' @templateVar class horvitz_thompson
#'
#' @export
#' @family estimatr tidiers
tidy.horvitz_thompson <- tidy_data_frame
