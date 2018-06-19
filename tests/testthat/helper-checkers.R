# helper functions for testing

# https://stackoverflow.com/questions/18813526/check-whether-all-elements-of-a-list-are-in-equal-in-r
all_equal_list <- function(x) sum(duplicated.default(x)) == length(x) - 1L

### GLOSSARY

glance_argument_glossary <- c(
  "x",
  "..."
)
augment_argument_glossary <- c(
  "x",
  "data",
  "newdata",
  "type.predict",
  "type.residuals",
  "weights",
  "..."
)

glance_column_glossary <- c(
  "AIC"
)

# must all begin with .
augment_column_glossary <- c(
  ".fitted",
  ".resid"
)

### GLANCE HELPERS

check_glance_arguments <- function(g) {
  args <- names(formals(g))
  
  expect_true(
    all(args %in% glance_argument_glossary),
    info = "Glance arguments must be listed in the argument glossary."
  )
}

check_glance_output <- function(go) {
  
  expect_s3_class(go, "tbl_df",
    info = "Glance must return a tibble."
  )
  
  expect_equal(nrow(go), 1,
    info = "Glance must return a tibble with exactly 1 row."
  )
  
  expect_false(
    any(is.nan(go)),
    info = "Glance must return a tibble with no NaN values."
  )
  
  # add check for infinite values in glance output?
  
  expect_true(
    all(colnames(go) %in% glance_column_glossary),
    info = "Column names for glance output must be in the column glossary."
  )
}

check_multiple_glance_outputs <- function(...) {
  expect_true(
    all_equal_list(map(list(...), colnames)),
    info = "Glance column names and order must agree across all ouputs."
  ) 
}


### AUGMENT

check_augment_arguments <- function(g) {
  args <- names(formals(g))
  
  expect_true(
    all(args %in% augment_argument_glossary),
    info = "Augment arguments must be listed in the argument glossary."
  )
}

check_augment_output <- function(ao, original_data) {
  expect_s3_class(ao, "tbl_df",
    info = "Augment must return a tibble."
  )
  
  expect_equal(nrow(ao), nrow(original_data),
    info = "Augmented data must have same number of rows as original data."
  )
  
  orig_cols <- colnames(original_data)
  aug_cols <- colnames(ao)
  new_cols <- setdiff(auc_cols, orig_cols)
  
  expect_true(
    orig_cols %in% aug_cols,
    info = "Original columns must be presented in augmented data."
  )
  
  expect_true(
    all(colnames(go) %in% glance_column_glossary),
    info = "Augmented column names must be in the column glossary."
  )
  
  # check if data.frame but not tibble?
  if (.row_names_info(original_data) > 0) {
    expect_true(
      ".rownames" %in% aug_cols,
      info = paste(
        "A `.rownames` column must be present in augmented data when input",
        "data is a data.frame with rownames"
      )
    )
  }
}



# TODO: sort out how rownames should work when coercing
augment_data_helper <- function(data, add_missing = FALSE) {
  
  if (add_missing) {
    diag(data) <- NA
    data[nrow(data + 1), ] <- rep(NA, ncol(data))
  }
  
  tibble_data <- as_tibble(data)
  df_data <- tibble::as_data_frame(data)
  df_rows <- df_data
  rownames(df_rows) <- paste0("obs", 1:nrow(data))
  
  list(tibble = tibble_data,
       df = df_data,
       df_rows = df_rows)
}

# example usage:

