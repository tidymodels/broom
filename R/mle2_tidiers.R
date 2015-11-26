#' Tidy mle2 maximum likelihood objects
#' 
#' Tidy mle2 objects from the bbmle package.
#' 
#' @param x An "mle2" object
#' @param conf.int Whether to add \code{conf.low} and \code{conf.high} columns
#' @param conf.level Confidence level to use for interval
#' @param ... Extra arguments, not used
#' 
#' @examples
#' 
#' if (require("bbmle", quietly = TRUE)) {
#'   x <- 0:10
#'   y <- c(26, 17, 13, 12, 20, 5, 9, 8, 5, 4, 8)
#'   d <- data.frame(x,y)
#'   
#'   fit <- mle2(y ~ dpois(lambda = ymean),
#'               start = list(ymean = mean(y)), data = d)
#'   
#'   tidy(fit)
#' }
#' 
#' @name mle2_tidiers
#' 
#' @export
tidy.mle2 <- function(x, conf.int = FALSE, conf.level = .95, ...) {
    co <- bbmle::coef(bbmle::summary(x))
    nn <- c("estimate", "std.error", "statistic", "p.value")
    ret <- fix_data_frame(co, nn)
    
    if (conf.int) {
        CI <- confint_tidy(x, conf.level = conf.level, func = bbmle::confint)
        ret <- cbind(ret, CI)
    }
    ret
}
