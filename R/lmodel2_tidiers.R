#' Tidiers for linear model II objects from the lmodel2 package
#' 
#' Tidy or glance an lmodel2 object. An lmodel2 represents model II simple
#' linear regression, where both variables in the regression equation are
#' random.
#' 
#' @param x lmodel2 object
#' @param ... Extra arguments, not used
#' 
#' @details Note that unlike linear regression, there are always only two terms
#' in an lmodel2: Intercept and Slope. Furthermore, these are computed by four
#' methods: OLS (ordinary least squares), MA (major axis), SMA (standard major
#' axis), and RMA (ranged major axis). See the lmodel2 documentation for more.
#' 
#' Note that there is no \code{augment} method for lmodel2 objects because
#' lmodel2 does not provide a \code{predict} or {\code{residuals}} method
#' (and since when both observations are random, fitted values and residuals
#' have a less clear meaning).
#' 
#' @template boilerplate
#' 
#' @return \code{tidy} returns a data frame with one row for each combination
#' of method (OLS/MA/SMA/RMA) and term (always Intercept/Slope). Its columns
#' are:
#' \describe{
#'   \item{method}{Either OLS/MA/SMA/RMA}
#'   \item{term}{Either "Intercept" or "Slope"}
#'   \item{estimate}{Estimated coefficient}
#'   \item{conf.low}{Lower bound of 95\% confidence interval}
#'   \item{conf.high}{Upper bound of 95\% confidence interval}
#' }
#' 
#' @examples
#' 
#' if (require("lmodel2", quietly = TRUE)) {
#'   data(mod2ex2)
#'   Ex2.res <- lmodel2(Prey ~ Predators, data=mod2ex2, "relative", "relative", 99)
#'   Ex2.res
#' 
#'   tidy(Ex2.res)
#'   glance(Ex2.res)
#' 
#'   # this allows coefficient plots with ggplot2
#'   library(ggplot2)
#'   ggplot(tidy(Ex2.res), aes(estimate, term, color = method)) +
#'     geom_point() +
#'     geom_errorbarh(aes(xmin = conf.low, xmax = conf.high)) +
#'     geom_errorbarh(aes(xmin = conf.low, xmax = conf.high))
#' }
#' 
#' @name lmodel2_tidiers
#' 
#' @export
tidy.lmodel2 <- function(x, ...) {
    ret <- x$regression.results[1:3] %>%
        select(method = Method, Intercept, Slope) %>%
        tidyr::gather(term, estimate, -method) %>%
        arrange(method, term)
    
    # add confidence intervals
    confints <- x$confidence.intervals %>%
        tidyr::gather(key, value, -Method) %>%
        tidyr::separate(key, c("level", "term"), "-") %>%
        mutate(level = ifelse(level == "2.5%", "conf.low", "conf.high")) %>%
        tidyr::spread(level, value) %>%
        select(method = Method, term, conf.low, conf.high)
    
    ret %>%
        inner_join(confints, by = c("method", "term"))
}


#' @rdname lmodel2_tidiers
#' 
#' @return \code{glance} returns a one-row data frame with columns
#' \describe{
#'   \item{r.squared}{OLS R-squared}
#'   \item{p.value}{OLS parametric p-value}
#'   \item{theta}{Angle between OLS lines \code{lm(y ~ x)} and \code{lm(x ~ y)}}
#'   \item{H}{H statistic for computing confidence interval of major axis slope}
#' }
#' 
#' @export
glance.lmodel2 <- function(x, ...) {
    data.frame(r.squared = x$rsquare,
               theta = x$theta,
               p.value = x$P.param,
               H = x$H)
}