check_augment_function <- function(a, model, data = NULL, newdata = NULL) {
  
  # model frame test
  
  args <- names(formals(a))
  
  data_passed <- !is.null(data)
  newdata_passed <- !is.null(newdata)
  
  data_arg <- "data" %in% args
  newdata_args <- "newdata" %in% args
  
  if (data_arg && !data_passed) {
    stop("Must pass data to augment checker as augment method accepts data",
         "argument.")
  }
  
  if (newdata_arg && !newdata_passed) {
    stop("Must pass newdata to augment checker as augment method accepts", 
         "newdata argument.")
  }
  
  # if data/newdata arguments to augment, must passed data/newdata
  
  if (data_arg) {
    
    ## tests for data in various data frame formats
    
    data_list <- augment_data_helper(data, add_missing = FALSE)
    
    tibble_output <- a(model, data = data_list$tibble)
    check_augment_output(tibble_output, original_data = data_list$tibble)
    
    df_output <- a(model, data = data_list$df)
    check_augment_output(df_output, original_data = data_list$df)
    
    df_rows_output <- a(model, data = data_list$df_rows)
    check_augment_output(df_rows_output, original_data = data_list$df_rows)
    
    expect_equal(
      tibble_output, df_output, df_rows_output,
      info = "Augmented data must be the same for tibble and data frame input"
    )
    
    ## tests when data has missing values
    
    data_list <- augment_data_helper(data, add_missing = TRUE)
    
    tibble_output <- a(model, data = data_list$tibble)
    check_augment_output(tibble_output, original_data = data_list$tibble)
    
    df_output <- a(model, data = data_list$df)
    check_augment_output(df_output, original_data = data_list$df)
    
    df_rows_output <- a(model, data = data_list$df_rows)
    check_augment_output(df_rows_output, original_data = data_list$df_rows)
    
    expect_equal(
      tibble_output, df_output, df_rows_output,
      info = "Augmented data must be the same for tibble and data frame input"
    )
    
    ## argument checks happen
    
    expect_error{
      a(model, data = tibble()),
      info = "Augment must throw error when `data` is passed an empty tibble."
    }
    
    expect_error{
      a(model, data = data.frame()),
      info = c(
        "Augment must throw error when `data` is passed an empty dataframe."
      )
    }
    
    expect_error(
      a(model, data = 1L),
      info = "Augment must throw errow when `data` is not a dataframe."
    )
  }
  
  if (newdata_arg) {
    
    ## tests for data in various data frame formats
    
    data_list <- augment_data_helper(data, add_missing = FALSE)
    
    tibble_output <- a(model, newdata = data_list$tibble)
    check_augment_output(tibble_output, original_data = data_list$tibble)
    
    df_output <- a(model, newdata = data_list$df)
    check_augment_output(df_output, original_data = data_list$df)
    
    df_rows_output <- a(model, newdata = data_list$df_rows)
    check_augment_output(df_rows_output, original_data = data_list$df_rows)
    
    expect_equal(
      tibble_output, df_output, df_rows_output,
      info = "Augmented data must be the same for tibble and data frame input"
    )
    
    ## tests when data has missing values
    
    data_list <- augment_data_helper(data, add_missing = TRUE)
    
    tibble_output <- a(model, newdata = data_list$tibble)
    check_augment_output(tibble_output, original_data = data_list$tibble)
    
    df_output <- a(model, data = newdata_list$df)
    check_augment_output(df_output, original_data = data_list$df)
    
    df_rows_output <- a(model, data = newdata_list$df_rows)
    check_augment_output(df_rows_output, original_data = data_list$df_rows)
    
    expect_equal(
      tibble_output, df_output, df_rows_output,
      info = "Augmented data must be the same for tibble and data frame input"
    )
    
    ## argument checks happen
    
    expect_error{
      a(model, data = tibble()),
      info = "Augment must throw error when `data` is passed an empty tibble."
    }
    
    expect_error{
      a(model, data = data.frame()),
      info = c(
        "Augment must throw error when `data` is passed an empty dataframe."
      )
    }
    
    expect_error(
      a(model, data = 1L),
      info = "Augment must throw errow when `data` is not a dataframe."
    )
  }
  
  if (data_arg  && newdata_arg) {
    expect_error(
      augment(model, data = data, newdata = newdata),
      info = "Augment must error when both data and newdata are specified."
    )
  }
}

# TODO: some sort of test for the model.frame(x) data situation


#' test the basics of tidy/augment/glance output: is a data frame, no row names
check_tidiness <- function(o) {
  expect_is(o, "data.frame")
  expect_equal(rownames(o), as.character(seq_len(nrow(o))))
}


