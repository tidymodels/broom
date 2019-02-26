#' @templateVar class systemfit
#' @template title_desc_tidy
#' 
#' @param x A `systemfit` object produced by a call to [systemfit::systemfit()].
#' @template param_confint
#' @template param_unused_dots
#' 
#' @evalRd return_tidy(
#'   "term", 
#'   "estimate", 
#'   "std.error", 
#'   "mcmc.error", 
#'   "p.value",
#'   "conf.low",
#'   "conf.high"
#' )
#'
#' @details This tidy method works with any model objects of class `systemfit`. 
#'          Default returns a tibble of six columns.
#' @importFrom stats confint
#' @examples
#' library(systemfit)
#' df <- data.frame(X = rnorm(100), Y = rnorm(100), Z = rnorm(100), W = rnorm(100))
#'
#` fit <- systemfit(formula = list(Y ~ Z, W ~ X), data = df, method = "SUR")
#'
#' tidy(fit)
#' tidy(fit, conf.int = TRUE)
#' @export
#' @seealso [tidy()], [systemfit::systemfit()]
#' @family systemfit tidiers
#' @aliases systemfit_tidiers
tidy.systemfit <- function(x, conf.int = TRUE, ...) {
  nn <- c("term", "estimate", "std.error", "p.value")
  
  sf_summary <- summary(x)
  sf_coefs <- as.data.frame(sf_summary$coefficients)
  sf_coefs <- sf_coefs[,- which(names(sf_coefs) == "t value")]
  sf_coefs <- cbind(term = rownames(sf_coefs), sf_coefs)
  if(conf.int){
    nn <- c(nn, "conf.low", "conf.high")
    sf_cis <- confint(x)
    sf_cis <- matrix(sf_cis,ncol = 2)
    sf_coefs <- cbind(sf_coefs, sf_cis)
  }
  names(sf_coefs) <- nn
  rownames(sf_coefs) <- NULL
  
  ret <- as_broom_tibble(data = sf_coefs)
  
  return(ret)
}

