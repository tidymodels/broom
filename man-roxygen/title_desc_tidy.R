#' @title Tidy a(n) <%= class %> object
#' 
#' @description Tidy summarizes information about the components of a model.
#'   A model component might be a single term in a regression, a single
#'   hypothesis, a cluster, or a class. Exactly what tidy considers to be a
#'   model component varies cross models but is usually self-evident.
#'   If a model has several distinct types of components, you will need to
#'   specify which components to return.
#'   
#' @return TODO FIGURE OUT HOW TO DESCRIBE ROW
#' 
<%
library(tidyverse)
library(glue)
data(column_glossary, package = "broom")

cols <- unnest(column_glossary, used_by)
cols <- filter(cols, class == used_by, method == "tidy")

row_to_item <- function(column, description) {
  glue("#'   \\item{{{column}}}{{{description}}}")
}

items <- with(cols, map2_chr(column, description, row_to_item))
cat(items, sep = "\n")
%>
#' 
#' @md

