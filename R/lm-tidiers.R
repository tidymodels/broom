#' Tidying methods for a linear model
#' 
#' These methods tidy the coefficients of a linear model into a summary,
#' augment the original data with information on the fitted values and
#' residuals, and construct a one-row glance of the model's statistics.
#'
#' If you have missing values in your model data, you may need to refit
#' the model with \code{na.action = na.exclude}.
#'
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#'
#' @seealso \code{\link{summary.lm}}
#'
#' @name lm-tidiers
#' 
#' @param x lm object
#' @param data Original data, defaults to the extracting it from the model
#'
#' @examples
#'
#' library(ggplot2)
#'
#' mod <- lm(mpg ~ wt, data = mtcars)
#' head(augment(mod))
#' head(augment(mod, mtcars))
#'
#' plot(mod, which = 1)
#' qplot(.fitted, .resid, data = mod) +
#'   geom_hline(yintercept = 0) +
#'   geom_smooth(se = FALSE)
#' qplot(.fitted, .stdresid, data = mod) +
#'   geom_hline(yintercept = 0) +
#'   geom_smooth(se = FALSE)
#' qplot(.fitted, .stdresid, data = augment(mod, mtcars),
#'   colour = factor(cyl))
#' qplot(mpg, .stdresid, data = augment(mod, mtcars), colour = factor(cyl))
#'
#' plot(mod, which = 2)
#' # qplot(sample =.stdresid, data = mod, stat = "qq") + geom_abline()
#'
#' plot(mod, which = 3)
#' qplot(.fitted, sqrt(abs(.stdresid)), data = mod) + geom_smooth(se = FALSE)
#'
#' plot(mod, which = 4)
#' qplot(seq_along(.cooksd), .cooksd, data = mod, geom = "bar",
#'  stat="identity")
#'
#' plot(mod, which = 5)
#' qplot(.hat, .stdresid, data = mod) + geom_smooth(se = FALSE)
#' ggplot(mod, aes(.hat, .stdresid)) +
#'   geom_vline(size = 2, colour = "white", xintercept = 0) +
#'   geom_hline(size = 2, colour = "white", yintercept = 0) +
#'   geom_point() + geom_smooth(se = FALSE)
#'
#' qplot(.hat, .stdresid, data = mod, size = .cooksd) +
#'   geom_smooth(se = FALSE, size = 0.5)
#'
#' plot(mod, which = 6)
#' ggplot(mod, aes(.hat, .cooksd)) +
#'   geom_vline(xintercept = 0, colour = NA) +
#'   geom_abline(slope = seq(0, 3, by = 0.5), colour = "white") +
#'   geom_smooth(se = FALSE) +
#'   geom_point()
#' qplot(.hat, .cooksd, size = .cooksd / .hat, data = mod) + scale_size_area()
NULL


#' @rdname lm-tidiers
#' 
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level of the interval, used only if
#' \code{conf.int=TRUE}
#' @param exponentiate whether to exponentiate the coefficient estimates
#' and confidence intervals (typical for logistic regression)
#' 
#' @details If \code{conf.int=TRUE}, the confidence interval is computed with
#' the \code{\link{confint}} function.
#' 
#' @return \code{tidy.lm} returns one row for each coefficient, with five columns:
#'   \item{term}{The term in the linear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{stderror}{The standard error from the linear model}
#'   \item{statistic}{t-statistic}
#'   \item{p.value}{two-sided p-value}
#' 
#' If \code{cont.int=TRUE}, it also includes columns for \code{conf.low} and
#' \code{conf.high}, computed with \code{\link{confint}}.
#' 
#' @export
tidy.lm <- function(x, conf.int=FALSE, conf.level=.95,
                    exponentiate=FALSE, ...) {
    nn <- c("estimate", "stderror", "statistic", "p.value")
    ret <- fix_data_frame(coef(summary(x)), nn)

    if (exponentiate) {
        # save transformation function for use on confidence interval
        if (is.null(x$family) || x$family$link != "logit") {
            warning(paste("Exponentiating coefficients, but model did not use",
                          "a logit link function"))
        }
        trans <- exp
    } else {
        trans <- identity
    }

    if (conf.int) {
        # avoid "Waiting for profiling to be done..." message
        CI <- suppressMessages(confint(x, level = conf.level))
        colnames(CI) = c("conf.low", "conf.high")
        ret <- cbind(ret, trans(unrowname(CI)))
    }
    ret$estimate <- trans(ret$estimate)

    ret
}


#' @rdname lm-tidiers
#' 
#' @details Code and documentation for \code{augment.lm} originated in the
#' ggplot2 package, where it was called \code{fortify.lm}
#' 
#' @return \code{augment.lm} returns one row for each observation,
#' with six columns added to the original data:
#'   \item{.hat}{Diagonal of the hat matrix}
#'   \item{.sigma}{Estimate of residual standard deviation when
#'     corresponding observation is dropped from model}
#'   \item{.cooksd}{Cooks distance, \code{\link{cooks.distance}}}
#'   \item{.fitted}{Fitted values of model}
#'   \item{.resid}{Residuals}
#'   \item{.stdresid}{Standardised residuals}
#'
#' @export
augment.lm <- function(x, data = x$model, ...) {
    # move rownames if necessary
    data <- fix_data_frame(data, newcol=".rownames")
    
    infl <- influence(x, do.coef = FALSE)
    data$.hat <- infl$hat
    data$.sigma <- infl$sigma
    data$.cooksd <- cooks.distance(x, infl)

    data$.fitted <- predict(x)
    data$.resid <- resid(x)
    data$.stdresid <- rstandard(x, infl)
    
    data
}


#' @rdname lm-tidiers
#' 
#' @param ... extra arguments, not used
#' 
#' @return \code{glance.lm} returns a one-row data.frame with the columns
#'   \item{r.squared}{The percent of variance explained by the model}
#'   \item{adj.r.squared}{r.squared adjusted based on the degrees of freedom}
#'   \item{sigma}{The square root of the estimated residual variance}
#'   \item{statistic}{F-statistic}
#'   \item{p.value}{p-value from the F test, describing whether the full regression is significant}
#' 
#' @export
glance.lm <- function(x, ...) {
    s <- summary(x)
    unrowname(with(s, data.frame(r.squared=r.squared,
                                 adj.r.squared=adj.r.squared,
                                 sigma=sigma,
                                 statistic=fstatistic[1],
                                 p.value=pf(fstatistic[1], fstatistic[2], fstatistic[3],
                                            lower.tail=FALSE))))
}
