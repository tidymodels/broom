#' @templateVar class plm
#' @template title_desc_tidy
#' 
#' @param x A `plm` objected returned by [plm::plm()].
#' @template param_confint
#' @template param_exponentiate
#' @template param_unused_dots
#' 
#' @template return_tidy_regression
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
#' tidy(zz, conf.int = TRUE, conf.level = .9)
#'
#' augment(zz)
#' glance(zz)
#'
#' @aliases plm_tidiers
#' @export
#' @seealso [tidy()], [plm::plm()], [tidy.lm()]
#' @family plm tidiers
tidy.plm <- function(x, conf.int = FALSE, conf.level = .95,
                     exponentiate = FALSE, ...) {
  tidy.lm(x,
    conf.int = conf.int, conf.level = conf.level,
    exponentiate = exponentiate
  )
}


#' @templateVar class plm
#' @template title_desc_augment
#' 
#' @inheritParams tidy.plm
#' @template param_data
#' 
#' @template return_augment_columns
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
#' @inheritParams tidy.plm
#'
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{r.squared}{The percent of variance explained by the model}
#'   \item{adj.r.squared}{r.squared adjusted based on the degrees of freedom}
#'   \item{statistic}{F-statistic}
#'   \item{p.value}{p-value from the F test, describing whether the full
#'   regression is significant}
#'   \item{deviance}{deviance}
#'   \item{df.residual}{residual degrees of freedom}
#'
#' @export
#' @seealso [glance()], [plm::plm()]
#' @family plm tidiers
glance.plm <- function(x, ...) {
  s <- summary(x)
  ret <- with(s, data.frame(
    r.squared = r.squared[1],
    adj.r.squared = r.squared[2],
    statistic = fstatistic$statistic,
    p.value = fstatistic$p.value
  ))
  finish_glance(ret, x)
}
