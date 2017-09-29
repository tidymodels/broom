#' Tidying methods for generalized method of moments "gmm" objects
#' 
#' These methods tidy the coefficients of "gmm" objects from the gmm package,
#' or glance at the model-wide statistics (especially the J-test).
#' 
#' @param x gmm object
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level of the interval, used only if
#' \code{conf.int=TRUE}
#' @param exponentiate whether to exponentiate the coefficient estimates
#' and confidence intervals (typical for logistic regression)
#' @param quick whether to compute a smaller and faster version, containing
#' only the \code{term} and \code{estimate} columns (and confidence interval
#' if requested, which may be slower)
#' 
#' @details If \code{conf.int=TRUE}, the confidence interval is computed with
#' the \code{\link{confint}} function.
#' 
#' Note that though the "gmm" object contains residuals and fitted values,
#' there is not yet an \code{augment} method implemented. This is because
#' the input to gmm is not tidy (it's a "wide" matrix), so it is not immediately
#' clear what the augmented results should look like.
#' 
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#' 
#' \code{tidy.gmm} returns one row for each coefficient, with six columns:
#'   \item{term}{The term in the model being estimated}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error from the linear model}
#'   \item{statistic}{t-statistic}
#'   \item{p.value}{two-sided p-value}
#' 
#' If all the the terms have _ in them (e.g. \code{WMK_(Intercept)}),
#' they are split into \code{variable} and \code{term}.
#' 
#' If \code{conf.int=TRUE}, it also includes columns for \code{conf.low} and
#' \code{conf.high}, computed with \code{\link{confint}}.
#' 
#' @name gmm_tidiers
#' 
#' @examples 
#' 
#' if (require("gmm", quietly = TRUE)) {
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
tidy.gmm <- function(x, conf.int = FALSE, conf.level = .95,
                     exponentiate = FALSE, quick = FALSE, ...) {
    if (quick) {
        co <- stats::coef(x)
        ret <- data.frame(term = names(co), estimate = unname(co))
    } else {
        co <- stats::coef(summary(x))
        
        nn <- c("estimate", "std.error", "statistic", "p.value")
        ret <- fix_data_frame(co, nn[1:ncol(co)])
    }
    
    # newer versions of GMM create a 'confint' object, so we can't use process_lm
    ret <- process_lm(ret, x, conf.int = FALSE, conf.level = conf.level,
                      exponentiate = exponentiate)
    if (conf.int) {
        CI <- suppressMessages(stats::confint(x, level = conf.level))
        if (! is.matrix(CI)) CI <- CI$test 
        colnames(CI) = c("conf.low", "conf.high")
        trans <- if (exponentiate) exp else identity
        ret <- cbind(ret, trans(unrowname(CI)))
    }
    if (all(grepl("_", ret$term))) {
        # separate the variable and term
        ret <- tidyr::separate(ret, term, c("variable", "term"), sep = "_", extra = "merge")
    }
    
    ret
}


#' @rdname gmm_tidiers
#' 
#' @param ... extra arguments (not used)
#' 
#' @return \code{glance.gmm} returns a one-row data.frame with the columns
#'   \item{df}{Degrees of freedom}
#'   \item{statistic}{Statistic from J-test for E(g)=0}
#'   \item{p.value}{P-value from J-test}
#'   \item{df.residual}{Residual degrees of freedom, if included in "gmm" object}
#' 
#' @export
glance.gmm <- function(x, ...) {
    s <- gmm::summary.gmm(x)
    st <- suppressWarnings(as.numeric(s$stest$test))
    ret <- data.frame(df = x$df, statistic = st[1], p.value = st[2])
    ret <- finish_glance(unrowname(ret), x)
    ret
}
