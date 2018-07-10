#' @templateVar class cch
#' @template title_desc_tidy
#'
#' @param x An `cch` object returned from [survival::cch()].
#' @param conf.level confidence level for CI
#' @template param_unused_dots
#' 
#' @template return_tidy_regression
#'
#' @examples
#'
#' library(survival)
#' 
#' # examples come from cch documentation
#' subcoh <- nwtco$in.subcohort
#' selccoh <- with(nwtco, rel==1|subcoh==1)
#' ccoh.data <- nwtco[selccoh,]
#' ccoh.data$subcohort <- subcoh[selccoh]
#' ## central-lab histology
#' ccoh.data$histol <- factor(ccoh.data$histol,labels=c("FH","UH"))
#' ## tumour stage
#' ccoh.data$stage <- factor(ccoh.data$stage,labels=c("I","II","III" ,"IV"))
#' ccoh.data$age <- ccoh.data$age/12 # Age in years
#'
#' fit.ccP <- cch(Surv(edrel, rel) ~ stage + histol + age, data = ccoh.data,
#'                subcoh = ~subcohort, id= ~seqno, cohort.size = 4028)
#'
#' tidy(fit.ccP)
#'
#' # coefficient plot
#' library(ggplot2)
#' ggplot(tidy(fit.ccP), aes(x = estimate, y = term)) +
#'   geom_point() +
#'   geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), height = 0) +
#'   geom_vline(xintercept = 0)
#'
#' @aliases cch_tidiers
#' @export
#' @seealso [tidy()], [survival::cch()]
#' @family cch tidiers
#' @family survival tidiers
tidy.cch <- function(x, conf.level = .95, ...) {
  s <- summary(x)
  co <- stats::coefficients(s)
  ret <- fix_data_frame(co, newnames = c("estimate", "std.error", "statistic", "p.value"))
  
  # add confidence interval
  ci <- unrowname(stats::confint(x, level = conf.level))
  colnames(ci) <- c("conf.low", "conf.high")
  as_tibble(cbind(ret, ci))
}


#' @templateVar class cch
#' @template title_desc_glance
#' 
#' @inheritParams tidy.cch
#' 
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{score}{score}
#'   \item{rscore}{rscore}
#'   \item{p.value}{p-value from Wald test}
#'   \item{iter}{number of iterations}
#'   \item{n}{number of predictions}
#'   \item{nevent}{number of events}
#'
#' @export
#' @seealso [glance()], [survival::cch()]
#' @family cch tidiers
#' @family survival tidiers
glance.cch <- function(x, ...) {
  ret <- compact(unclass(x)[c(
    "score", "rscore", "wald.test", "iter",
    "n", "nevent"
  )])
  ret <- as_tibble(ret)
  rename(ret, p.value = wald.test)
}
