#' @templateVar class plm
#' @template title_desc_tidy
#' 
#' @param x A `plm` objected returned by [plm::plm()].
#' @template param_confint
#' @template param_unused_dots
#' 
#' @evalRd return_tidy(regression = TRUE)
#'
#' @examples
#'
#' library(plm)
#' 
#' data("Produc", package = "plm")
#' zz <- plm(log(gsp) ~ log(pcap) + log(pc) + log(emp) + unemp,
#'           data = Produc, index = c("state","year"))
#'
#' summary(zz)
#'
#' tidy(zz)
#' tidy(zz, conf.int = TRUE)
#' tidy(zz, conf.int = TRUE, conf.level = 0.9)
#'
#' augment(zz)
#' glance(zz)
#'
#' @aliases plm_tidiers
#' @export
#' @seealso [tidy()], [plm::plm()], [tidy.lm()]
#' @family plm tidiers
tidy.plm <- function(x, conf.int = FALSE, conf.level = 0.95,...) {
  
  s <- summary(x)
  
  ret <- as_tibble(s$coefficients, rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")
  
  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }
  
  ret
}

# summary(plm) creates an object with class
#  
#   c("summary.plm", "plm", "panelmodel")
# 
# and we want to avoid these because they *aren't* plm objects
# *SCREAMS INTO VOID*

#' @export
tidy.summary.plm <- tidy.default


#' @templateVar class plm
#' @template title_desc_augment
#' 
#' @inherit tidy.plm params examples
#' @template param_data
#' 
#' @evalRd return_augment()
#'
#' @export
#' @seealso [augment()], [plm::plm()]
#' @family plm tidiers
augment.plm <- function(x, data = model.frame(x), ...) {
  # Random effects and fixed effect (within model) have individual intercepts,
  # thus we cannot take the ususal procedure for augment().
  # Also, there is currently no predict() method for plm objects.
  augment_columns(x, data, ...)
}


#' @templateVar class plm
#' @template title_desc_glance
#' 
#' @inherit tidy.plm params examples
#'
#' @evalRd return_glance(
#'   "r.squared",
#'   "adj.r.squared",
#'   statistic = "F-statistic",
#'   "p.value",
#'   "deviance",
#'   "df.residual",
#'   "nobs"
#' )
#' 
#' @export
#' @seealso [glance()], [plm::plm()]
#' @family plm tidiers
glance.plm <- function(x, ...) {
  s <- summary(x)
  tibble(
    r.squared = s$r.squared['rsq'],
    adj.r.squared = s$r.squared['adjrsq'],
    statistic = s$fstatistic$statistic,
    p.value = s$fstatistic$p.value,
    deviance = stats::deviance(x),
    df.residual = stats::df.residual(x),
    nobs = stats::nobs(x)
  )
}
