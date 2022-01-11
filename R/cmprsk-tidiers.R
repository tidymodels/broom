#' @templateVar class cmprsk
#' @template title_desc_tidy
#'
#' @param x A `crr` object returned from [cmprsk::crr()].
#' @template param_confint
#' @template param_exponentiate
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "estimate",
#'   "std.error",
#'   "statistic",
#'   "p.value",
#'   "conf.low",
#'   "conf.high"
#' )
#'
#' @examples
#' 
#' # feel free to ignore the following line—it allows {broom} to supply 
#' # examples without requiring the model-supplying package to be installed.
#' if (requireNamespace("cmprsk", quietly = TRUE)) {
#'
#' library(cmprsk)
#' 
#' # time to loco-regional failure (lrf)
#' lrf_time <- rexp(100) 
#' lrf_event <- sample(0:2, 100, replace = TRUE) 
#' trt <- sample(0:1, 100, replace = TRUE)
#' strt <- sample(1:2, 100, replace = TRUE)
#' 
#' # fit model
#' x <- crr(lrf_time, lrf_event, cbind(trt, strt))
#' 
#' # summarize model fit with tidiers
#' tidy(x, conf.int = TRUE)
#' glance(x)
#' 
#' }
#'
#' @aliases cmprsk_tidiers
#' @export
#' @seealso [tidy()], [cmprsk::crr()]
#' @family cmprsk tidiers
tidy.crr <- function(x, exponentiate = FALSE, conf.int = FALSE,
                       conf.level = .95, ...) {
 
  s <- summary(x, conf.int = conf.level)
  ret <- as_tidy_tibble(
    s$coef,
    new_names = c("estimate", "estimate_exp", "std.error", "statistic", "p.value"))[, -3]

  if (conf.int) {
    ci <- as_tidy_tibble(
      log(s$conf.int),
      new_names = c("estimate_exp", "estimate_neg_exp", "conf.low", "conf.high"))[, -c(2, 3)]
    ret <- dplyr::left_join(ret, ci, by = "term")
  }

  if (exponentiate) {
    ret <- exponentiate(ret)
  }

  ret
}


#' @templateVar class crr
#' @template title_desc_glance
#'
#' @inherit tidy.crr params examples
#'
#' @evalRd return_glance(
#'    "converged",
#'    "logLik",
#'    "nobs",
#'    "df",
#'    "statistic")
#'
#' @export
#' @seealso [glance()], [cmprsk::crr()]
#' @family crr tidiers
#' @family cmprsk tidiers
glance.crr <- function(x, ...) {
  s <- summary(x)
  as_glance_tibble(
    converged = x$converged,
    logLik = x$loglik,
    nobs = x$n,
    df = s$logtest["df"],
    statistic = s$logtest["test"],
    na_types = "lriir"
  )
}
