#' @templateVar class nlrq
#' @template title_desc_tidy
#' 
#' @param x A `nlrq` object returned from [quantreg::nlrq()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @aliases nlrq_tidiers 
#' @export
#' @seealso [tidy()], [quantreg::nlrq()]
#' @family quantreg tidiers
tidy.nlrq <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
  nn <- c("estimate", "std.error", "statistic", "p.value")
  ret <- fix_data_frame(coef(summary(x)), nn)
  
  if (conf.int) {
    x_summary <- summary(x)
    a <- (1 - conf.level) / 2
    cv <- qt(c(a, 1 - a), df = x_summary[["rdf"]])
    ret[["conf.low"]] <- ret[["estimate"]] + (cv[1] * ret[["std.error"]])
    ret[["conf.high"]] <- ret[["estimate"]] + (cv[2] * ret[["std.error"]])
  }
  as_tibble(ret)
}

#' @templateVar class nlrq
#' @template title_desc_glance
#' 
#' @inherit tidy.nlrq params examples
#'
#' @evalRd return_glance(
#'   "tau",
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "df.residual"
#' )
#'  
#' @export
#' @seealso [glance()], [quantreg::nlrq()]
#' @family quantreg tidiers
glance.nlrq <- function(x, ...) {
  
  warning("can glance.nlrq return multiple rows?")
  
  n <- length(x[["m"]]$fitted())
  s <- summary(x)
  tibble(
    tau = x[["m"]]$tau(),
    logLik = logLik(x),
    AIC = AIC(x),
    BIC = AIC(x, k = log(n)),
    df.residual = s[["rdf"]]
  )
}

#' @templateVar class nlrq
#' @template title_desc_tidy
#' 
#' @param x A `nlrq` object returned from [quantreg::nlrq()].
#' @inherit augment.nls params examples return
#'  
#' @export
#' @seealso [augment()], [quantreg::nlrq()]
#' @family quantreg tidiers
#' @include stats-nls-tidiers.R
#' 
augment.nlrq <- augment.nls
