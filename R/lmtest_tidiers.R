#' Tidying methods for coeftest objects
#' 
#' This tidies the result of a coefficient test, from the \code{coeftest}
#' function in the \code{lmtest} package.
#' 
#' @param x coeftest object
#' @param ... extra arguments (not used)
#' 
#' @return A \code{data.frame} with one row for each coefficient, with five columns:
#'   \item{term}{The term in the linear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error}
#'   \item{statistic}{test statistic}
#'   \item{p.value}{p-value}
#'
#' @examples
#' 
#' if (require("lmtest", quietly = TRUE)) {
#'     data(Mandible)
#'     fm <- lm(length ~ age, data=Mandible, subset=(age <= 28))
#'     
#'     coeftest(fm)
#'     tidy(coeftest(fm))
#' }
#'
#' @export
tidy.coeftest <- function(x, ...) {
    co <- as.data.frame(unclass(x))
    nn <- c("estimate", "std.error", "statistic", "p.value")[1:ncol(co)]
    ret <- fix_data_frame(co, nn)
    ret
}
