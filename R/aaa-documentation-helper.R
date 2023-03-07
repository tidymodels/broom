# TODO:
#  - catch errors and throw a warning visible to the user
#  - warn when custom arg is taking precedence over something well-defined

# starter boiler plate like: returns a one-row data.frame with the columns
# .pre = before items, .post = after items

return_evalrd <- function(..., .method, .pre = NULL, .post = NULL) {
  glos_env <- new.env()
  data("column_glossary", package = "modeltests", envir = glos_env)
  cols <- list(...)

  # figure out which arguments are custom documentation and what should
  # get pulled straight from the model glossary

  custom_cols <- tibble()
  use_custom_doc <- !is.null(names(cols))
  pull_from_modeltests <- as.character(cols)

  if (use_custom_doc) {
    idx <- purrr::map_lgl(names(cols), ~ .x != "")
    custom_doc <- cols[idx]
    pull_from_modeltests <- pull_from_modeltests[!idx]
    pull_from_modeltests <- setdiff(pull_from_modeltests, names(custom_doc))

    not_found <- setdiff(pull_from_modeltests, glos_env$column_glossary$column)

    if (length(not_found) > 0) {
      not_found <- paste(not_found, collapse = ", ")
      stop(
        glue(
          "Tried to use modeltests documentation for: {not_found} column(s) ",
          "but could not find any."
        )
      )
    }


    overwrite <- intersect(
      names(custom_doc),
      glos_env$column_glossary$column
    )

    if (length(overwrite) > 0) {
      overwritten <- paste(overwrite, collapse = ", ")
      warning(
        glue(
          "Using provided documentation for column: {overwritten} rather than ",
          "modeltest documentation",
          call. = FALSE
        )
      )
    }

    custom_cols <- tibble(
      column = names(custom_doc),
      description = as.character(custom_doc)
    )
  }

  glos <- glos_env$column_glossary %>%
    filter(purrr::map_lgl(column, ~ .x %in% pull_from_modeltests)) %>%
    filter(method == !!.method) %>%
    bind_rows(custom_cols)

  row_to_item <- function(column, description) {
    glue("  \\item{{{column}}}{{{description}}}")
  }

  items <- with(glos, purrr::map2_chr(column, description, row_to_item))
  items <- paste(items, collapse = "\n")

  result <- paste("\\value{", .pre, items, .post, "}",
    sep = "\n", collapse = "\n"
  )

  # check that all arguments resulted in some form of documentation
  standard_cols <- if (is.null(names(cols))) {
    unlist(cols)
  } else {
    unlist(cols[names(cols) == ""])
  }
  cols_exps <- paste0("\\item\\{", standard_cols)
  written <- purrr::map_lgl(cols_exps, stringr::str_detect, string = result)
  missing_cols <- standard_cols[!written]
  if (length(missing_cols) != 0) {
    cols_message <- glue(
      'The return_{.method} input "{missing_cols}" did not ',
      "result in any documentation being written. \n"
    )
    message(cols_message)
  }

  result
}

return_glance <- function(..., .pre = NULL, .post = NULL) {
  if (is.null(.pre)) {
    .pre <- paste(
      "A \\code{\\link[tibble:tibble]{tibble::tibble()}} with exactly",
      "one row and columns:"
    )
  }

  return_evalrd(..., .pre = .pre, .post = .post, .method = "glance")
}

return_tidy <- function(..., .pre = NULL, .post = NULL, regression = FALSE) {
  if (is.null(.pre)) {
    .pre <- "A \\code{\\link[tibble:tibble]{tibble::tibble()}} with columns:"
  }

  args <- list(
    ...,
    .pre = .pre,
    .post = .post,
    .method = "tidy"
  )

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

return_augment <- function(...,
                           .pre = NULL,
                           .post = NULL,
                           .fitted = TRUE,
                           .resid = TRUE) {
  if (is.null(.pre)) {
    .pre <- "A \\code{\\link[tibble:tibble]{tibble::tibble()}} with columns:"
  }

  args <- list(
    ...,
    .pre = .pre,
    .post = .post,
    .method = "augment"
  )

  if (.fitted) {
    args <- c(args, ".fitted")
  }

  if (.resid) {
    args <- c(args, ".resid")
  }

  do.call("return_evalrd", args)
}
