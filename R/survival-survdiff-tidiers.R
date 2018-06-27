

#' Tidiers for Tests of Differences between Survival Curves
#'
#' @param x a "survdiff" object
#' @param strata logical, whether to include strata in the output
#' @param ... other arguments passed to/from other methods, currently ignored
#'
#' @seealso [survival::survdiff()]
#'
#' @template boilerplate
#'
#' @name survdiff_tidiers
#'
#' @examples
#' if( require("survival") ) {
#'     s <- survdiff( Surv(time, status) ~ pat.karno + strata(inst), data=lung)
#'     tidy(s)
#'     glance(s)
#' }
NULL


#' @rdname survdiff_tidiers
#'
#' @return
#' `tidy` on "survdiff" objects returns a data frame with the following columns:
#' \item{...}{initial column(s) correspond to grouping factors (right-hand side of the formula)}
#' \item{obs}{weighted observed number of events in each group}
#' \item{exp}{weighted expected number of events in each group}
#' \item{N}{number of subjects in each group}
#'
#' @export
tidy.survdiff <- function(x, strata=FALSE, ...) {
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
  row_list <- lapply(l, function(x)
    structure(
      as.data.frame(lapply(x, "[", 2), stringsAsFactors = FALSE),
      names = sapply(x, "[", 1)
    ))
  gvars <- do.call("rbind", row_list)
  has_strata <- "strata" %in% names(x)
  if (strata && has_strata) {
    .NotYetUsed(strata)
    d_obs <- cbind(gvars, as.data.frame(x$obs)) %>%
      tidyr::gather(strata, obs, dplyr::matches("V[0-9]+")) %>%
      tidyr::extract(strata, "strata", "([0-9]+)")
    d_exp <- cbind(gvars, as.data.frame(x$exp)) %>%
      tidyr::gather(strata, exp, dplyr::matches("V[0-9]+")) %>%
      tidyr::extract(strata, "strata", "([0-9]+)")
    z <- d_obs %>% dplyr::left_join(d_exp)
  } else {
    rval <- data.frame(
      N = as.numeric(x$n),
      obs = if (has_strata) apply(x$obs, 1, sum) else x$obs,
      exp = if (has_strata) apply(x$exp, 1, sum) else x$exp
    )
  }
  as_tibble(bind_cols(gvars, rval))
}




#' @rdname survdiff_tidiers
#'
#' @return
#' `glance` on "survdiff" objects returns a data frame with the following columns:
#' \item{statistic}{value of the test statistic}
#' \item{df}{degrees of freedom}
#' \item{p.value}{p-value}
#'
#'
#' @export
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
