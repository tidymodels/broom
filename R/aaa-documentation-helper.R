
return_evalrd <- function(..., tidier) {
  
  data("column_glossary", package = "modeltests")
  cols <- c(...)
  
  glos <- column_glossary %>% 
    filter(purrr::map_lgl(column, ~.x %in% cols)) %>% 
    filter(method == !!tidier)
  
  row_to_item <- function(column, description) {
    glue::glue("  \\item{{{column}}}{{{description}}}")
  }
  
  items <- with(glos, purrr::map2_chr(column, description, row_to_item))
  items <- paste(items, collapse = "\n")
  
  paste("\\value{", items, "}", sep = "\n", collapse = "\n")
}


f <- function(...) {
  
  # three types of input:
  #  1. strings: pull documentation from modeltests glossary
  #  2. pairlist = TRUE entries: pull multiple predefined columns for modeltests
  #     glossaries at once
  #  3. pairlist = "description": override or add custom documentation info.
  #  4. transform markdown with markdownify
  list(...)
}

f("AIC", "BIC", regression = TRUE, BIC = "Overwrite the existing BIC DOC")



return_glance <- function(...) {
  return_evalrd(..., tidier = "glance")
}

return_tidy <- function(..., regression = FALSE) {
  
  args <- list(..., tidier = "tidy")
  
  if (regression) {
    args <- c(
      args,
      "term",
      "estimate",
      "std.error",
      "statistic",
      "p.value",
      "conf.low",
      "conf.high"
    )
  }
  
  do.call("return_evalrd", args)
}

return_augment <- function(...) {
  return_evalrd(..., tidier = "augment")
}
