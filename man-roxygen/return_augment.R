#' @md
#' @return A [tibble::tibble()] with columns:
<%
library(tidyverse)
library(glue)
data(column_glossary, package = "broom")

cols <- unnest(column_glossary, used_by)
cols <- filter(cols, class == used_by, method == "augment")

row_to_item <- function(column, description) {
  glue("#'   \\item{{{column}}}{{{description}}}")
}

items <- with(cols, map2_chr(column, description, row_to_item))
cat(items, sep = "\n")
%>
  
