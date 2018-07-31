
# TODO:
#  - catch errors and throw a warning visible to the user
#  - check that all arguments result in some documentation being produced
#    - i.e. "cooooooksd" should error informatively
#  - warn when custom arg is taking precedence over something well-defined

# starter boiler plate like: returns a one-row data.frame with the columns
# .pre = before items, .post = after items

return_evalrd <- function(..., .method) {
  
  glos_env <- new.env()
  data("column_glossary", package = "modeltests", envir = glos_env)
  cols <- list(...)
  
  # figure out which arguments are custom documentation and what should
  # get pulled straight from the model glossary
  
  custom_cols <- tibble()
  use_custom_doc <- !is.null(names(cols))
  pull_from_modeltests <- as.character(cols)
  
  if (use_custom_doc) {
    idx <- purrr::map_lgl(names(cols), ~.x != "")
    custom_doc <- cols[idx]
    pull_from_modeltests <- pull_from_modeltests[!idx]
    pull_from_modeltests <- setdiff(pull_from_modeltests, names(custom_doc))
    
    custom_cols <- tibble(
      column = names(custom_doc),
      description = as.character(custom_doc)
    )
  }
  
  glos <- glos_env$column_glossary %>% 
    filter(purrr::map_lgl(column, ~.x %in% pull_from_modeltests)) %>% 
    filter(method == !!.method) %>% 
    bind_rows(custom_cols)
  
  row_to_item <- function(column, description) {
    glue("  \\item{{{column}}}{{{description}}}")
  }
  
  items <- with(glos, purrr::map2_chr(column, description, row_to_item))
  items <- paste(items, collapse = "\n")
  
  paste("\\value{", items, "}", sep = "\n", collapse = "\n")
}

return_glance <- function(...) {
  return_evalrd(..., .method = "glance")
}

return_tidy <- function(..., regression = FALSE) {
  
  args <- list(..., .method = "tidy")
  
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

return_augment <- function(..., .fitted = TRUE, .resid = TRUE) {
  
  args <- list(..., .method = "augment")
  
  if (.fitted) 
    args <- c(args, ".fitted")
  
  if (.resid) 
    args <- c(args, ".resid")
  
  do.call("return_evalrd", args)
}
