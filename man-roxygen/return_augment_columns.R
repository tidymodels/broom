#' @return A [tibble::tibble()] containing the data passed to `augment`,
#'   and **additional** columns:
#'   
#'   \item{.fitted}{The predicted response for that observation.}
#'   \item{.resid}{The residual for a particular point. Present only when
#'     data has been passed to `augment` via the `data` argument.}
#'     
#' @md
