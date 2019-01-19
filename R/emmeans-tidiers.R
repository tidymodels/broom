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
#'   "std.error", 
#'   "df", 
#'   "conf.low", 
#'   "conf.high",
#'   level1 = "One level of the factor being contrasted",
#'   level2 = "The other level of the factor being contrasted",
#'   "contrast",
#'   "p.value",
#'   statistic = "T-ratio statistic",
#'   estimate = "Estimated least-squares mean."
#' )
#'
#' @details Returns a data frame with one observation for each estimated
#'   mean, and one column for each combination of factors. When the input is a
#'   contrast, each row will contain one estimated contrast.
#'
#'   There are a large number of arguments that can be
#'   passed on to [emmeans::summary.emmGrid()] or [lsmeans::summary.ref.grid()].
#'
#' @examples
#'
#' library(emmeans)
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
#' ggplot(tidy(marginal), aes(day, estimate)) +
#'   geom_point() +
#'   geom_errorbar(aes(ymin = conf.low, ymax = conf.high))
#'
#' # by multiple prices
#' by_price <- emmeans(oranges_lm1, "day", by = "price2",
#'                     at = list(price1 = 50, price2 = c(40, 60, 80),
#'                     day = c("2", "3", "4")) )
#' by_price
#' tidy(by_price)
#'
#' ggplot(tidy(by_price), aes(price2, estimate, color = day)) +
#'   geom_line() +
#'   geom_errorbar(aes(ymin = conf.low, ymax = conf.high))
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
#'   "std.error", 
#'   "df", 
#'   "conf.low", 
#'   "conf.high",
#'   level1 = "One level of the factor being contrasted",
#'   level2 = "The other level of the factor being contrasted",
#'   "contrast",
#'   "p.value",
#'   statistic = "T-ratio statistic",
#'   estimate = "Estimated least-squares mean."
#' )
#'
#' @export
#' @family emmeans tidiers
#' @seealso [tidy()], [emmeans::ref_grid()], [emmeans::emmeans()],
#'   [emmeans::contrast()]
tidy.ref.grid <- function(x, ...) {
  tidy_emmeans(x, ...)
}

#' @templateVar class emmGrid
#' @template title_desc_tidy
#' 
#' @param x An `emmGrid` object.
#' @inherit tidy.lsmobj params examples details 
#'   
#' @evalRd return_tidy(
#'   "std.error", 
#'   "df", 
#'   "conf.low", 
#'   "conf.high",
#'   level1 = "One level of the factor being contrasted",
#'   level2 = "The other level of the factor being contrasted",
#'   "contrast",
#'   "p.value",
#'   statistic = "T-ratio statistic",
#'   estimate = "Estimated least-squares mean."
#' )
#'
#' @export
#' @family emmeans tidiers
#' @seealso [tidy()], [emmeans::ref_grid()], [emmeans::emmeans()],
#'   [emmeans::contrast()]
tidy.emmGrid <- function(x, ...) {
  tidy_emmeans(x, ...)
}

tidy_emmeans <- function(x, ...) {
  s <- summary(x, ...)
  ret <- as.data.frame(s)
  repl <- list(
    "lsmean" = "estimate",
    "emmean" = "estimate",
    "pmmean" = "estimate",
    "prediction" = "estimate",
    "SE" = "std.error",
    "lower.CL" = "conf.low",
    "upper.CL" = "conf.high",
    "t.ratio" = "statistic"
  )

  if ("contrast" %in% colnames(ret) &&
    all(stringr::str_detect(ret$contrast, " - "))) {
    ret <- tidyr::separate_(ret, "contrast",
      c("level1", "level2"),
      sep = " - "
    )
  }

  colnames(ret) <- dplyr::recode(colnames(ret), !!!(repl))
  as_tibble(ret)
}
