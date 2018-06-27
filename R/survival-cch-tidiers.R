
#' tidiers for case-cohort data
#'
#' Tidiers for case-cohort analyses: summarize each estimated coefficient,
#' or test the overall model.
#'
#' @param x a "cch" object
#' @param conf.level confidence level for CI
#' @param ... extra arguments (not used)
#'
#' @details It is not clear what an `augment` method would look like,
#' so none is provided. Nor is there currently any way to extract the
#' covariance or the residuals.
#'
#' @template boilerplate
#'
#' @examples
#'
#' if (require("survival", quietly = TRUE)) {
#'     # examples come from cch documentation
#'     subcoh <- nwtco$in.subcohort
#'     selccoh <- with(nwtco, rel==1|subcoh==1)
#'     ccoh.data <- nwtco[selccoh,]
#'     ccoh.data$subcohort <- subcoh[selccoh]
#'     ## central-lab histology
#'     ccoh.data$histol <- factor(ccoh.data$histol,labels=c("FH","UH"))
#'     ## tumour stage
#'     ccoh.data$stage <- factor(ccoh.data$stage,labels=c("I","II","III" ,"IV"))
#'     ccoh.data$age <- ccoh.data$age/12 # Age in years
#'
#'     fit.ccP <- cch(Surv(edrel, rel) ~ stage + histol + age, data = ccoh.data,
#'                    subcoh = ~subcohort, id= ~seqno, cohort.size = 4028)
#'
#'     tidy(fit.ccP)
#'
#'     # coefficient plot
#'     library(ggplot2)
#'     ggplot(tidy(fit.ccP), aes(x = estimate, y = term)) + geom_point() +
#'         geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), height = 0) +
#'         geom_vline(xintercept = 0)
#'
#'     # compare between methods
#'     library(dplyr)
#'     fits <- data_frame(method = c("Prentice", "SelfPrentice", "LinYing")) %>%
#'         group_by(method) %>%
#'         do(tidy(cch(Surv(edrel, rel) ~ stage + histol + age, data = ccoh.data,
#'                     subcoh = ~subcohort, id= ~seqno, cohort.size = 4028,
#'                     method = .$method)))
#'
#'     # coefficient plots comparing methods
#'     ggplot(fits, aes(x = estimate, y = term, color = method)) + geom_point() +
#'         geom_errorbarh(aes(xmin = conf.low, xmax = conf.high)) +
#'         geom_vline(xintercept = 0)
#' }
#'
#' @seealso [cch]
#'
#' @name cch_tidiers


#' @rdname cch_tidiers
#'
#' @template coefficients
#'
#' @export
tidy.cch <- function(x, conf.level = .95, ...) {
  s <- summary(x)
  co <- stats::coefficients(s)
  ret <- fix_data_frame(co, newnames = c("estimate", "std.error", "statistic", "p.value"))
  
  # add confidence interval
  ci <- unrowname(stats::confint(x, level = conf.level))
  colnames(ci) <- c("conf.low", "conf.high")
  as_tibble(cbind(ret, ci))
}


#' @rdname cch_tidiers
#'
#' @return `glance` returns a one-row data.frame with the following
#' columns:
#'   \item{score}{score}
#'   \item{rscore}{rscore}
#'   \item{p.value}{p-value from Wald test}
#'   \item{iter}{number of iterations}
#'   \item{n}{number of predictions}
#'   \item{nevent}{number of events}
#'
#' @export
glance.cch <- function(x, ...) {
  ret <- compact(unclass(x)[c(
    "score", "rscore", "wald.test", "iter",
    "n", "nevent"
  )])
  ret <- as_tibble(ret)
  rename(ret, p.value = wald.test)
}
