#' @templateVar class survdiff
#' @template title_desc_tidy
#'
#' @param x An `survdiff` object returned from [survival::survdiff()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy("obs", "exp", "N")
#'
#' @examples
#' 
#' if (requireNamespace("survival", quietly = TRUE)) {
#'
#' library(survival)
#'
#' s <- survdiff(
#'   Surv(time, status) ~ pat.karno + strata(inst),
#'   data = lung
#' )
#'
#' tidy(s)
#' glance(s)
#' 
#' }
#' 
#' @aliases survdiff_tidiers
#' @export
#' @seealso [tidy()], [survival::survdiff()]
#' @family survdiff tidiers
#' @family survival tidiers
tidy.survdiff <- function(x, ...) {
  # if one-sample test
  if (length(x$obs) == 1) {
    return(
      tibble(
        N = x$n,
        obs = x$obs,
        exp = x$exp
      )
    )
  }
  # grouping variables (unless one-sample test)
  l <- lapply(strsplit(rownames(x$n), ", "), strsplit, "=")
  row_list <- lapply(l, function(x) {
    structure(
      as.data.frame(lapply(x, "[", 2), stringsAsFactors = FALSE),
      names = sapply(x, "[", 1)
    )
  })
  gvars <- do.call("rbind", row_list)
  has_strata <- "strata" %in% names(x)
  rval <- data.frame(
    N = as.numeric(x$n),
    obs = if (has_strata) apply(x$obs, 1, sum) else x$obs,
    exp = if (has_strata) apply(x$exp, 1, sum) else x$exp
  )
  as_tibble(bind_cols(gvars, rval))
}


#' @templateVar class survdiff
#' @template title_desc_glance
#'
#' @inherit tidy.survdiff params examples
#'
#' @evalRd return_glance("statistic", "df", "p.value")
#'
#' @export
#' @seealso [glance()], [survival::survdiff()]
#' @family survdiff tidiers
#' @family survival tidiers
glance.survdiff <- function(x, ...) {
  e <- x$exp
  if (is.matrix(e)) {
    tmp <- apply(e, 1, sum)
  } else {
    tmp <- e
  }
  rval <- tibble(
    statistic = x$chisq,
    df = (sum(1 * (tmp > 0))) - 1
  )
  rval$p.value <- 1 - stats::pchisq(rval$statistic, rval$df)
  rval
}
