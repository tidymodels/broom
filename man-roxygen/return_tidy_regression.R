#' @return A [tibble::tibble()] with one row for each term in the 
#'   regression. The tibble has columns:
#'   
#'   \item{term}{The name of the regression term.}
#'   \item{estimate}{The estimated value of the regression term.}
#'   \item{std.error}{The standard error of the regression term.}
#'   \item{statistic}{The value of a statistic, almost always a T-statistic,
#'     to use in a hypothesis that the regression term is non-zero.}
#'   \item{p.value}{The two-sided p-value associated with the observed
#'     statistic.}
#'   \item{conf.low}{The low end of a confidence interval for the regression
#'     term. Included only if `conf.int = TRUE`.}
#'   \item{conf.high}{The high end of a confidence interval for the regression
#'     term. Included only if `conf.int = TRUE`.}
#' 
#' @md
