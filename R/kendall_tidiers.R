#' Tidying methods for Kendall objects
#'
#' Tidies the result of an Kendall rank correlation. Works on all functions from the Kendall package.
#' Only a `tidy()` method is provided, not an `augment()` or `glance()` method.
#' 
#' @param x Fitted object from the Kendall package.
#' @param ... Unused.
#'
#' @return `tidy()` returns a [tibble::tibble()] with one row and columns:
#' 
#' \item{statistic}{Kendall's tau statistic.}
#' \item{p.value}{two-sided p-value.}
#' \item{kendall_score}{Kendall score.}
#' \item{denominator}{The denominator, which is tau=kendall_score/denominator.}
#' \item{var_kendall_score}{Variance of the kendall_score.}
#' 
#' @seealso [Kendall::Kendall()] for details on the meaning of each column and implementation.
#' 
#' @export
#'
#' @examples
#' library(Kendall)
#' 
#' ### For Kendall ####
#' A <- c(2.5,2.5,2.5,2.5,5,6.5,6.5,10,10,10,10,10,14,14,14,16,17)
#' B <- c(1,1,1,1,2,1,1,2,1,1,1,1,1,1,2,2,2)
#' f_res <- Kendall(A,B)
#' 
#' tidy(f_res)
#' 
#' ### For MannKendall ####
#' s_res <- MannKendall(B)
#' 
#' tidy(s_res)
#' 
#' ### For SeasonalMannKendall ####
#' t_res <- SeasonalMannKendall(ts(A))
#' 
#' tidy(t_res)
tidy.Kendall <- function(x, ...) {
  col_names <- c("statistic",
                 "p.value",
                 "kendall_score",
                 "denominator",
                 "var_kendall_score")
  semi_done <- tibble::as_tibble(unclass(x))
  final <- purrr::set_names(semi_done, col_names)
  final
}