#' check the output of a tidy function
check_tidy <- function(o, exp.row = NULL, exp.col = NULL, exp.names = NULL) {
  check_tidiness(o)

  if (!is.null(exp.row)) {
    expect_equal(nrow(o), exp.row)
  }
  if (!is.null(exp.col)) {
    expect_equal(ncol(o), exp.col)
  }
  if (!is.null(exp.names)) {
    expect_true(all(exp.names %in% colnames(o)))
  }
}


#' check the output of an augment function
check_augment <- function(au, original = NULL, exp.names = NULL,
                          same = NULL) {
  check_tidiness(au)

  if (!is.null(original)) {
    # check that all rows in original appear in output
    expect_equal(nrow(au), nrow(original))
    # check that columns are the same
    for (column in same) {
      expect_equal(au[[column]], original[[column]])
    }
  }

  if (!is.null(exp.names)) {
    expect_true(all(exp.names %in% colnames(au)))
  }
}


#' add NAs to a vector randomly
#'
#' @param v vector to add NAs to
#' @param number number of NAs to add
#'
#' @return vector with NAs added randomly
add_NAs <- function(v, number) {
  if (number >= length(v)) {
    stop("Would replace all or more values with NA")
  }
  v[sample(length(v), number)] <- NA
  v
}

#' check an augmentation function works as expected when given NAs
#'
#' @param func A modeling function that takes a dataset and additional
#' arguments, including na.action
#' @param .data dataset to test function on; must have at least 3 rows
#' and no NA values
#' @param column a column included in the model to be replaced with NULLs
#' @param column2 another column in the model; optional
#' @param ... extra arguments, not used
#'
#' @export
check_augment_NAs <- function(func, .data, column, column2 = NULL, ...) {
  # test original version, with and without giving data to augment
  obj <- class(func(.data))[1]

  test_that(paste("augment works with", obj), {
    m <- func(.data)
    au <- augment(m)
    check_augment(au, .data)
    au_d <- augment(m, .data)
    check_augment(au_d, .data, same = colnames(.data))
  })

  # add NAs
  if (nrow(.data) < 3) {
    stop(".data must have at least 3 rows in NA testing")
  }

  check_omit <- function(au, dat) {
    NAs <- is.na(dat[[column]])

    check_augment(au, dat[!NAs, ], same = c(column, column2))
    if (!is.null(au$.rownames)) {
      expect_equal(rownames(dat)[!NAs], au$.rownames)
    }
  }

  check_exclude <- function(au, dat) {
    check_augment(au, dat, colnames(dat))
    # check .fitted and .resid columns have NAs in the right place
    for (col in c(".fitted", ".resid")) {
      if (!is.null(au[[col]])) {
        expect_equal(is.na(au[[col]]), is.na(dat[[column]]))
      }
    }
  }

  # test augment with na.omit (factory-fresh setting in R)
  # and test with or without rownames
  num_NAs <- min(5, nrow(.data) - 2)
  .dataNA <- .data
  .dataNA[[column]] <- add_NAs(.dataNA[[column]], num_NAs)

  test_that(paste("augment works with", obj, "with na.omit"), {
    .dataNA_noname <- unrowname(.dataNA)
    for (d in list(.dataNA, .dataNA_noname)) {
      m <- func(d, na.action = "na.omit")
      au <- augment(m)
      check_omit(au, d)
      au_d <- augment(m, d)
      check_omit(au_d, d)
    }
  })

  for (rnames in c(TRUE, FALSE)) {
    msg <- paste("augment works with", obj, "with na.exclude")
    if (!rnames) {
      msg <- paste(msg, "without rownames")
    }
    test_that(msg, {
      d <- if (rnames) {
        .dataNA
      } else {
        unrowname(.dataNA)
      }
      m <- func(d, na.action = "na.exclude")
      # without the data argument, it works like na.exclude
      expect_warning(au <- augment(m), "na.exclude")
      check_omit(au, d)
      # with the data argument, it keeps the NAs
      au_d <- augment(m, d)
      check_exclude(au_d, d)
    })
  }
}
