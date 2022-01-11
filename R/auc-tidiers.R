#' @templateVar class roc
#' @template title_desc_tidy
#'
#' @param x An `roc` object returned from a call to [AUC::roc()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy("cutoff", "tpr", "fpr")
#'
#' @examples
#' 
#' # feel free to ignore the following line—it allows {broom} to supply 
#' # examples without requiring the model-supplying package to be installed.
#' if (requireNamespace("AUC", quietly = TRUE)) {
#'
#' # load libraries for models and data
#' library(AUC)
#' 
#' # load data
#' data(churn)
#' 
#' # fit model
#' r <- roc(churn$predictions, churn$labels)
#'
#' # summarize with tidiers + visualization
#' td <- tidy(r)
#' td
#'
#' library(ggplot2)
#'
#' ggplot(td, aes(fpr, tpr)) +
#'   geom_line()
#'
#' # compare the ROC curves for two prediction algorithms
#' library(dplyr)
#' library(tidyr)
#'
#' rocs <- churn %>%
#'   pivot_longer(contains("predictions"),
#'     names_to = "algorithm",
#'     values_to = "value"
#'   ) %>%
#'   nest(data = -algorithm) %>%
#'   mutate(tidy_roc = purrr::map(data, ~ tidy(roc(.x$value, .x$labels)))) %>%
#'   unnest(tidy_roc)
#'
#' ggplot(rocs, aes(fpr, tpr, color = algorithm)) +
#'   geom_line()
#'   
#' }
#' 
#' @export
#' @aliases auc_tidiers roc_tidiers
#' @seealso [tidy()], [AUC::roc()]
tidy.roc <- function(x, ...) {
  rename2(as_tibble(unclass(x)), cutoff = cutoffs)
}
