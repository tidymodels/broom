#' Tidying methods for confusionMatrix objects
#'
#' Tidies the result of confusion matrix from the caret package.
#' Only a `tidy` method is provided, not an `augment` or
#' `glance` method.
#'
#' @param x An object of class `confusionMatrix`
#' @param by_class A logical of whether to show the values for class specific
#' quantities from the confusion matrix (specificty, sensitivity, etc.). If set
#' to FALSE, result will only show accuracy and kappa.
#' @param ... extra arguments (not used)
#'
#' @return A tibble with one or more of the following columns:
#'   \item{term}{The name of a statistic from the confusion matrix}
#'   \item{class}{Which class the term is a measurement of}
#'   \item{estimate}{The value of the statistic}
#'   \item{conf.low}{Low end of 95 percent CI only applicable to accuracy}
#'   \item{conf.high}{High end of 95 percent CI only applicable to accuracy}
#'   \item{p.value}{P-value for accuracy and kappa statistics}
#'
#' @examples
#'
#' \dontrun{
#' # 2 class confusion matrix
#' cm2 <- caret::confusionMatrix(factor(rbinom(100,1,.5)),factor(rbinom(100,1,.5)))
#' tidy(cm2)
#' tidy(cm2, by_class = FALSE) # only shows accuracy and kappa
#'
#' # confusion matrix with more than 2 classes
#' cm <- caret::confusionMatrix(factor(rbinom(100,2,.5)),factor(rbinom(100,2,.5)))
#' tidy(cm)
#' tidy(cm, by_class = FALSE) # only shows accuracy and kappa
#' }
#'
#' @name caret_tidiers
NULL

#' @name caret_tidiers
#' @export
tidy.confusionMatrix <- function(x, by_class = TRUE, ...) {
  cm <- as.list(x$overall)
  nms_cm <- stringr::str_to_lower(names(cm)[1:2])


  if (by_class) {
    # case when only 2 classes
    if (class(x$byClass) != "matrix") {
      classes <-
        x$byClass %>%
        as.data.frame() %>%
        rename_at(1, ~ "value") %>%
        tibble::rownames_to_column("var") %>%
        mutate(var = stringr::str_to_lower(gsub(" ", "_", var)))

      terms <- c(nms_cm, classes$var)
      class <- c(rep(NA_character_, 2), rep(x$positive, length(terms) - 2))
      estimates <- c(cm$Accuracy, cm$Kappa, classes$value)
      conf.low <- c(cm$AccuracyLower, rep(NA, length(terms) - 1))
      conf.high <- c(cm$AccuracyUpper, rep(NA, length(terms) - 1))
      p.value <- c(
        cm$AccuracyPValue, cm$McnemarPValue,
        rep(NA, length(terms) - 2)
      )
    }
    else {
      # case when there are more than 2 classes
      classes <-
        x$byClass %>%
        as.data.frame() %>%
        tibble::rownames_to_column("class") %>%
        gather(var, value, -class) %>%
        mutate(
          var = stringr::str_to_lower(gsub(" ", "_", var)),
          class = gsub("Class: ", "", class)
        )

      terms <- c(nms_cm, classes$var)
      class <- c(rep(NA_character_, 2), classes$class)
      estimates <- c(cm$Accuracy, cm$Kappa, classes$value)
      conf.low <- c(cm$AccuracyLower, rep(NA, length(terms) - 1))
      conf.high <- c(cm$AccuracyUpper, rep(NA, length(terms) - 1))
      p.value <- c(
        cm$AccuracyPValue, cm$McnemarPValue,
        rep(NA, length(terms) - 2)
      )
    }
    df <- data_frame(
      term = terms,
      class = class,
      estimate = estimates,
      conf.low = conf.low,
      conf.high = conf.high,
      p.value = p.value
    )
  } else {
    # only show alpha and kappa when show_class = FALSE
    terms <- c(nms_cm)
    estimates <- c(cm$Accuracy, cm$Kappa)
    conf.low <- c(cm$AccuracyLower, NA)
    conf.high <- c(cm$AccuracyUpper, NA)
    p.value <- c(cm$AccuracyPValue, cm$McnemarPValue)

    df <- data_frame(
      term = terms,
      estimate = estimates,
      conf.low = conf.low,
      conf.high = conf.high,
      p.value = p.value
    )
  }

  fix_data_frame(df)
}
