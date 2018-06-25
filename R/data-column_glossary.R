#' Allowed column names in tidied tibbles
#'
#' @format A tibble with 4 variables:
#' \describe{
#' \item{method}{One of "glance", "augment" or "tidy".}
#' \item{column}{Character name of allowed output column.}
#' \item{description}{Character description of expected column contents.}
#' \item{used_by}{A list of character vectors detailing the *classes* 
#' that use the column when tidied. For example `c("Arima", "betareg")`.}
#' }
#' @examples
#' column_glossary
"column_glossary"
