#' @templateVar class anova
#' @template title_desc_tidy
#' 
#' @param x An `anova` objects, such as those created by [stats::anova()] or
#'   [car::Anova()].
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with columns
#' 
#'   \item{term}{Term within the model, or "Residuals"}
#'   \item{df}{Degrees of freedom used by this term in the model}
#'   \item{sumsq}{Sum of squares explained by this term}
#'   \item{meansq}{Mean of sum of squares among degrees of freedom}
#'   \item{statistic}{F statistic}
#'   \item{p.value}{P-value from F test}
#'   
#' @details The `term` column of an ANOVA table can come with leading or
#'   trailing whitespace, which this tidying method trims.
#'   
#' @examples
#'
#' a <- a <- aov(mpg ~ wt + qsec + disp, mtcars)
#' tidy(a)
#'
#' @export
#' @family anova tidiers
#' @seealso [tidy()], [stats::anova()], [car::Anova()]
tidy.anova <- function(x, ...) {
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
    ret <- mutate(ret, term = stringr::str_trim(term))
  }
  as_tibble(ret)
}


#' @templateVar class aov
#' @template title_desc_tidy
#' 
#' @param x An `aov` objects, such as those created by [stats::aov()].
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with columns
#' 
#'   \item{term}{Term within the model, or "Residuals"}
#'   \item{df}{Degrees of freedom used by this term in the model}
#'   \item{sumsq}{Sum of squares explained by this term}
#'   \item{meansq}{Mean of sum of squares among degrees of freedom}
#'   \item{statistic}{F statistic}
#'   \item{p.value}{P-value from F test}
#'   
#' @details The `term` column of an ANOVA table can come with leading or
#'   trailing whitespace, which this tidying method trims.
#'   
#' @examples
#'
#' a <- aov(mpg ~ wt + qsec + disp, mtcars)
#' tidy(a)
#'
#' @export
#' @family anova tidiers
#' @seealso [tidy()], [stats::aov()]
tidy.aov <- function(x, ...) {
  s <- summary(x)
  tidy.anova(s[[1]])
}


#' @templateVar class aovlist
#' @template title_desc_tidy
#' 
#' @param x An `aovlist` objects, such as those created by [stats::aov()].
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with columns
#' 
#'   \item{term}{Term within the model, or "Residuals"}
#'   \item{df}{Degrees of freedom used by this term in the model}
#'   \item{sumsq}{Sum of squares explained by this term}
#'   \item{meansq}{Mean of sum of squares among degrees of freedom}
#'   \item{statistic}{F statistic}
#'   \item{p.value}{P-value from F test}
#'   \item{stratum}{The error stratum}
#'   
#' @details The `term` column of an ANOVA table can come with leading or
#'   trailing whitespace, which this tidying method trims.
#'   
#' @examples
#'
#' a <- aov(mpg ~ wt + qsec + Error(disp / am), mtcars)
#' tidy(a)
#'
#' @export
#' @family anova tidiers
#' @seealso [tidy()], [stats::aov()]
tidy.aovlist <- function(x, ...) {
  
  # must filter out Intercept stratum since it has no dimensions
  if (names(x)[1L] == "(Intercept)") {
    x <- x[-1L]
  }

  ret <- map_df(x, tidy, .id = "stratum")
  
  # get rid of leading and trailing whitespace in term and stratum columns
  ret <- ret %>% 
    mutate(
      term = stringr::str_trim(term),
      stratum = stringr::str_trim(stratum)
    )
  
  as_tibble(ret)
}


#' @templateVar class manova
#' @template title_desc_tidy
#'
#' @param x A `manova` object return from [stats::manova()].
#' @param test One of "Pillai" (Pillai's trace), "Wilks" (Wilk's lambda),
#'   "Hotelling-Lawley" (Hotelling-Lawley trace) or "Roy" (Roy's greatest root)
#'   indicating which test statistic should be used. Defaults to "Pillai".
#' @inheritDotParams stats::summary.manova
#'
#' @return A [tibble::tibble] with columns:
#' 
#'     \item{term}{Term in design}
#'     \item{statistic}{Approximate F statistic}
#'     \item{num.df}{Degrees of freedom}
#'     \item{p.value}{P-value}
#'
#' Depending on which test statistic is specified, one of the following
#' columns is also included:
#' 
#'     \item{pillai}{Pillai's trace}
#'     \item{wilks}{Wilk's lambda}
#'     \item{hl}{Hotelling-Lawley trace}
#'     \item{roy}{Roy's greatest root}
#'
#' @examples
#'
#' npk2 <- within(npk, foo <- rnorm(24))
#' m <- manova(cbind(yield, foo) ~ block + N * P * K, npk2)
#' tidy(m) 
#'
#' @export
#' @seealso [tidy()], [stats::summary.manova()]
#' @family anova tidiers
tidy.manova <- function(x, test = "Pillai", ...) {
  
  # TODO: use match.arg here
  test.pos <- pmatch(test, c(
    "Pillai", "Wilks",
    "Hotelling-Lawley", "Roy"
  ))
  test.name <- c("pillai", "wilks", "hl", "roy")[test.pos]
  
  nn <- c("df", test.name, "statistic", "num.df", "den.df", "p.value")
  fix_data_frame(summary(x, test = test, ...)$stats, nn)
}

#' @templateVar class TukeyHSD
#' @template title_desc_tidy
#'
#' @param x A `TukeyHSD` object return from [stats::TukeyHSD()].
#' @template param_unused_dots
#'
#' @return A [tibble::tibble] with one row per comparison and columns:
#' 
#'   \item{term}{Term for which levels are being compared}
#'   \item{comparison}{Levels being compared, separated by -}
#'   \item{estimate}{Estimate of difference}
#'   \item{conf.low}{Low end of confidence interval of difference}
#'   \item{conf.high}{High end of confidence interval of difference}
#'   \item{adj.p.value}{P-value adjusted for multiple comparisons}
#'
#' @examples
#'
#' fm1 <- aov(breaks ~ wool + tension, data = warpbreaks)
#' thsd <- TukeyHSD(fm1, "tension", ordered = TRUE)
#' tidy(thsd)
#'
#' # may include comparisons on multiple terms
#' fm2 <- aov(mpg ~ as.factor(gear) * as.factor(cyl), data = mtcars)
#' tidy(TukeyHSD(fm2))
#'
#' @export
#' @seealso [tidy()], [stats::TukeyHSD()]
#' @family anova tidiers
tidy.TukeyHSD <- function(x, ...) {
  purrr::map_df(x,
    function(e) {
      nn <- c("estimate", "conf.low", "conf.high", "adj.p.value")
      fix_data_frame(e, nn, "comparison")
    }, .id = "term"
  )
}
