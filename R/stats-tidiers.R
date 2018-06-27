#' tidy an ftable object
#'
#' An ftable contains a "flat" contingency table. This melts it into a
#' data.frame with one column for each variable, then a `Freq`
#' column. It directly uses the `stats:::as.data.frame.ftable` function
#'
#' @param x An object of class "ftable"
#' @param ... Extra arguments (not used)
#'
#' @examples
#'
#' tidy(ftable(Titanic, row.vars = 1:3))
#'
#' @seealso [ftable()]
#'
#' @export
tidy.ftable <- function(x, ...) {
  as_tibble(x)
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
#' @seealso [density()]
#'
#' @export
tidy.density <- function(x, ...) {
  as_tibble(x[c("x", "y")])
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

  ret <- reshape2::melt(m,
    varnames = c("item1", "item2"),
    value.name = "distance"
  )

  if (!upper) {
    ret <- ret[!upper.tri(m), ]
  }

  if (!diag) {
    # filter out the diagonal
    ret <- filter(ret, item1 != item2)
  }
  as_tibble(ret)
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
  as_tibble(x[c("freq", "spec")])
}


#' tidy a TukeyHSD object
#'
#' Returns a data.frame with one row for each pairwise comparison
#'
#' @param x object of class "TukeyHSD"
#' @param separate.levels Whether to separate comparison into
#' `level1` and `level2` columns
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
#' If `separate.levels = TRUE`, the `comparison` column will be
#' split up into `level1` and `level2`.
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
#' @seealso [TukeyHSD()]
#'
#' @export
tidy.TukeyHSD <- function(x, separate.levels = FALSE, ...) {
  ret <- purrr::map_df(x, function(e) {
    nn <- c("estimate", "conf.low", "conf.high", "adj.p.value")
    fix_data_frame(e, nn, "comparison")
  }, .id = "term")

  if (separate.levels) {
    ret <- tidyr::separate(ret, comparison, c("level1", "level2"), sep = "-")
  }
  as_tibble(ret)
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
  tibble(group1 = rownames(x$p.value)) %>%
    cbind(x$p.value) %>%
    tidyr::gather(group2, p.value, -group1) %>%
    stats::na.omit() %>% 
    as_tibble()
}

#' tidy a power.htest
#'
#' @param x a power.htest object
#' @param ... extra arguments, not used
#'
#' @return A data frame with one row per parameter passed in, with
#' columns `n`, `delta`, `sd`, `sig.level`, and
#' `power` (from the `power.htest` object).
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
  as_tibble(cols)
}


#' Tidying method for the acf function
#'
#' Tidy an "acf" object, which is the output of `acf` and the
#' related `pcf` and `ccf` functions.
#'
#' @name acf_tidiers
#'
#' @param x acf object
#' @param ... (not used)
#'
#' @return `data.frame` with columns
#'  \item{lag}{lag values}
#'  \item{acf}{calculated correlation}
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
#' # from `plot.acf` method
#' len.data <- length(lh) # same as acf$n.used
#' conf.int <- qnorm((1 + conf.level) / 2) / sqrt(len.data)
#' p + geom_hline(yintercept = c(-conf.int, conf.int),
#'                color='blue', linetype='dashed')
#'
#' @export
tidy.acf <- function(x, ...) {
  tibble(lag = as.numeric(x$lag), acf = as.numeric(x$acf))
}
