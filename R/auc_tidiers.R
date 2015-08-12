#' Tidiers for objects from the AUC package
#' 
#' Tidy "roc" objects from the "auc" package. This can be used to,
#' for example, draw ROC curves in ggplot2.
#' 
#' @param x an "roc" object
#' @param ... Additional arguments, not used
#' 
#' @return A data frame with three columns:
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
#'   head(td)
#'   
#'   library(ggplot2)
#'   ggplot(td, aes(fpr, tpr)) +
#'     geom_line()
#'     
#'   # compare the ROC curves for two prediction algorithms
#'   library(dplyr)
#'   library(tidyr)
#'   
#'   rocs <- churn %>%
#'     tidyr::gather(algorithm, value, -labels) %>%
#'     group_by(algorithm) %>%
#'     do(tidy(roc(.$value, .$labels)))
#'   
#'   ggplot(rocs, aes(fpr, tpr, color = algorithm)) +
#'     geom_line()
#' }
#' 
#' @name auc_tidiers
#' 
#' @export
tidy.roc <- function(x, ...) {
    fix_data_frame(as.data.frame(unclass(x)),
                   newnames = c("cutoff", "fpr", "tpr"),
                   newcol = "instance")
}
