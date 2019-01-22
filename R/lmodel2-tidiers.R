#' @templateVar class lmodel2
#' @template title_desc_tidy
#' 
#' @param x A `lmodel2` object returned by [lmodel2::lmodel2()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "term",
#'   "estimate",
#'   "p.value",
#'   "conf.low",
#'   "conf.high",
#'   method = "Either OLS/MA/SMA/RMA"
#' )
#'
#' @details There are always only two terms in an `lmodel2`: `"Intercept"`
#'   and `"Slope"`. These are computed by four methods: OLS
#'   (ordinary least squares), MA (major axis), SMA (standard major
#'   axis), and RMA (ranged major axis).
#'
#' @examples
#' 
#' library(lmodel2)
#' 
#' data(mod2ex2)
#' Ex2.res <- lmodel2(Prey ~ Predators, data=mod2ex2, "relative", "relative", 99)
#' Ex2.res
#'
#' tidy(Ex2.res)
#' glance(Ex2.res)
#'
#' # this allows coefficient plots with ggplot2
#' library(ggplot2)
#' ggplot(tidy(Ex2.res), aes(estimate, term, color = method)) +
#'   geom_point() +
#'   geom_errorbarh(aes(xmin = conf.low, xmax = conf.high)) +
#'   geom_errorbarh(aes(xmin = conf.low, xmax = conf.high))
#'
#' @export
#' @seealso [tidy()], [lmodel2::lmodel2()]
#' @aliases lmodel2_tidiers
#' @family lmodel2 tidiers
tidy.lmodel2 <- function(x, ...) {
  ret <- x$regression.results[c(1:3, 5)] %>%
    select(method = Method, Intercept, Slope, p.value = quote("P-perm (1-tailed)")) %>%
    tidyr::gather(term, estimate, -method, -p.value) %>%
    arrange(method, term)

  # add confidence intervals
  confints <- x$confidence.intervals %>%
    tidyr::gather(key, value, -Method) %>%
    tidyr::separate(key, c("level", "term"), "-") %>%
    mutate(level = ifelse(level == "2.5%", "conf.low", "conf.high")) %>%
    tidyr::spread(level, value) %>%
    select(method = Method, term, conf.low, conf.high)

  ret %>%
    inner_join(confints, by = c("method", "term")) %>% 
    select(p.value, dplyr::everything()) %>% 
    as_tibble()
}


#' @templateVar class lmodel2
#' @template title_desc_glance
#' 
#' @inherit tidy.lmodel2 params examples
#' 
#' @evalRd return_glance(
#'   "r.squared",
#'   "p.value",
#'   theta = "Angle between OLS lines `lm(y ~ x)` and `lm(x ~ y)`",
#'   H = "H statistic for computing confidence interval of major axis slope"
#' )
#'
#' @export
#' @seealso [glance()], [lmodel2::lmodel2()]
#' @family lmodel2 tidiers
#' 
glance.lmodel2 <- function(x, ...) {
  tibble(
    r.squared = x$rsquare,
    theta = x$theta,
    p.value = x$P.param,
    H = x$H
  )
}
