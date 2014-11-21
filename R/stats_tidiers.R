### tidy methods for S3 classes used by the built-in stats package
### This file is only for miscellaneous methods that have *only* a tidy
### method (not augment or glance). In general, tidiers belong in in
### a file of "<class>_tidiers.R"


#' tidy a table object
#' 
#' A table, typically created by the \link{table} function, contains a
#' contingency table of frequencies across multiple vectors. This directly
#' calls the \code{\link{as.data.frame.table}} method, which melts it into a
#' data frame with one column for each variable and a \code{Freq} column.
#' 
#' @param x An object of class "table"
#' @param ... Extra arguments (not used)
#' 
#' @examples
#' 
#' tab <- with(airquality, table(cut(Temp, quantile(Temp)), Month))
#' tidy(tab)
#' 
#' @seealso \code{\link{as.data.frame.table}}
#' 
#' @export
tidy.table <- function(x, ...) {
    as.data.frame(x)
}


#' tidy an ftable object
#' 
#' An ftable contains a "flat" contingency table. This melts it into a
#' data.frame with one column for each variable, then a \code{Freq}
#' column. It directly uses the \code{stats:::as.data.frame.ftable} function
#' 
#' @param x An object of class "ftable"
#' @param ... Extra arguments (not used)
#' 
#' @examples
#' 
#' tidy(ftable(Titanic, row.vars = 1:3))
#' 
#' @seealso \code{\link{ftable}}
#' 
#' @export
tidy.ftable <- function(x, ...) {
    as.data.frame(x)
}


#' tidy a density objet
#' 
#' Given a "density" object, returns a tidy data frame with two
#' columns: points x where the density is estimated, points y
#' for the estimate
#' 
#' @param x an object of class "density"
#' @param ... extra arguments (not used)
#' 
#' @return a data frame with "x" and "y" columns
#' 
#' d <- density(faithful$eruptions, bw = "sj")
#' head(tidy(d))
#' 
#' library(ggplot2)
#' ggplot(tidy(d), aes(x, y)) + geom_line()
#' 
#' @seealso \code{\link{density}}
#' 
#' @export
tidy.density <- function(x, ...) {
    as.data.frame(x[c("x", "y")])
}


#' tidy a spec objet
#' 
#' Given a "spec" object, which shows a spectrum across a range of frequencies,
#' returns a tidy data frame with two columns: "freq" and "spec"
#' 
#' @param x an object of class "spec"
#' @param ... extra arguments (not used)
#' 
#' @return a data frame with "freq" and "spec" columns
#' 
#' @examples
#' 
#' spc <- spectrum(lh)
#' tidy(spc)
#' 
#' library(ggplot2)
#' ggplot(tidy(spc), aes(freq, spec)) + geom_line()
#' 
#' @export
tidy.spec <- function(x, ...) {
    as.data.frame(x[c("freq", "spec")])
}


#' tidy a TukeyHSD object
#' 
#' Returns a data.frame with one row for each pairwise comparison
#' 
#' @param x object of class "TukeyHSD"
#' @param ... additional arguments (not used)
#' 
#' @return A data.frame with one row per comparison, containing columns
#'     \item{comparison}{Levels being compared, separated by -}
#'     \item{estimate}{Estimate of difference}
#'     \item{conf.low}{Low end of confidence interval of difference}
#'     \item{conf.high}{High end of confidence interval of difference}
#'     \item{adj.p.value}{P-value adjusted for multiple comparisons}
#' 
#' @examples
#' 
#' fm1 <- aov(breaks ~ wool + tension, data = warpbreaks)
#' thsd <- TukeyHSD(fm1, "tension", ordered = TRUE)
#' tidy(thsd)
#' 
#' @seealso \code{\link{TukeyHSD}}
#' 
#' @export
tidy.TukeyHSD <- function(x, ...) {
    nn <- c("estimate", "conf.low", "conf.high", "adj.p.value")
    fix_data_frame(x[[1]], nn, "comparison")
}


#' tidy a MANOVA object
#' 
#' Constructs a data frame with one row for each of the terms in the model,
#' containing the information from \link{summary.manova}.
#' 
#' @param x object of class "manova"
#' @param ... additional arguments passed on to \code{summary.manova},
#' such as \code{test}
#' 
#' @return A data.frame with the columns
#'     \item{term}{Term in design}
#'     \item{statistic}{Approximate F statistic}
#'     \item{num.df}{Degrees of freedom}
#'     \item{p.value}{P-value}
#' 
#' @examples
#' 
#' npk2 <- within(npk, foo <- rnorm(24))
#' npk2.aov <- manova(cbind(yield, foo) ~ block + N*P*K, npk2)
#' 
#' @seealso \code{\link{summary.manova}}
#' 
#' @export
tidy.manova <- function(x, ...) {
    nn <-  c("df", "pillai", "statistic", "num.df", "den.df", "p.value")
    ret <- fix_data_frame(summary(x, ...)$stats, nn)
    # remove residuals row (doesn't have useful information)
    ret <- ret[-nrow(ret), ]
    ret
}


#' tidy a ts timeseries object
#' 
#' Turn a ts object into a tidy data frame. Right now simply uses
#' \code{as.data.frame.ts}.
#' 
#' @param x a "ts" object
#' @param ... extra arguments (not used)
#' 
#' @return a tidy data frame
#' 
#' @seealso \link{as.data.frame.ts}
#' 
#' @export
tidy.ts <- function(x, ...) {
    as.data.frame(x)
}


#' tidy a pairwise hypothesis test
#' 
#' Tidy a pairwise.htest object, containing (adjusted) p-values for multiple
#' pairwise hypothesis tests
#' 
#' @param x a "pairwise.htest" object
#' @param ... extra arguments (not used)
#' 
#' @return A data frame with one row per group/group comparison, with columns
#'   \item{group1}{First group being compared} 
#'   \item{group2}{Second group being compared}
#'   \item{p.value}{(Adjusted) p-value of comparison}
#' 
#' @details Note that in one-sided tests, the alternative hypothesis of each
#' test can be stated as "group1 is greater/less than group2"
#' 
#' @examples
#' 
#' attach(airquality)
#' Month <- factor(Month, labels = month.abb[5:9])
#' ptt <- pairwise.t.test(Ozone, Month)
#' tidy(ptt)
#' 
#' attach(iris)
#' ptt2 <- pairwise.t.test(Petal.Length, Species)
#' tidy(ptt2)
#' 
#' tidy(pairwise.t.test(Petal.Length, Species, alternative = "greater"))
#' tidy(pairwise.t.test(Petal.Length, Species, alternative = "less"))
#' 
#' tidy(pairwise.wilcox.test(Petal.Length, Species))
#' 
#' @seealso \link{pairwise.t.test}, \link{pairwise.wilcox.test}
#' 
#' @export
tidy.pairwise.htest <- function(x, ...) {
    x$p.value %>% fix_data_frame(newcol = "group1") %>%
        tidyr::gather(group2, p.value, -group1) %>%
        na.omit()
}


# todo?
# tidy.acf
# tidy.infl
# tidy.stepfun
