#' @md
#' @return A [tibble::tibble()] with exactly one row and columns:
<%
library(tidyverse)
library(glue)
data(column_glossary, package = "broom")

# hack: we only need to specify columns to omit on occasion. this means
# the templateVar needs to be defined when nothing is passed. the only
# way i've figured out how to do this so far is to use a templateVar that
# is also a function name. then the templateVar is a character when passed
# by the documenter, otherwise its a function. if you have a better way,
# please let me know.

if (is.function(missing)) {
  cols <- mutate(column_glossary, skip_row = FALSE)
} else {
  to_skip <- strsplit(missing, " ")[[1]]
  cols <- mutate(
    column_glossary,
    skip_row = map_lgl(column, ~match(.x, to_skip, nomatch = 0) > 0)
  )
}

cols <- filter(cols, !skip_row, used_by == class, method == "glance")

row_to_item <- function(column, description) {
  glue("#'   \\item{{{column}}}{{{description}}}")
}

items <- with(cols, map2_chr(column, description, row_to_item))
cat(items, sep = "\n")
%>
  
  
