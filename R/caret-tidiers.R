#' @templateVar class confusionMatrix
#' @template title_desc_tidy
#'
#' @param x An object of class `confusionMatrix` created by a call to
#' [caret::confusionMatrix()].
#' @param by_class Logical indicating whether or not to show performance 
#' measures broken down by class. Defaults to `TRUE`. When `by_class = FALSE`
#' only returns a tibble with accuracy, kappa, and McNamara statistics.
#' @template param_unused_dots
#' 
#' @evalRd return_tidy(
#'   "term", 
#'   "estimate", 
#'   "conf.low", 
#'   "conf.high", 
#'   "class",
#'   p.value = "P-value for accuracy and kappa statistics."
#' )
#'
#' @examples
#'
#' library(caret)
#' 
#' set.seed(27)
#' 
#' two_class_sample1 <- as.factor(sample(letters[1:2], 100, TRUE))
#' two_class_sample2 <- as.factor(sample(letters[1:2], 100, TRUE))
#' 
#' two_class_cm <- caret::confusionMatrix(
#'   two_class_sample1,
#'   two_class_sample2
#' )
#' 
#' tidy(two_class_cm)
#' tidy(two_class_cm, by_class = FALSE)
#' 
#' # multiclass example
#' 
#' six_class_sample1 <- as.factor(sample(letters[1:6], 100, TRUE))
#' six_class_sample2 <- as.factor(sample(letters[1:6], 100, TRUE))
#' 
#' six_class_cm <- caret::confusionMatrix(
#'   six_class_sample1,
#'   six_class_sample2
#' )
#' 
#' tidy(six_class_cm)
#' tidy(six_class_cm, by_class = FALSE)
#' 
#' @aliases caret_tidiers confusionMatrix_tidiers
#' @export
#' @seealso [tidy()], [caret::confusionMatrix()]
tidy.confusionMatrix <- function(x, by_class = TRUE, ...) {
  cm <- as.list(x$overall)
  nms_cm <- stringr::str_to_lower(c(names(cm)[1:2], "McNamara"))


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
      class <- c(rep(NA_character_, 3), rep(x$positive, length(terms) - 3))
      estimates <- c(cm$Accuracy, cm$Kappa, NA, classes$value)
      conf.low <- c(cm$AccuracyLower, rep(NA, length(terms) - 1))
      conf.high <- c(cm$AccuracyUpper, rep(NA, length(terms) - 1))
      p.value <- c(
        cm$AccuracyPValue, NA, cm$McnemarPValue,
        rep(NA, length(terms) - 3)
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
      class <- c(rep(NA_character_, 3), classes$class)
      estimates <- c(cm$Accuracy, cm$Kappa, NA, classes$value)
      conf.low <- c(cm$AccuracyLower, rep(NA, length(terms) - 1))
      conf.high <- c(cm$AccuracyUpper, rep(NA, length(terms) - 1))
      p.value <- c(
        cm$AccuracyPValue, NA, cm$McnemarPValue,
        rep(NA, length(terms) - 3)
      )
    }
    df <- tibble(
      term = terms,
      class = class,
      estimate = estimates,
      conf.low = conf.low,
      conf.high = conf.high,
      p.value = p.value
    )
  } else {
    # only show alpha, kappa, and mcnamara, when show_class = FALSE
    terms <- c(nms_cm)
    estimates <- c(cm$Accuracy, cm$Kappa, NA)
    conf.low <- c(cm$AccuracyLower, NA, NA)
    conf.high <- c(cm$AccuracyUpper, NA, NA)
    p.value <- c(cm$AccuracyPValue, NA, cm$McnemarPValue)

    df <- tibble(
      term = terms,
      estimate = estimates,
      conf.low = conf.low,
      conf.high = conf.high,
      p.value = p.value
    )
  }

  fix_data_frame(df)
}
