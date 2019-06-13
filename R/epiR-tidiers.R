#' @templateVar class epi.2by2
#' @template title_desc_tidy
#'
#' @param x A `epi.2by2` object produced by a call to [epiR::epi.2by2()]
#' @template param_unused_dots
#'
#' @evalRd return_tidy("parameter", estimate = "Estimated measure of association", "conf.low", "conf.high", "statistic", "df", "p.value")
#' 
#' @details The tibble has a column for each of the measures of association or tests contained in `massoc` when 
#'    [epiR::epi.2by2()] is called. 
#'    
#' @examples 
#' 
#' library(epiR)
#' 
#' dat <- matrix(c(13,2163,5,3349), nrow = 2, byrow = TRUE)
#' rownames(dat) <- c("DF+", "DF-")
#' colnames(dat) <- c("FUS+", "FUS-")
#' birthwt$low <- factor(birthwt$low, levels = c(1,0))
#' birthwt$smoke <- factor(birthwt$smoke, levels = c(1,0))
#' birthwt$race <- factor(birthwt$race, levels = c(1,2,3))
#' tab1 <- table(birthwt$smoke, birthwt$low, dnn = c("Smoke", "Low BW"))
#' 
#' tidy(tab1)
#' @export
#' @seealso [tidy()], [epiR::epi.2by2()]
#' @family epiR tidiers
#' @aliases epiR_tidiers
tidy.epi.2by2 <- function(x, ...) {
  s <- summary(x, ...)
  nm <- names(x$massoc)
  tibble(s) %>%
    dplyr::mutate(measure = nm) %>%
    tidyr::unnest() %>%
    dplyr::select(measure, everything()) %>%
    dplyr::rename_all(funs(c("parameter", "estimate", "conf.low", "conf.high", "statistic", "df", "p.value")))
}
