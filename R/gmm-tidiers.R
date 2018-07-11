#' @templateVar class gmm
#' @template title_desc_tidy
#'
#' @param x A `gmm` object returned from [gmm::gmm()].
#' @template param_confint
#' @template param_exponentiate
#' @template param_quick
#' @template param_unused_dots
#' 
#' @template return_tidy_regression
#'
#' @examples
#'
#' if (requireNamespace("gmm", quietly = TRUE)) {
#' 
#'   library(gmm)
#'   
#'   # examples come from the "gmm" package
#'   ## CAPM test with GMM
#'   data(Finance)
#'   r <- Finance[1:300, 1:10]
#'   rm <- Finance[1:300, "rm"]
#'   rf <- Finance[1:300, "rf"]
#'
#'   z <- as.matrix(r-rf)
#'   t <- nrow(z)
#'   zm <- rm-rf
#'   h <- matrix(zm, t, 1)
#'   res <- gmm(z ~ zm, x = h)
#'
#'   # tidy result
#'   tidy(res)
#'   tidy(res, conf.int = TRUE)
#'   tidy(res, conf.int = TRUE, conf.level = .99)
#'
#'   # coefficient plot
#'   library(ggplot2)
#'   library(dplyr)
#'   tidy(res, conf.int = TRUE) %>%
#'     mutate(variable = reorder(variable, estimate)) %>%
#'     ggplot(aes(estimate, variable)) +
#'     geom_point() +
#'     geom_errorbarh(aes(xmin = conf.low, xmax = conf.high)) +
#'     facet_wrap(~ term) +
#'     geom_vline(xintercept = 0, color = "red", lty = 2)
#'
#'   # from a function instead of a matrix
#'   g <- function(theta, x) {
#'   	e <- x[,2:11] - theta[1] - (x[,1] - theta[1]) %*% matrix(theta[2:11], 1, 10)
#'   	gmat <- cbind(e, e*c(x[,1]))
#'   	return(gmat) }
#'
#'   x <- as.matrix(cbind(rm, r))
#'   res_black <- gmm(g, x = x, t0 = rep(0, 11))
#'
#'   tidy(res_black)
#'   tidy(res_black, conf.int = TRUE)
#'
#'   ## APT test with Fama-French factors and GMM
#'
#'   f1 <- zm
#'   f2 <- Finance[1:300, "hml"] - rf
#'   f3 <- Finance[1:300, "smb"] - rf
#'   h <- cbind(f1, f2, f3)
#'   res2 <- gmm(z ~ f1 + f2 + f3, x = h)
#'
#'   td2 <- tidy(res2, conf.int = TRUE)
#'   td2
#'
#'   # coefficient plot
#'   td2 %>%
#'     mutate(variable = reorder(variable, estimate)) %>%
#'     ggplot(aes(estimate, variable)) +
#'     geom_point() +
#'     geom_errorbarh(aes(xmin = conf.low, xmax = conf.high)) +
#'     facet_wrap(~ term) +
#'     geom_vline(xintercept = 0, color = "red", lty = 2)
#' }
#'
#' @export
#' @aliases gmm_tidiers
#' @family gmm tidiers
#' @seealso [tidy()], [gmm::gmm()]
tidy.gmm <- function(x, conf.int = FALSE, conf.level = .95,
                     exponentiate = FALSE, quick = FALSE, ...) {
  if (quick) {
    co <- stats::coef(x)
    ret <- tibble(term = names(co), estimate = unname(co))
  } else {
    co <- stats::coef(summary(x))

    nn <- c("estimate", "std.error", "statistic", "p.value")
    ret <- fix_data_frame(co, nn[1:ncol(co)])
  }

  # newer versions of GMM create a 'confint' object, so we can't use process_lm
  ret <- process_lm(ret, x,
    conf.int = FALSE, conf.level = conf.level,
    exponentiate = exponentiate
  )
  if (conf.int) {
    CI <- suppressMessages(stats::confint(x, level = conf.level))
    if (!is.matrix(CI)) CI <- CI$test
    colnames(CI) <- c("conf.low", "conf.high")
    trans <- if (exponentiate) exp else identity
    ret <- cbind(ret, trans(unrowname(CI)))
  }
  if (all(grepl("_", ret$term))) {
    # separate the variable and term
    ret <- tidyr::separate(ret, term, c("variable", "term"), sep = "_", extra = "merge")
  }

  as_tibble(ret)
}


#' @templateVar class gmm
#' @template title_desc_glance
#' 
#' @inheritParams tidy.gmm
#'
#' @return A one-row [tibble::tibble] with columns:
#'   \item{df}{Degrees of freedom}
#'   \item{statistic}{Statistic from J-test for E(g)=0}
#'   \item{p.value}{P-value from J-test}
#'   \item{df.residual}{Residual degrees of freedom, if included in `x`.}
#'
#' @export
#' @family gmm tidiers
#' @seealso [glance()], [gmm::gmm()]
glance.gmm <- function(x, ...) {
  s <- gmm::summary.gmm(x)
  st <- suppressWarnings(as.numeric(s$stest$test))
  ret <- tibble(df = x$df, statistic = st[1], p.value = st[2])
  finish_glance(ret, x)
}
