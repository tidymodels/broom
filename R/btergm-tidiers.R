#' @templateVar class btergm
#' @template title_desc_tidy
#' 
#' @description This method tidies the coefficients of a bootstrapped
#'   temporal exponential random graph model estimated with the \pkg{xergm}.
#'   It simply returns the coefficients and their confidence intervals.
#'
#' @param x A [btergm::btergm()] object.
#' @param conf.level Confidence level for confidence intervals. Defaults to
#'   0.95.
#' @template param_exponentiate
#' @template param_unused_dots
#'
#' @evalRd return_tidy("term", "estimate", "conf.low", "conf.high")
#'   
#' @examples
#' 
<<<<<<< HEAD
#' library(btergm)
#' set.seed(1)
#' 
#' # Create 10 random networks with 10 actors
#' 
#' networks <- list()
#' 
=======
#' \dontrun{
#' library(xergm)
#' 
#' set.seed(1)
#' # Using the same simulated example as the xergm package
#' # Create 10 random networks with 10 actors
#' networks <- list()
>>>>>>> 3c922d507f7cc758a987a9ef44ae4267ac6ed583
#' for(i in 1:10){
#'     mat <- matrix(rbinom(100, 1, .25), nrow = 10, ncol = 10)
#'     diag(mat) <- 0
#'     nw <- network::network(mat)
#'     networks[[i]] <- nw
#' }
<<<<<<< HEAD
#' 
#' # Create 10 matrices as covariates
#' 
#' covariates <- list()
#' 
=======
#' # Create 10 matrices as covariates
#' covariates <- list()
>>>>>>> 3c922d507f7cc758a987a9ef44ae4267ac6ed583
#' for (i in 1:10) {
#'     mat <- matrix(rnorm(100), nrow = 10, ncol = 10)
#'     covariates[[i]] <- mat
#' }
<<<<<<< HEAD
#' 
#' # Fit a model where the propensity to form ties depends
#' # on the edge covariates, controlling for the number of
#' # in-stars
#' btfit <- btergm(networks ~ edges + istar(2) + edgecov(covariates), R = 100)
=======
#' # Fit a model where the propensity to form ties depends
#' # on the edge covariates, controlling for the number of
#' # in-stars
#' suppressWarnings(btfit <- btergm(networks ~ edges + istar(2) +
#'                    edgecov(covariates), R = 100))
>>>>>>> 3c922d507f7cc758a987a9ef44ae4267ac6ed583
#'
#' # Show terms, coefficient estimates and errors
#' tidy(btfit)
#'
#' # Show coefficients as odds ratios with a 99% CI
#' tidy(btfit, exponentiate = TRUE, conf.level = 0.99)
<<<<<<< HEAD
=======
#' }
>>>>>>> 3c922d507f7cc758a987a9ef44ae4267ac6ed583
#'
#' @export
#' @aliases btergm_tidiers
#' @seealso [tidy()], [btergm::btergm()]
tidy.btergm <- function(x, conf.level = .95, exponentiate = FALSE, ...) {
  
  if (exponentiate) {
    trans <- exp
  } else {
    trans <- identity
  }
  
  co <- btergm::confint(x, level = conf.level)

  nn <- c("estimate", "conf.low", "conf.high")
  ret <- fix_data_frame(co, nn[1:ncol(co)])
  
  ret$conf.low <- trans(ret$conf.low)
  ret$conf.high <- trans(ret$conf.high)
  ret$estimate <- trans(ret$estimate)
  as_tibble(ret)
}
