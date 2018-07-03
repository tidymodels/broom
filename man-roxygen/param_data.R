#' @param data A [data.frame()] or [tibble::tibble()] containing the original
#'   data that was used to produce the object `x`. Defaults to
#'   `stats::model.frame(x)` so that `augment(my_fit)` returns the augmented
#'   original data. **Do not** pass new data to the `data` argument. 
#'   Augment will report information such as influence and cooks distance for
#'   data passed to the `data` argument. These measures are only defined for
#'   the original training data.
#' @md
