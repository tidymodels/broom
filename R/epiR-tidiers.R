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
#'   or tests contained in `massoc.detail` when [epiR::epi.2by2()] is called.
#'
#' @examples
#' 
#' library(epiR)
#' 
#' dat <- matrix(c(13, 2163, 5, 3349), nrow = 2, byrow = TRUE)
#' 
#' rownames(dat) <- c("DF+", "DF-")
#' colnames(dat) <- c("FUS+", "FUS-")
#' 
#' fit <- epi.2by2(
#'   dat = as.table(dat), method = "cross.sectional",
#'   conf.level = 0.95, units = 100, outcome = "as.columns"
#' )
#'
#' tidy(fit, parameters = "moa")
#' tidy(fit, parameters = "stat")
#' 
#' @export
#' @seealso [tidy()], [epiR::epi.2by2()]
#' @family epiR tidiers
#' @aliases epiR_tidiers
tidy.epi.2by2 <- function(x, parameters = c("moa", "stat"), ...) {
  massoc <- x$massoc.detail
  out <- dplyr::bind_rows(massoc[names(massoc) != "chi2.correction"], .id = "term")
  if (rlang::arg_match(parameters) == "moa") {
    out <- subset(out, !is.na(est), select = c(term, est, lower, upper))
    colnames(out) <- c("term", "estimate", "conf.low", "conf.high")
    return(tibble::as_tibble(out))
  }
  
  if ("p.value" %in% colnames(out)) {
    out$p.value.2s <- with(out, dplyr::coalesce(p.value.2s, p.value))
  }
  out <- subset(out, is.na(est), select = c(term, test.statistic, df, p.value.2s))
  colnames(out) <- c("term", "statistic", "df", "p.value")
  tibble::as_tibble(out)
}
