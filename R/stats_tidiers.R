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


#' Tidy a distance matrix
#' 
#' Tidy a distance matrix, such as that computed by the \link{dist}
#' function, into a one-row-per-pair table. If the distance matrix
#' does not include an upper triangle and/or diagonal, this will
#' not either.
#' 
#' @param x A "dist" object
#' @param diag Whether to include the diagonal of the distance
#' matrix. Defaults to whether the distance matrix includes it
#' @param upper Whether to include the upper right triangle of
#' the distance matrix. Defaults to whether the distance matrix
#' includes it
#' @param ... Extra arguments, not used
#' 
#' @return A data frame with one row for each pair of
#' item distances, with columns:
#' \describe{
#'   \item{item1}{First item}
#'   \item{item2}{Second item}
#'   \item{distance}{Distance between items}
#' }
#' 
#' @examples
#' 
#' iris_dist <- dist(t(iris[, 1:4]))
#' iris_dist
#' 
#' tidy(iris_dist)
#' tidy(iris_dist, upper = TRUE)
#' tidy(iris_dist, diag = TRUE)
#' 
#' @export
tidy.dist <- function(x, diag = attr(x, "Diag"),
                      upper = attr(x, "Upper"), ...) {
    m <- as.matrix(x)
    
    ret <- reshape2::melt(m, varnames = c("item1", "item2"),
                          value.name = "distance")
    
    if (!upper) {
        ret <- ret[!upper.tri(m), ]
    }
    
    if (!diag) {
        # filter out the diagonal
        ret <- filter(ret, item1 != item2)
    }
    ret
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
#' @param separate.levels Whether to separate comparison into
#' \code{level1} and \code{level2} columns
#' @param ... additional arguments (not used)
#' 
#' @return A data.frame with one row per comparison, containing columns
#'     \item{term}{Term for which levels are being compared}
#'     \item{comparison}{Levels being compared, separated by -}
#'     \item{estimate}{Estimate of difference}
#'     \item{conf.low}{Low end of confidence interval of difference}
#'     \item{conf.high}{High end of confidence interval of difference}
#'     \item{adj.p.value}{P-value adjusted for multiple comparisons}
#' 
#' If \code{separate.levels = TRUE}, the \code{comparison} column will be
#' split up into \code{level1} and \code{level2}.
#' 
#' @examples
#' 
#' fm1 <- aov(breaks ~ wool + tension, data = warpbreaks)
#' thsd <- TukeyHSD(fm1, "tension", ordered = TRUE)
#' tidy(thsd)
#' tidy(thsd, separate.levels = TRUE)
#' 
#' # may include comparisons on multiple terms
#' fm2 <- aov(mpg ~ as.factor(gear) * as.factor(cyl), data = mtcars)
#' tidy(TukeyHSD(fm2))
#' 
#' @seealso \code{\link{TukeyHSD}}
#' 
#' @export
tidy.TukeyHSD <- function(x, separate.levels = FALSE, ...) {
    ret <- plyr::ldply(x, function(e) {
        nn <- c("estimate", "conf.low", "conf.high", "adj.p.value")
        fix_data_frame(e, nn, "comparison")
    }, .id = "term")
    
    if (separate.levels) {
        ret <- tidyr::separate(ret, comparison, c("level1", "level2"), sep = "-")
    }
    ret
}


#' tidy a MANOVA object
#' 
#' Constructs a data frame with one row for each of the terms in the model,
#' containing the information from \link{summary.manova}.
#' 
#' @param x object of class "manova"
#' @param test one of "Pillai" (Pillai's trace), "Wilks" (Wilk's lambda), "Hotelling-Lawley" (Hotelling-Lawley trace) or "Roy" (Roy's greatest root) indicating which test statistic should be used. Defaults to "Pillai"
#' @param ... additional arguments passed on to \code{summary.manova}
#' 
#' @return A data.frame with the columns
#'     \item{term}{Term in design}
#'     \item{statistic}{Approximate F statistic}
#'     \item{num.df}{Degrees of freedom}
#'     \item{p.value}{P-value}
#'     
#' Depending on which test statistic is specified, one of the following columns is also included:
#'     \item{pillai}{Pillai's trace}
#'     \item{wilks}{Wilk's lambda}
#'     \item{hl}{Hotelling-Lawley trace}
#'     \item{roy}{Roy's greatest root}
#' 
#' @examples
#' 
#' npk2 <- within(npk, foo <- rnorm(24))
#' npk2.aov <- manova(cbind(yield, foo) ~ block + N*P*K, npk2)
#' 
#' @seealso \code{\link{summary.manova}}
#' 
#' @export
tidy.manova <- function(x, test = "Pillai", ...) {
    # match test name (default to 'pillai')
    # partially match the name so we're consistent with the underlying function
    test.pos <- pmatch(test, c("Pillai", "Wilks",
        "Hotelling-Lawley", "Roy"))
    test.name <- c("pillai", "wilks", "hl", "roy")[test.pos]
    
    nn <-  c("df", test.name, "statistic", "num.df", "den.df", "p.value")
    ret <- fix_data_frame(summary(x, test = test, ...)$stats, nn)
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
#' pairwise hypothesis tests.
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
#' test can be stated as "group1 is greater/less than group2".
#' 
#' Note also that the columns of group1 and group2 will always be a factor,
#' even if the original input is (e.g.) numeric.
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
    data.frame(group1 = rownames(x$p.value)) %>%
      cbind(as.data.frame(x$p.value)) %>%
      tidyr::gather(group2, p.value, -group1) %>%
      stats::na.omit()
}


#' tidy a power.htest
#' 
#' @param x a power.htest object
#' @param ... extra arguments, not used
#' 
#' @return A data frame with one row per parameter passed in, with
#' columns \code{n}, \code{delta}, \code{sd}, \code{sig.level}, and
#' \code{power} (from the \code{power.htest} object).
#' 
#' @seealso \link{power.t.test}
#' 
#' @examples
#' 
#' ptt <- power.t.test(n = 2:30, delta = 1)
#' tidy(ptt)
#' 
#' library(ggplot2)
#' ggplot(tidy(ptt), aes(n, power)) + geom_line()
#' 
#' @export
tidy.power.htest <- function(x, ...) {
    cols <- compact(x[c("n", "delta", "sd", "sig.level", "power", "p1", "p2")])
    as.data.frame(cols)
}


#' Tidying method for the acf function
#' 
#' Tidy an "acf" object, which is the output of \code{acf} and the
#' related \code{pcf} and \code{ccf} functions.
#' 
#' @name acf_tidiers
#' 
#' @param x acf object
#' @param ... (not used)
#' 
#' @return \code{data.frame} with columns
#'  \item{lag}{lag values}
#'  \item{acf}{calucated correlation}
#'  
#' @examples
#' 
#' # acf
#' result <- acf(lh, plot=FALSE)
#' tidy(result)
#' 
#' # ccf
#' result <- ccf(mdeaths, fdeaths, plot=FALSE)
#' tidy(result)
#' 
#' # pcf
#' result <- pacf(lh, plot=FALSE)
#' tidy(result)
#' 
#' # lag plot
#' library(ggplot2)
#' result <- tidy(acf(lh, plot=FALSE))
#' p <- ggplot(result, aes(x=lag, y=acf)) + 
#'          geom_bar(stat='identity', width=0.1) +
#'          theme_bw()
#' p
#' 
#' # with confidence intervals 
#' conf.level <- 0.95
#' # from \code{plot.acf} method
#' len.data <- length(lh) # same as acf$n.used
#' conf.int <- qnorm((1 + conf.level) / 2) / sqrt(len.data)
#' p + geom_hline(yintercept = c(-conf.int, conf.int),
#'                color='blue', linetype='dashed')
#' 
#' @export
tidy.acf <- function(x, ...) {
    ret <- data.frame(lag = x$lag, acf = x$acf)
    return(ret)
}


# todo?
# tidy.infl
# tidy.stepfun
