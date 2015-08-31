#' Tidy a kappa object from a Cohen's kappa calculation
#' 
#' Tidy a "kappa" object, from the \code{\link{cohen.kappa}} function
#' in the psych package. This represents the agreement of two raters
#' when using nominal scores.
#' 
#' @param x An object of class "kappa"
#' @param ... extra arguments (not used)
#' 
#' @return A data.frame with columns
#'   \item{type}{Either "weighted" or "unweighted"}
#'   \item{estimate}{The estimated value of kappa with this method}
#'   \item{conf.low}{Lower bound of confidence interval}
#'   \item{conf.high}{Upper bound of confidence interval}
#' 
#' @details Note that the alpha of the confidence interval is determined
#' when the \code{cohen.kappa} function is originally run.
#' 
#' @seealso \code{\link{cohen.kappa}}
#' 
#' @name kappa_tidiers
#' 
#' @examples
#' 
#' library(psych)
#' 
#' rater1 = 1:9
#' rater2 = c(1, 3, 1, 6, 1, 5, 5, 6, 7)
#' ck <- cohen.kappa(cbind(rater1, rater2))
#' 
#' tidy(ck)
#' 
#' # graph the confidence intervals
#' library(ggplot2)
#' ggplot(tidy(ck), aes(estimate, type)) +
#'     geom_point() +
#'     geom_errorbarh(aes(xmin = conf.low, xmax = conf.high))
#' 
#' @name anova_tidiers
#' 
#' @export
tidy.kappa <- function(x, ...) {
    nn <- c("conf.low", "estimate", "conf.high")
    ret <- fix_data_frame(x$confid, nn, newcol = "type") %>%
        select(type, estimate, conf.low, conf.high) %>%
        mutate(type = gsub(" kappa", "", type))
    
    ret
}
