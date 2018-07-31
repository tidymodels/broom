#' @templateVar class Kendall
#' @template title_desc_tidy
#'
#' @param x A `Kendall` object returned from a call to [Kendall::Kendall()],
#'   [Kendall::MannKendall()], or [Kendall::SeasonalMannKendall()].
#' @template param_unused_dots
#'
#' @return A [tibble::tibble] with one row and columns:
#'
#' \item{statistic}{Kendall's tau statistic.}
#' \item{p.value}{two-sided p-value.}
#' \item{kendall_score}{Kendall score.}
#' \item{denominator}{The denominator, which is tau=kendall_score/denominator.}
#' \item{var_kendall_score}{Variance of the kendall_score.}
#' 
#' @examples
#' library(Kendall)
#' 
#' A <- c(2.5,2.5,2.5,2.5,5,6.5,6.5,10,10,10,10,10,14,14,14,16,17)
#' B <- c(1,1,1,1,2,1,1,2,1,1,1,1,1,1,2,2,2)
#' 
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
