#' Tidying method for the acf function
#' 
#' Tidy the output of \code{acf} and related \code{pcf} and \code{ccf} functions.
#' 
#' @name acf_tidiers
#' 
#' @param x acf object
#' @param ... (not used)
#' 
#' @return \code{data.frame} with columns
#'  \item{lag}{lag values}
#'  \item{acf}{calucated correlation}
#'  
#' @examples
#' 
#' # acf
#' result <- acf(lh, plot=FALSE)
#' tidy(result)
#' 
#' # ccf
#' result <- ccf(mdeaths, fdeaths, plot=FALSE)
#' tidy(result)
#' 
#' # pcf
#' result <- pacf(lh, plot=FALSE)
#' tidy(result)
#' 
#' # lag plot
#' library(ggplot2)
#' result <- tidy(acf(lh, plot=FALSE))
#' p <- ggplot(result, aes(x=lag, y=acf)) + 
#'          geom_bar(stat='identity', width=0.1) +
#'          theme_bw()
#' p
#' 
#' # with confidence intervals 
#' conf.level <- 0.95
#' # from \code{plot.acf} method
#' len.data <- length(lh) # same as acf$n.used
#' conf.int <- qnorm((1 + conf.level) / 2) / sqrt(len.data)
#' p + geom_hline(yintercept = c(-conf.int, conf.int),
#'                color='blue', linetype='dashed')
NULL

#' @rdname acf_tidiers
#' 
#' @export
tidy.acf <- function(x, ...) {
    process_cf(x)
}

#' @rdname acf_tidiers
#' 
#' @export
tidy.pcf <- tidy.acf

#' @rdname acf_tidiers
#' 
#' @export
tidy.ccf <- tidy.acf

process_cf <- function(x) {
    ret <- with(x, data.frame(lag = x$lag,
                              acf = x$acf))
    return(ret)
} 
