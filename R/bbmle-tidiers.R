#' @templateVar class mle2
#' @template title_desc_tidy
#'
#' @param x An `mle2` object created by a call to [bbmle::mle2()].
#' @template param_confint
#' @template param_unused_dots
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
#' @export
#' @seealso [tidy()], [bbmle::mle2()], [tidy_optim()]
#' @aliases mle2_tidiers bbmle_tidiers
tidy.mle2 <- function(x, conf.int = FALSE, conf.level = .95, ...) {
  co <- bbmle::coef(bbmle::summary(x))
  nn <- c("estimate", "std.error", "statistic", "p.value")
  ret <- fix_data_frame(co, nn)

  if (conf.int) {
    CI <- confint_tidy(x, conf.level = conf.level, func = bbmle::confint)
    ret <- cbind(ret, CI)
  }
  as_tibble(ret)
}
