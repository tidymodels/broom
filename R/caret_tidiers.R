#' Tidying methods for confusionMatrix objects
#'
#' Tidies the result of confusion matrix from the \code{caret} package.
#' Only a \code{tidy} method is provided, not an \code{augment} or
#' \code{glance} method.
#'
#' @param x An object of class \code{confusionMatrix}
#' @param show_class A boolean of whether to show the values for class specific
#' quantities from the confusion matrix (specificty, sensitivity, etc.). If set
#' to FALSE, result will only show accuracy and kappa.
#' @param ... extra arguments (not used)
#'
#' @return A data.frame with one or more of the following columns
#'   \item{term}{The name of a statistic from the confusion matrix}
#'   \item{class}{Which class the term is a measurement of}
#'   \item{estimate}{The value of the statistic}
#'   \item{lower}{Lower bound of 95% CI (only applicable to accuracy)}
#'   \item{upper}{Upper bound of 95% CI (only applicable to accuracy)}
#'   \item{p.value}{P-value for accuracy and kappa statistics}
#'
#' @examples
#'
#' # 2 class confusion matrix
#' cm2 <- caret::confusionMatrix(factor(rbinom(100,1,.5)),factor(rbinom(100,1,.5)))
#' tidy(cm2)
#' tidy(cm2, show_class = FALSE) # only shows accuracy and kappa
#'
#' # confusion matrix with more than 2 classes
#' cm <- caret::confusionMatrix(factor(rbinom(100,2,.5)),factor(rbinom(100,2,.5)))
#' tidy(cm)
#' tidy(cm, show_class = FALSE) # only shows accuracy and kappa
#'
#' @name caret_tidiers
NULL

#' @name caret_tidiers
#' @export
tidy.confusionMatrix <- function(x, show_class = TRUE, ...) {
  cm <- as.list(x$overall)
  nms_cm <- str_to_lower(names(cm)[1:2])


  if (show_class) {
    # case when only 2 classes
    if (class(x$byClass) != "matrix") {
      by_class <-
        x$byClass %>%
        as.data.frame() %>%
        rename_at(1, ~ "value") %>%
        rownames_to_column("var") %>%
        mutate(var = str_to_lower(gsub(" ", "_", var)))

      terms <- c(nms_cm, by_class$var)
      estimates <- c(cm$Accuracy, cm$Kappa, by_class$value)
      lower <- c(cm$AccuracyLower, rep(NA, length(terms) - 1))
      upper <- c(cm$AccuracyUpper, rep(NA, length(terms) - 1))
      p.value <- c(
        cm$AccuracyPValue, cm$McnemarPValue,
        rep(NA, length(terms) - 2)
      )
      df <- data_frame(
        term = terms,
        estimate = estimates,
        lower = lower,
        upper = upper,
        p.value = p.value
      )
    }
    else {
      # case when there are more than 2 classes
      by_class <-
        x$byClass %>%
        as.data.frame() %>%
        rownames_to_column("class") %>%
        gather(var, value, -class) %>%
        mutate(
          var = str_to_lower(gsub(" ", "_", var)),
          class = gsub("Class: ", "", class)
        )

      terms <- c(nms_cm, by_class$var)
      class <- c(rep(NA_character_, 2), by_class$class)
      estimates <- c(cm$Accuracy, cm$Kappa, by_class$value)
      lower <- c(cm$AccuracyLower, rep(NA, length(terms) - 1))
      upper <- c(cm$AccuracyUpper, rep(NA, length(terms) - 1))
      p.value <- c(
        cm$AccuracyPValue, cm$McnemarPValue,
        rep(NA, length(terms) - 2)
      )
      df <- data_frame(
        term = terms,
        class = class,
        estimate = estimates,
        lower = lower,
        upper = upper,
        p.value = p.value
      )
    }
  } else {
    # only show alpha and kappa when show_class = FALSE
    terms <- c(nms_cm)
    estimates <- c(cm$Accuracy, cm$Kappa)
    lower <- c(cm$AccuracyLower, NA)
    upper <- c(cm$AccuracyUpper, NA)
    p.value <- c(cm$AccuracyPValue, cm$McnemarPValue)

    df <- data_frame(
      term = terms,
      estimate = estimates,
      lower = lower,
      upper = upper,
      p.value = p.value
    )
  }

  fix_data_frame(df)
}
