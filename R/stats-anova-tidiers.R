#' Tidying methods for ANOVA and AOV objects
#'
#' Tidies the result of an analysis of variance into an ANOVA table.
#' Only a `tidy` method is provided, not an `augment` or
#' `glance` method.
#'
#' @param x An object of class `anova`, `aov`, or `aovlist`.
#' @param ... Additional arguments (not used).
#'
#' @return A `tibble`` with columns
#'   \item{term}{Term within the model, or "Residuals"}
#'   \item{df}{Degrees of freedom used by this term in the model}
#'   \item{sumsq}{Sum of squares explained by this term}
#'   \item{meansq}{Mean of sum of squares among degrees of freedom}
#'   \item{statistic}{F statistic}
#'   \item{p.value}{P-value from F test}
#'
#' In the case of an `aovlist` object, there is also a `stratum`
#' column describing the error stratum
#'
#' @details Note that the "term" column of an ANOVA table can come with
#' leading or trailing whitespace, which this tidying method trims.
#'
#' Note that `Anova` from \pkg{car} (perhaps counter-intuively) outputs an
#' object of class `anova` for generalized linear models. These objects are
#' also supported.
#'
#' @examples
#'
#' a <- anova(lm(mpg ~ wt + qsec + disp, mtcars))
#' tidy(a)
#'
#' a <- aov(mpg ~ wt + qsec + disp, mtcars)
#' tidy(a)
#'
#' al <- aov(mpg ~ wt + qsec + Error(disp / am), mtcars)
#' tidy(al)
#'
#' @name anova_tidiers
NULL


#' @rdname anova_tidiers
#'
#' @import dplyr
#'
#' @export
tidy.anova <- function(x, ...) {
  # x is stats::anova
  # there are many possible column names that need to be transformed
  renamers <- c(
    "Df" = "df",
    "Sum Sq" = "sumsq",
    "Mean Sq" = "meansq",
    "F value" = "statistic",
    "Pr(>F)" = "p.value",
    "Res.Df" = "res.df",
    "RSS" = "rss",
    "Sum of Sq" = "sumsq",
    "F" = "statistic",
    "Chisq" = "statistic",
    "P(>|Chi|)" = "p.value",
    "Pr(>Chi)" = "p.value",
    "Pr..Chisq." = "p.value",
    "Pr..Chi." = "p.value",
    "p.value" = "p.value",
    "Chi.sq" = "statistic",
    "LR.Chisq" = "statistic",
    "LR Chisq" = "statistic",
    "edf" = "edf",
    "Ref.df" = "ref.df"
  )

  names(renamers) <- make.names(names(renamers))

  x <- fix_data_frame(x)
  unknown_cols <- setdiff(colnames(x), c("term", names(renamers)))
  if (length(unknown_cols) > 0) {
    warning(
      "The following column names in ANOVA output were not ",
      "recognized or transformed: ",
      paste(unknown_cols, collapse = ", ")
    )
  }
  ret <- plyr::rename(x, renamers, warn_missing = FALSE)
  if (!is.null(ret$term)) {
    # if rows had names, strip whitespace in them
    ret <- ret %>% mutate(term = stringr::str_trim(term))
  }
  tibble::as_tibble(ret)
}


#' @rdname anova_tidiers
#'
#' @import dplyr
#'
#' @export
tidy.aov <- function(x, ...) {
  s <- summary(x)
  tidy.anova(s[[1]])
}


#' @rdname anova_tidiers
#' 
#' @import purrr
#' 
#' @export
tidy.aovlist <- function(x, ...) {
  # must filter out Intercept stratum since it has no dimensions
  if (names(x)[1L] == "(Intercept)") {
    x <- x[-1L]
  }

  ret <- purrr::map_df(x, tidy, .id = "stratum")
  
  # get rid of leading and trailing whitespace in term and stratum columns
  ret <- ret %>% dplyr::mutate(
    term = stringr::str_trim(term),
    stratum = stringr::str_trim(stratum)
  )
  tibble::as_tibble(ret)
}


#' tidy a MANOVA object
#'
#' Constructs a data frame with one row for each of the terms in the model,
#' containing the information from \link{summary.manova}.
#'
#' @param x object of class "manova"
#' @param test one of "Pillai" (Pillai's trace), "Wilks" (Wilk's lambda), "Hotelling-Lawley" (Hotelling-Lawley trace) or "Roy" (Roy's greatest root) indicating which test statistic should be used. Defaults to "Pillai"
#' @param ... additional arguments passed on to `summary.manova`
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
#' @seealso [summary.manova()]
#'
#' @export
tidy.manova <- function(x, test = "Pillai", ...) {
  # match test name (default to 'pillai')
  # partially match the name so we're consistent with the underlying function
  test.pos <- pmatch(test, c(
    "Pillai", "Wilks",
    "Hotelling-Lawley", "Roy"
  ))
  test.name <- c("pillai", "wilks", "hl", "roy")[test.pos]
  
  nn <- c("df", test.name, "statistic", "num.df", "den.df", "p.value")
  fix_data_frame(summary(x, test = test, ...)$stats, nn)
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
