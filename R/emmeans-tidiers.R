#' @templateVar class lsmobj
#' @template title_desc_tidy
#'
#' @param x An `lsmobj` object.
#' @template param_confint
#' @param ... Additional arguments passed to [emmeans::summary.emmGrid()] or
#'   [lsmeans::summary.ref.grid()]. **Cautionary note**: misspecified arguments
#'   may be silently ignored!
#'
#' @evalRd return_tidy(
#'   "contrast",
#'   "null.value",
#'   estimate = "Expected marginal mean",
#'   "std.error",
#'   "df",
#'   "conf.low",
#'   "conf.high",
#'   statistic = "T-ratio statistic",
#'   "p.value"
#' )
#'
#' @details Returns a data frame with one observation for each estimated marginal
#'   mean, and one column for each combination of factors. When the input is a
#'   contrast, each row will contain one estimated contrast.
#'
#'   There are a large number of arguments that can be
#'   passed on to [emmeans::summary.emmGrid()] or [lsmeans::summary.ref.grid()].
#'
#' @examples
#' 
#' # feel free to ignore the following line—it allows {broom} to supply 
#' # examples without requiring the model-supplying package to be installed.
#' if (requireNamespace("emmeans", quietly = TRUE)) {
#'
#' # load libraries for models and data
#' library(emmeans)
#' 
#' # linear model for sales of oranges per day
#' oranges_lm1 <- lm(sales1 ~ price1 + price2 + day + store, data = oranges)
#'
#' # reference grid; see vignette("basics", package = "emmeans")
#' oranges_rg1 <- ref_grid(oranges_lm1)
#' td <- tidy(oranges_rg1)
#' td
#'
#' # marginal averages
#' marginal <- emmeans(oranges_rg1, "day")
#' tidy(marginal)
#'
#' # contrasts
#' tidy(contrast(marginal))
#' tidy(contrast(marginal, method = "pairwise"))
#'
#' # plot confidence intervals
#' library(ggplot2)
#' 
#' ggplot(tidy(marginal, conf.int = TRUE), aes(day, estimate)) +
#'   geom_point() +
#'   geom_errorbar(aes(ymin = conf.low, ymax = conf.high))
#'
#' # by multiple prices
#' by_price <- emmeans(oranges_lm1, "day",
#'   by = "price2",
#'   at = list(
#'     price1 = 50, price2 = c(40, 60, 80),
#'     day = c("2", "3", "4")
#'   )
#' )
#' 
#' by_price
#' 
#' tidy(by_price)
#'
#' ggplot(tidy(by_price, conf.int = TRUE), aes(price2, estimate, color = day)) +
#'   geom_line() +
#'   geom_errorbar(aes(ymin = conf.low, ymax = conf.high))
#'
#' # joint_tests
#' tidy(joint_tests(oranges_lm1))
#' 
#' }
#' 
#' @aliases emmeans_tidiers
#' @export
#' @family emmeans tidiers
#' @seealso [tidy()], [emmeans::ref_grid()], [emmeans::emmeans()],
#'   [emmeans::contrast()]
tidy.lsmobj <- function(x, conf.int = FALSE, conf.level = .95, ...) {
  tidy_emmeans(x, infer = c(conf.int, TRUE), level = conf.level, ...)
}

#' @templateVar class ref.grid
#' @template title_desc_tidy
#'
#' @param x A `ref.grid` object created by [emmeans::ref_grid()].
#' @inherit tidy.lsmobj params examples details
#'
#' @evalRd return_tidy(
#'   estimate = "Expected marginal mean",
#'   "std.error",
#'   "df",
#'   "conf.low",
#'   "conf.high",
#'   statistic = "T-ratio statistic",
#'   "p.value"
#' )
#'
#' @export
#' @family emmeans tidiers
#' @seealso [tidy()], [emmeans::ref_grid()], [emmeans::emmeans()],
#'   [emmeans::contrast()]
tidy.ref.grid <- function(x, conf.int = FALSE, conf.level = .95, ...) {
  tidy_emmeans(x, infer = c(conf.int, TRUE), level = conf.level, ...)
}

