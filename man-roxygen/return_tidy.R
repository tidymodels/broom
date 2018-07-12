#' @md
#' @return A [tibble::tibble()] with columns:
<%
library(tidyverse)
library(glue)
data(column_glossary, package = "broom")

cols <- filter(column_glossary, class == used_by, method == "tidy")

row_to_item <- function(column, description) {
  glue("#'   \\item{{{column}}}{{{description}}}")
}

items <- with(cols, map2_chr(column, description, row_to_item))
cat(items, sep = "\n")
%>
