#' Tidying methods for an htest object
#'
#' Tidies hypothesis test objects, such as those from
#' [stats::cor.test()], [stats::t.test()],
#' [stats::wilcox.test()], and [stats::chisq.test()],
#' into a one-row data frame.
#'
#' @details `augment` method is defined only for chi-squared tests,
#' since there is no sense, for other tests, in which a hypothesis test
#' generates one value for each observation.
#'
#' @param x An object of class `"htest"`
#' @param ... extra arguments (not used)
#'
#' @return Both `tidy` and `glance` return the same output,
#' a one-row data frame with one or more of the following columns:
#'   \item{estimate}{Estimate of the effect size}
#'   \item{statistic}{Test statistic used to compute the p-value}
#'   \item{p.value}{P-value}
#'   \item{parameter}{Parameter field in the htest, typically degrees of
#'   freedom}
#'   \item{conf.low}{Lower bound on a confidence interval}
#'   \item{conf.high}{Upper bound on a confidence interval}
#'   \item{estimate1}{Sometimes two estimates are computed, such as in a
#'   two-sample t-test}
#'   \item{estimate2}{Sometimes two estimates are computed, such as in a
#'   two-sample t-test}
#'   \item{method}{Method used to compute the statistic as a string}
#'   \item{alternative}{Alternative hypothesis as a string}
#'
#' Which columns are included depends on the hypothesis test used.
#'
#' For chi-squared tests, `augment.htest`  will returns, for each
#' cell of the tested table, the additional columns:
#'   \item{.observed}{Observed count}
#'   \item{.prop}{Proportion of the total}
#'   \item{.row.prop}{Row proportion (2 dimensions table only)}
#'   \item{.col.prop}{Column proportion (2 dimensions table only)}
#'   \item{.expected}{Expected count under the null hypothesis}
#'   \item{.residuals}{Pearson residual}
#'   \item{.stdres}{Standardized residual}
#'
#' See [stats::chisq.test()] for more details on
#' how residuals are computed.
#'
#' @examples
#'
#' tt <- t.test(rnorm(10))
#' tidy(tt)
#' glance(tt)  # same output for all htests
#'
#' tt <- t.test(mpg ~ am, data = mtcars)
#' tidy(tt)
#'
#' wt <- wilcox.test(mpg ~ am, data = mtcars, conf.int = TRUE, exact = FALSE)
#' tidy(wt)
#'
#' ct <- cor.test(mtcars$wt, mtcars$mpg)
#' tidy(ct)
#'
#' chit <- chisq.test(xtabs(Freq ~ Sex + Class, data = as.data.frame(Titanic)))
#' tidy(chit)
#' augment(chit)
#'
#' @name htest_tidiers
NULL


#' @rdname htest_tidiers
#' @export
tidy.htest <- function(x, ...) {
  ret <- x[c("estimate", "statistic", "p.value", "parameter")]

  # estimate may have multiple values
  if (length(ret$estimate) > 1) {
    names(ret$estimate) <- paste0("estimate", seq_along(ret$estimate))
    ret <- c(ret$estimate, ret)
    ret$estimate <- NULL

    # special case: in a t-test, estimate = estimate1 - estimate2
    if (x$method == "Welch Two Sample t-test") {
      ret <- c(estimate = ret$estimate1 - ret$estimate2, ret)
    }
  }

  # parameter may have multiple values as well, such as oneway.test
  if (length(x$parameter) > 1) {
    ret$parameter <- NULL
    if (is.null(names(x$parameter))) {
      warning("Multiple unnamed parameters in hypothesis test; dropping them")
    } else {
      message(
        "Multiple parameters; naming those columns ",
        paste(make.names(names(x$parameter)), collapse = ", ")
      )
      ret <- append(ret, x$parameter, after = 1)
    }
  }

  ret <- compact(ret)
  if (!is.null(x$conf.int)) {
    ret <- c(ret, conf.low = x$conf.int[1], conf.high = x$conf.int[2])
  }
  if (!is.null(x$method)) {
    ret <- c(ret, method = as.character(x$method))
  }
  if (!is.null(x$alternative)) {
    ret <- c(ret, alternative = as.character(x$alternative))
  }
  as_tibble(ret)
}


#' @rdname htest_tidiers
#' @export
glance.htest <- function(x, ...) tidy(x)

#' @rdname htest_tidiers
#' @export
augment.htest <- function(x, ...) {
  if (all(c("observed", "expected", "residuals", "stdres") %in% names(x))) {
    return(augment_chisq_test(x, ...))
  } else {
    stop(
      "Augment is only defined for chi squared hypothesis tests.",
      call. = FALSE
    )
  }
}

augment_chisq_test <- function(x, ...) {
  d <- length(dimnames(as.table(x$observed)))
  ret <- as.data.frame(as.table(x$observed))
  names(ret)[d + 1] <- ".observed"

  ret <- cbind(
    ret,
    .prop = as.data.frame(prop.table(as.table(x$observed)))[[d + 1]]
  )
  if (d == 2) {
    ret <- cbind(
      ret,
      .row.prop = as.data.frame(prop.table(as.table(x$observed), 1))[[d + 1]]
    )
    ret <- cbind(
      ret,
      .col.prop = as.data.frame(prop.table(as.table(x$observed), 2))[[d + 1]]
    )
  }

  ret <- cbind(ret, .expected = as.data.frame(as.table(x$expected))[[d + 1]])
  ret <- cbind(ret, .residuals = as.data.frame(as.table(x$residuals))[[d + 1]])
  ret <- cbind(ret, .stdres = as.data.frame(as.table(x$stdres))[[d + 1]])
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
