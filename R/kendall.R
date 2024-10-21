#' @templateVar class Kendall
#' @template title_desc_tidy
#'
#' @param x A `Kendall` object returned from a call to [Kendall::Kendall()],
#'   [Kendall::MannKendall()], or [Kendall::SeasonalMannKendall()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "p.value",
#'   "kendall_score",
#'   "var_kendall_score",
#'   statistic = "Kendall's tau statistic",
#'   denominator = "The denominator, which is tau=kendall_score/denominator."
#' )
#'
#' @examplesIf rlang::is_installed("Kendall")
#'
#' # load libraries for models and data
#' library(Kendall)
#'
#' A <- c(2.5, 2.5, 2.5, 2.5, 5, 6.5, 6.5, 10, 10, 10, 10, 10, 14, 14, 14, 16, 17)
#' B <- c(1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2)
#'
#' # fit models and summarize results
#' f_res <- Kendall(A, B)
#' tidy(f_res)
#'
#' s_res <- MannKendall(B)
#' tidy(s_res)
#'
#' t_res <- SeasonalMannKendall(ts(A))
#' tidy(t_res)
#'
#' @export
#' @seealso [tidy()], [Kendall::Kendall()], [Kendall::MannKendall()],
#'   [Kendall::SeasonalMannKendall()]
#' @aliases Kendall_tidiers kendall_tidiers
#'
tidy.Kendall <- function(x, ...) {
  col_names <- c(
    "statistic",
    "p.value",
    "kendall_score",
    "denominator",
    "var_kendall_score"
  )
  ret <- as_tibble(unclass(x))
  set_names(ret, col_names)
}
