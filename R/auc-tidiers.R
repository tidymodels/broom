#' @templateVar class roc
#' @template title_desc_tidy
#'
#' @param x An `roc` object returned from a call to [AUC::roc()].
#' @template param_unused_dots
#'
#' @return A [tibble::tibble()] with three columns:
#'   \item{cutoff}{The cutoff used for classification. Observations with
#'     predicted probabilities above this value were assigned class 1, and
#'     observations with predicted probabilities below this value were
#'     assigned class 0.}
#'   \item{tpr}{The true positive rate at the given cutoff.}
#'   \item{fpr}{The false positive rate at the given cutoff.}
#'
#' @examples
#'
#' if (require("AUC", quietly = TRUE)) {
#'   data(churn)
#'   r <- roc(churn$predictions,churn$labels)
#'
#'   td <- tidy(r)
#'   td
#'
#'   library(ggplot2)
#'   
#'   ggplot(td, aes(fpr, tpr)) +
#'     geom_line()
#'
#'   # compare the ROC curves for two prediction algorithms
#'   
#'   library(dplyr)
#'   library(tidyr)
#'
#'   rocs <- churn %>%
#'     gather(algorithm, value, -labels) %>%
#'     nest(-algorithm) %>% 
#'     mutate(tidy_roc = purrr::map(data, ~tidy(roc(.x$value, .x$labels)))) %>% 
#'     unnest(tidy_roc)
#'
#'   ggplot(rocs, aes(fpr, tpr, color = algorithm)) +
#'     geom_line()
#' }
#'
#' @export
#' @aliases auc_tidiers roc_tidiers
#' @seealso [tidy()], [AUC::roc()]
tidy.roc <- function(x, ...) {
  as_tibble(unclass(x))
}
