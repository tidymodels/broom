#' @templateVar class epi.2by2
#' @template title_desc_tidy
#'
#' @param x A `epi.2by2` object produced by a call to [epiR::epi.2by2()]
#' @param parameters Return measures of association (`moa`) or test statistics (`stat`),
#'    default is `moa` (measures of association)
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "term",
#'   estimate = "Estimated measure of association",
#'   "conf.low",
#'   "conf.high",
#'   "statistic",
#'   "df",
#'   "p.value"
#' )
#'
#' @details The tibble has a column for each of the measures of association
#'   or tests contained in `massoc` or `massoc.detail` when [epiR::epi.2by2()] is called.
#'
#' @examplesIf rlang::is_installed("epiR")
#'
#' # load libraries for models and data
#' library(epiR)
#'
#' # generate data
#' dat <- matrix(c(13, 2163, 5, 3349), nrow = 2, byrow = TRUE)
#'
#' rownames(dat) <- c("DF+", "DF-")
#' colnames(dat) <- c("FUS+", "FUS-")
#'
#' # fit model
#' fit <- epi.2by2(
#'   dat = as.table(dat), method = "cross.sectional",
#'   conf.level = 0.95, units = 100, outcome = "as.columns"
#' )
#'
#' # summarize model fit with tidiers
#' tidy(fit, parameters = "moa")
#' tidy(fit, parameters = "stat")
#'
#' @export
#' @seealso [tidy()], [epiR::epi.2by2()]
#' @family epiR tidiers
#' @aliases epiR_tidiers
tidy.epi.2by2 <- function(x, parameters = c("moa", "stat"), ...) {
  epiR_vs <- compareVersion("2.0.26", as.character(packageVersion("epiR")))
  if (epiR_vs %in% c(0, -1)) {
    massoc <- x$massoc.detail
  } else {
    massoc <- x$massoc
  }

  out <- dplyr::bind_rows(
    massoc[names(massoc) != "chi2.correction"],
    .id = "term"
  )
  if (rlang::arg_match(parameters) == "moa") {
    out <- subset(out, !is.na(est), select = c("term", "est", "lower", "upper"))
    colnames(out) <- c("term", "estimate", "conf.low", "conf.high")
    return(tibble::as_tibble(out))
  }

  if (epiR_vs %in% c(0, -1)) {
    if ("p.value" %in% colnames(out)) {
      out$p.value <- with(out, dplyr::coalesce(p.value.2s, p.value))
    } else {
      out$p.value <- out[["p.value.2s"]]
    }
  }

  out <- subset(
    out,
    is.na(est),
    select = c("term", "test.statistic", "df", "p.value")
  )
  colnames(out) <- c("term", "statistic", "df", "p.value")
  tibble::as_tibble(out)
}
