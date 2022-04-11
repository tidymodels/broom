#' @templateVar class htest
#' @template title_desc_tidy_glance
#'
#' @param x An `htest` objected, such as those created by [stats::cor.test()],
#'   [stats::t.test()], [stats::wilcox.test()], [stats::chisq.test()], etc.
#' @template param_unused_dots
#'
#' @evalRd  return_tidy(
#'   "estimate",
#'   "statistic",
#'   "p.value",
#'   "parameter",
#'   "conf.low",
#'   "conf.high",
#'   "estimate1",
#'   "estimate2",
#'   "method",
#'   "alternative"
#' )
#'
#' @examples
#'
#' tt <- t.test(rnorm(10))
#' 
#' tidy(tt)
#' 
#' # the glance output will be the same for each of the below tests
#' glance(tt)
#'
#' tt <- t.test(mpg ~ am, data = mtcars)
#' 
#' tidy(tt)
#'
#' wt <- wilcox.test(mpg ~ am, data = mtcars, conf.int = TRUE, exact = FALSE)
#' 
#' tidy(wt)
#'
#' ct <- cor.test(mtcars$wt, mtcars$mpg)
#' 
#' tidy(ct)
#'
#' chit <- chisq.test(xtabs(Freq ~ Sex + Class, data = as.data.frame(Titanic)))
#' 
#' tidy(chit)
#' augment(chit)
#' 
#' @aliases htest_tidiers
#' @export
#' @family htest tidiers
#' @seealso [tidy()], [stats::cor.test()], [stats::t.test()],
#'   [stats::wilcox.test()], [stats::chisq.test()]
tidy.htest <- function(x, ...) {
  ret <- x[c("estimate", "statistic", "p.value", "parameter")]

  # estimate may have multiple values
  if (length(ret$estimate) > 1) {
    names(ret$estimate) <- paste0("estimate", seq_along(ret$estimate))
    ret <- c(ret$estimate, ret)
    ret$estimate <- NULL

    # special case: in a t-test, estimate = estimate1 - estimate2
    if (x$method %in% c("Welch Two Sample t-test", " Two Sample t-test")) {
      ret <- c(estimate = ret$estimate1 - ret$estimate2, ret)
    }
  }

  # parameter may have multiple values as well, such as oneway.test
  if (length(x$parameter) > 1) {
    ret$parameter <- NULL
    if (is.null(names(x$parameter))) {
      warning("Multiple unnamed parameters in hypothesis test; dropping them")
    } else {
      # rename num df to num.df and denom df to denom.df
      np <- names(x$parameter)
      np <- stringr::str_replace(np, "num df", "num.df")
      np <- stringr::str_replace(np, "denom df", "den.df")
      names(x$parameter) <- np
      
      message(
        "Multiple parameters; naming those columns ",
        paste(np, collapse = ", ")
      )
      
      ret <- append(ret, x$parameter, after = 1)
    }
  }

  ret <- purrr::compact(ret)
  if (!is.null(x$conf.int)) {
    ret <- c(ret, conf.low = x$conf.int[1], conf.high = x$conf.int[2])
  }
  if (!is.null(x$method)) {
    ret <- c(ret, method = trimws(as.character(x$method)))
  }
  if (!is.null(x$alternative)) {
    ret <- c(ret, alternative = as.character(x$alternative))
  }
  as_tibble(ret)
}


#' @rdname tidy.htest
#' @export
glance.htest <- function(x, ...) tidy(x)

#' @templateVar class htest
#' @template title_desc_augment
#'
#' @inherit tidy.htest params examples
#'
#' @evalRd return_glance(
#'   .observed = "Observed count.",
#'   .prop = "Proportion of the total.",
#'   .row.prop = "Row proportion (2 dimensions table only).",
#'   .col.prop = "Column proportion (2 dimensions table only).",
#'   .expected = "Expected count under the null hypothesis.",
#'   .resid = "Pearson residuals.",
#'   .std.resid = "Standardized residual."
#' )
#'
#' @details See [stats::chisq.test()] for more details on
#' how residuals are computed.
#'
#' @export
#' @seealso [augment()], [stats::chisq.test()]
#' @family htest tidiers
augment.htest <- function(x, ...) {
  if (all(c("observed", "expected", "residuals", "stdres") %in% names(x))) {
    return(augment_chisq_test(x, ...))
  }

  stop(
    "Augment is only defined for chi squared hypothesis tests.",
    call. = FALSE
  )
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
  ret <- cbind(ret, .resid = as.data.frame(as.table(x$residuals))[[d + 1]])
  ret <- cbind(ret, .std.resid = as.data.frame(as.table(x$stdres))[[d + 1]])
  as_tibble(ret)
}



#' @templateVar class pairwise.htest
#' @template title_desc_tidy
#'
#' @param x A `pairwise.htest` object such as those returned from
#'   [stats::pairwise.t.test()] or [stats::pairwise.wilcox.test()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy("group1", "group2", "p.value")
#'
#' @details Note that in one-sided tests, the alternative hypothesis of each
#'   test can be stated as "group1 is greater/less than group2".
#'
#' Note also that the columns of group1 and group2 will always be a factor,
#' even if the original input is (e.g.) numeric.
#'
#' @examples
#'
#' # feel free to ignore the following line—it allows {broom} to supply 
#' # examples without requiring the data-supplying package to be installed.
#' if (requireNamespace("modeldata", quietly = TRUE)) {
#'
#' attach(airquality)
#' Month <- factor(Month, labels = month.abb[5:9])
#' ptt <- pairwise.t.test(Ozone, Month)
#' tidy(ptt)
#'
#' library(modeldata)
#' data(hpc_data)
#' attach(hpc_data)
#' ptt2 <- pairwise.t.test(compounds, class)
#' tidy(ptt2)
#'
#' tidy(pairwise.t.test(compounds, class, alternative = "greater"))
#' tidy(pairwise.t.test(compounds, class, alternative = "less"))
#'
#' tidy(pairwise.wilcox.test(compounds, class))
#' 
#' }
#' 
#' @export
#' @seealso [stats::pairwise.t.test()], [stats::pairwise.wilcox.test()],
#'   [tidy()]
#' @family htest tidiers
#'
tidy.pairwise.htest <- function(x, ...) {
  tibble(group1 = rownames(x$p.value)) %>%
    cbind(x$p.value) %>%
    pivot_longer(
      cols = c(dplyr::everything(), -group1),
      names_to = "group2",
      values_to = "p.value"
    ) %>%
    stats::na.omit() %>%
    as_tibble()
}

#' @templateVar class power.htest
#' @template title_desc_tidy
#'
#' @param x A `power.htest` object such as those returned from
#'   [stats::power.t.test()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy("n", "delta", "sd", "sig.level", "power")
#'
#' @examples
#'
#' ptt <- power.t.test(n = 2:30, delta = 1)
#' tidy(ptt)
#'
#' library(ggplot2)
#'
#' ggplot(tidy(ptt), aes(n, power)) +
#'   geom_line()
#' @export
#' @family htest tidiers
#' @seealso [stats::power.t.test()]
tidy.power.htest <- function(x, ...) {
  cols <- purrr::compact(x[c("n", "delta", "sd", "sig.level", "power", "p1", "p2")])
  as_tibble(cols)
}
