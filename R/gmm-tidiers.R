#' @templateVar class gmm
#' @template title_desc_tidy
#'
#' @param x A `gmm` object returned from [gmm::gmm()].
#' @template param_confint
#' @template param_exponentiate
#' @template param_unused_dots
#' 
#' @evalRd return_tidy(regression = TRUE)
#'
#' @examples
#' 
#' library(gmm)
#' 
#' # examples come from the "gmm" package
#' ## CAPM test with GMM
#' data(Finance)
#' r <- Finance[1:300, 1:10]
#' rm <- Finance[1:300, "rm"]
#' rf <- Finance[1:300, "rf"]
#'
#' z <- as.matrix(r-rf)
#' t <- nrow(z)
#' zm <- rm-rf
#' h <- matrix(zm, t, 1)
#' res <- gmm(z ~ zm, x = h)
#'
#' # tidy result
#' tidy(res)
#' tidy(res, conf.int = TRUE)
#' tidy(res, conf.int = TRUE, conf.level = .99)
#'
#' # coefficient plot
#' library(ggplot2)
#' library(dplyr)
#' 
#' tidy(res, conf.int = TRUE) %>%
#'   mutate(variable = reorder(term, estimate)) %>%
#'   ggplot(aes(estimate, variable)) +
#'   geom_point() +
#'   geom_errorbarh(aes(xmin = conf.low, xmax = conf.high)) +
#'   geom_vline(xintercept = 0, color = "red", lty = 2)
#'
#' # from a function instead of a matrix
#' g <- function(theta, x) {
#' 	e <- x[,2:11] - theta[1] - (x[,1] - theta[1]) %*% matrix(theta[2:11], 1, 10)
#' 	gmat <- cbind(e, e*c(x[,1]))
#' 	return(gmat) }
#'
#' x <- as.matrix(cbind(rm, r))
#' res_black <- gmm(g, x = x, t0 = rep(0, 11))
#'
#' tidy(res_black)
#' tidy(res_black, conf.int = TRUE)
#'
#' ## APT test with Fama-French factors and GMM
#'
#' f1 <- zm
#' f2 <- Finance[1:300, "hml"] - rf
#' f3 <- Finance[1:300, "smb"] - rf
#' h <- cbind(f1, f2, f3)
#' res2 <- gmm(z ~ f1 + f2 + f3, x = h)
#'
#' td2 <- tidy(res2, conf.int = TRUE)
#' td2
#'
#' # coefficient plot
#' td2 %>%
#'   mutate(variable = reorder(term, estimate)) %>%
#'   ggplot(aes(estimate, variable)) +
#'   geom_point() +
#'   geom_errorbarh(aes(xmin = conf.low, xmax = conf.high)) +
#'   geom_vline(xintercept = 0, color = "red", lty = 2)
#'
#' @export
#' @aliases gmm_tidiers
#' @family gmm tidiers
#' @seealso [tidy()], [gmm::gmm()]
tidy.gmm <- function(x, conf.int = FALSE, conf.level = .95,
                     exponentiate = FALSE, ...) {
  
  coef <- summary(x)$coefficients
  ret <- as_tibble(coef, rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")
  
  if (conf.int) {
    # non-standard confint return object, so can't use
    # broom_confint_terms() like we'd hope
    
    ci <- confint(x, level = conf.level)$test
    ci <- as_tibble(ci, rownames = "term")
    colnames(ci) <- c("term", "conf.low", "conf.high")
    ret <- dplyr::left_join(ret, ci, by = "term")
  }
  
  if (exponentiate)
    ret <- exponentiate(ret)
  
  ret
}

#' @templateVar class gmm
#' @template title_desc_glance
#' 
#' @inherit tidy.gmm params examples
#'
#' @evalRd return_glance("df", 
#'                       "statistic", 
#'                       "p.value", 
#'                       "df.residual", 
#'                       "nobs")
#'
#' @export
#' @family gmm tidiers
#' @seealso [glance()], [gmm::gmm()]
glance.gmm <- function(x, ...) {
  s <- summary(x)
  
  # TODO: why do we suppress warnings here?
  st <- suppressWarnings(as.numeric(s$stest$test))
  tibble(
    df = x$df, 
    statistic = st[1], 
    p.value = st[2],
    df.residual = stats::df.residual(x),
    nobs = stats::nobs(x)
  )
}
