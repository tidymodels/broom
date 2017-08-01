#' Tidying methods for lavaan models
#' 
#' These methods tidy the coefficients of lavaan CFA and SEM models.
#' 
#' @param x An object of class \code{lavaan}, such as those from \code{cfa}, 
#' or \code{sem}
#' 
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#' 
#' @name lavaan_tidiers
#'
NULL


#' @rdname lavaan_tidiers
#' 
#' @param standardized Are standardised estimates required
#' @param conf.level confidence level for CI
#' 
#' @return \code{tidy} returns one row for each estimated parameter
#' It contains the columns
#'   \item{term}{The result of paste(lhs, op, rhs)}
#'   \item{op}{The operator in the model syntax (e.g. ~~ for covariances, or ~ for regression parameters)}
#'   \item{estimate}{The parameter estimate (may be standardized)}
#'   \item{std.error}{}
#'   \item{statistic}{The z value returned by lavaan::parameterEstimates}
#'   \item{p.value}{}
#'   \item{conf.low}{}
#'   \item{conf.high}{}
#' 
#' @import dplyr 
#' 
#' @export
tidy.lavaan <- function(x, 
                        conf.int = TRUE,
                        conf.level = 0.95,
                        standardized=FALSE,
                        ...){
    tidyframe <- parameterEstimates(x, 
                       ci=conf.int, 
                       level=conf.level,
                       standardized=standardized) %>% 
        as_data_frame() %>% 
        tibble::rownames_to_column() %>% 
        mutate(term=paste(lhs, op, rhs)) %>% 
        rename(estimate=est, 
               std.error = se,
               p.value=pvalue,
               statistic = z,
               conf.low=ci.lower,
               conf.hi=ci.upper) %>% 
        select(term, op, everything(), -rowname, -lhs, -rhs)
    return(tidyframe)
}


#' @rdname lavaan_tidiers
#' 
#' @param ... extra arguments (not used)
#' 
#' @return \code{glance} returns one row with the columns
#'   \item{k}{The number of parameters}
#'   \item{ChiSq}{}
#'   \item{RMSEA}{}
#'   \item{AIC}{}
#'   \item{BIC}{}
#'   \item{CFI}{}
#' 
#' @export
glance.lavaan <- function(m, long=TRUE, ...) {
    fitms <- c('npar', 'chisq', 'rmsea', 'aic', 'bic', 'cfi', 'logl')
    m %>% 
        fitmeasures(fit.measures=fitms) %>% 
        as_data_frame() %>% 
        tibble::rownames_to_column(var = 'term') %>% 
        rename(estimate=value) %>% 
        tidyr::spread("term", "estimate") %>% 
        rename(logLik = logl, 
               k = npar,
               AIC=aic, BIC=bic, CFI=cfi, RMSEA=rmsea,
               ChiSq = chisq) %>% 
        select(k, ChiSq, RMSEA, everything()) %>% 
        return(.)
}




