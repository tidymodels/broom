#' @templateVar class kappa
#' @template title_desc_tidy
#'
#' @param x A `kappa` object returned from [psych::cohen.kappa()].
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with columns:
#' 
#'   \item{type}{Either "weighted" or "unweighted"}
#'   \item{estimate}{The estimated value of kappa with this method}
#'   \item{conf.low}{Lower bound of confidence interval}
#'   \item{conf.high}{Upper bound of confidence interval}
#'
#' @details Note that confidence level (alpha) for the confidence interval
#'   cannot be set in `tidy`. Instead you must set the `alpha` argument
#'   to [psych::cohen.kappa()] when creating the `kappa` object.
#'   
#' @examples
#'
#' library(psych)
#'
#' rater1 = 1:9
#' rater2 = c(1, 3, 1, 6, 1, 5, 5, 6, 7)
#' ck <- cohen.kappa(cbind(rater1, rater2))
#'
#' tidy(ck)
#'
#' # graph the confidence intervals
#' library(ggplot2)
#' ggplot(tidy(ck), aes(estimate, type)) +
#'   geom_point() +
#'   geom_errorbarh(aes(xmin = conf.low, xmax = conf.high))
#'
#' @aliases kappa_tidiers psych_tidiers
#' @export
#' @seealso [tidy()], [psych::cohen.kappa()]
#' 
tidy.kappa <- function(x, ...) {
  nn <- c("conf.low", "estimate", "conf.high")
  ret <- fix_data_frame(x$confid, nn, newcol = "type") %>%
    select(type, estimate, conf.low, conf.high) %>%
    mutate(type = gsub(" kappa", "", type))

  ret
}