#' @templateVar class emmGrid
#' @template title_desc_tidy
#'
#' @param x An `emmGrid` object.
#' @inherit tidy.lsmobj params examples details
#'
#' @evalRd return_tidy(
#'   estimate = "Expected marginal mean",
#'   "std.error",
#'   "df",
#'   "conf.low",
#'   "conf.high",
#'   statistic = "T-ratio statistic",
#'   "p.value"
#' )
#'
#' @export
#' @family emmeans tidiers
#' @seealso [tidy()], [emmeans::ref_grid()], [emmeans::emmeans()],
#'   [emmeans::contrast()]
tidy.emmGrid <- function(x, conf.int = FALSE, conf.level = .95, ...) {
  tidy_emmeans(x, infer = c(conf.int, TRUE), level = conf.level, ...)
}

#' @templateVar class summary_emm
#' @template title_desc_tidy
#'
#' @param x A `summary_emm` object.
#' @param null.value Value to which estimate is compared.
#' @inherit tidy.lsmobj params examples details
#'
#' @evalRd return_tidy(
#'   "contrast",
#'   level1 = "One level of the factor being contrasted",
#'   level2 = "The other level of the factor being contrasted",
#'   term = "Model term in joint tests",
#'   "null.value",
#'   estimate = "Expected marginal mean",
#'   "std.error",
#'   "df",
#'   "num.df",
#'   "den.df",
#'   "conf.low",
#'   "conf.high",
#'   statistic = "T-ratio statistic or F-ratio statistic",
#'   "p.value"
#' )
#'
#' @export
#' @family emmeans tidiers
#' @seealso [tidy()], [emmeans::ref_grid()], [emmeans::emmeans()],
#'   [emmeans::contrast()]

tidy.summary_emm <- function(x, null.value = NULL, ...) {
  tidy_emmeans_summary(x, null.value = null.value)
}



tidy_emmeans <- function(x, ...) {
  s <- summary(x, ...)

  # Get null.value
  if (".offset." %in% colnames(x@grid)) {
    null.value <- x@grid[, ".offset."]
  } else {
    null.value <- 0
  }

  # Get term names
  term_names <- names(x@misc$orig.grid)

  tidy_emmeans_summary(s, null.value = null.value, term_names = term_names)
}

tidy_emmeans_summary <- function(x, null.value = NULL, term_names = NULL) {
  ret <- as.data.frame(x)
  repl <- list(
    "lsmean" = "estimate",
    "emmean" = "estimate",
    "pmmean" = "estimate",
    "prediction" = "estimate",
    "effect.size" = "estimate",
    "SE" = "std.error",
    "lower.CL" = "conf.low",
    "asymp.LCL" = "conf.low",
    "upper.CL" = "conf.high",
    "asymp.UCL" = "conf.high",
    "z.ratio" = "statistic",
    "t.ratio" = "statistic",
    "F.ratio" = "statistic",
    "df1" = "num.df",
    "df2" = "den.df",
    "model term" = "term"
  )

  mc_adjusted <- any(
    grepl(
      "conf-level adjustment|p value adjustment",
      attr(x, "mesg"),
      ignore.case = TRUE
    )
  )

  if (mc_adjusted) {
    repl <- c(repl, "p.value" = "adj.p.value")
  }

  colnames(ret) <- dplyr::recode(colnames(ret), !!!(repl))

  # If contrast column exists, add null.value column
  if ("contrast" %in% colnames(ret)) {
    if (length(null.value) < nrow(ret)) null.value <- rep_len(null.value, nrow(ret))
    ret <- bind_cols(contrast = ret[, "contrast"], null.value = null.value, select(ret, -contrast))
  }

  # add term column, if appropriate, unless it exists
  if ("term" %in% colnames(ret)) {
    ret <- ret %>%
      mutate(term = stringr::str_trim(term))
  } else if (!is.null(term_names)) {
    term <- term_names[!term_names %in% colnames(ret)]

    if (length(term) != 0) {
      term <- paste(term_names[!term_names %in% colnames(ret)], collapse = "*") %>%
        rep_len(nrow(ret))
    } else { # No missing term names, because combine = TRUE?
      term <- apply(ret, 1, function(x) colnames(ret)[which(x == ".")])
    }

    ret <- bind_cols(ret[, colnames(ret) %in% term_names, drop = FALSE], 
                     term = term, 
                     ret[, !colnames(ret) %in% term_names, drop = FALSE])
  }

  as_tibble(ret) %>%
    mutate_if(is.factor, as.character)
}
