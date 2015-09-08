#' Tidying methods for rcorr objects
#' 
#' Tidies a correlation matrix from the \code{rcorr} function in the
#' "Hmisc" package, including correlation estimates, p-values,
#' and the number of observations in each pairwise correlation.
#' Note that it returns these in "long", or "melted", format,
#' with one row for each pair of columns being compared.
#' 
#' @param x An object of class "rcorr"
#' @param names Optionally, the column names of the original
#' matrix, to use to fill in these columns.
#' @param diagonal Whether to include diagonal elements (where
#' \code{estimate} is 1 and \code{p.value} is NA), default FALSE
#' @param ... extra arguments (not used)
#' 
#' @return A data.frame with one row for each pairing
#' in the correlation matrix. Columns are:
#'   \item{column1}{The first column being described. A number, unless
#'   \code{names} is provided, in which case it will be the name}
#'   \item{column2}{The second column being described. A number, unless
#'   \code{names} is provided, in which case it will be the name}
#'   \item{estimate}{Estimate of Pearson's r or Spearman's rho}
#'   \item{n}{Number of observations used to compute the correlation}
#'   \item{p.value}{P-value of correlation}
#' 
#' @examples
#' 
#' if (require("Hmisc", quietly = TRUE)) {
#'     mat <- replicate(100, rnorm(100))
#'     # add some NAs
#'     mat[sample(length(mat), 2000)] <- NA
#'     
#'     rc <- rcorr(mat)
#'     
#'     td <- tidy(rc)
#'     head(td)
#'     
#'     library(ggplot2)
#'     ggplot(td, aes(p.value)) +
#'         geom_histogram(binwidth = .1)
#'  
#'     ggplot(td, aes(estimate, p.value)) +
#'         geom_point() +
#'         scale_y_log10()
#' }
#' 
#' @name rcorr_tidiers
#' 
#' @export
tidy.rcorr <- function(x, names = NULL, diagonal = FALSE, ...) {
    if (!is.null(names)) {
        rownames(x$r) <- colnames(x$r) <- names
    }
    
    ret <- reshape2::melt(x$r, varnames = c("column1", "column2"),
                          value.name = "estimate")
    ret$n <- c(x$n)
    ret$p.value <- c(x$P)
    
    if (!diagonal) {
        ret <- filter(ret, column1 != column2)
    }
    
    ret
}
