#' Tidiers for objects from the AUC package
#'
#' Tidy objects returned from [AUC::roc()]. This can be used to,
#' for example, draw ROC curves in ggplot2.
#'
#' @param x Object of class `roc`.
#' @param ... Additional arguments (not used).
#'
#' @return A tibble with three columns:
#'   \item{cutoff}{The cutoff of the prediction scores used
#'   for classification}
#'   \item{tpr}{The resulting true positive rate at that cutoff}
#'   \item{fpr}{The resulting false positive rate at that cutoff}
#'
#' If the labels had names, those are added as an "instance" column.
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
#' @name auc_tidiers
#'
#' @export
tidy.roc <- function(x, ...) {
  as_tibble(unclass(x))
}
