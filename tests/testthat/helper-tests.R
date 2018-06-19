# helper functions for testing

# TODO: document these functions with roxygen, and also in adding new tidiers

# https://stackoverflow.com/questions/18813526/check-whether-all-elements-of-a-list-are-in-equal-in-r
all_equal_list <- function(x) sum(duplicated.default(x)) == length(x) - 1L

### GLOSSARY

## argument names: allowable argument names in tidier signatures

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

tidy_argument_glossary <- c(
  "x",
  "conf.int",
  "conf.level",
  "..."
)

## output column names: allowable columns names in tidier output

glance_column_glossary <- tribble(
  ~column, ~description, ~used_by,
  "sigma", "", c("Arima"),
  "logLik", "", c("Arima", "betareg"),
  "AIC", "", c("Arima", "betareg"),
  "BIC", "", c("Arima", "betareg"),
  "pseudo.r.squared", "", c("betareg"),
  "df.residual", "", c("betareg"),
  "df.null", "", c("betareg")
)

# only new columns added by augment are checked against this list
# all names in this list must begin with a dot

augment_columns <- tribble(
  ~column, ~description, ~used_by,
  ".fitted", "", c("betareg"),
  ".resid", "", c("betareg"),
  ".cooksd", "", c("betareg"),
  ".rownames", "", ""
)

tidy_columns <- tribble(
  ~column, ~description, ~used_by,
  "term", "", c("Arima", "betareg"),
  "estimate", "", c("Arima", "betareg"),
  "std.error", "", c("Arima", "betareg"),
  "p.value", "", c("betareg"),
  "conf.low", "", c("Arima", "betareg"),
  "conf.high", "", c("Arima", "betareg"),
  "cutoffs", "", c("roc"),
  "fpr", "", c("roc"),
  "tpr", "", c("roc"),
  "component", "", c("betareg"),
  "statistic", "", c("betareg")
)

glance_columns <- pull(glance_column_glossary, column)
augment_columns <- pull(augment_columns, column)
tidy_columns <- pull(tidy_columns, column)

### GLANCE HELPERS

check_glance_arguments <- function(g) {
  args <- names(formals(g))
  
  expect_true(
    all(args %in% glance_argument_glossary),
    info = "Glance arguments must be listed in the argument glossary."
  )
}

check_glance_output <- function(go) {
  
  expect_s3_class(go, "tbl_df")
  
  expect_equal(nrow(go), 1,
               info = "Glance must return a tibble with exactly 1 row."
  )
  
  # infinite / NaN checks?
  
  expect_true(
    all(colnames(go) %in% glance_columns),
    info = "Column names for glance output must be in the column glossary."
  )
}

check_glance_multiple_outputs <- function(...) {
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
  expect_s3_class(ao, "tbl_df")
  
  expect_equal(nrow(ao), nrow(original_data),
    info = "Augmented data must have same number of rows as original data."
  )
  
  orig_cols <- colnames(original_data)
  aug_cols <- colnames(ao)
  new_cols <- setdiff(aug_cols, orig_cols)
  
  expect_true(
    all(orig_cols %in% aug_cols),
    info = "Original columns must be presented in augmented data."
  )
  
  expect_true(
    all(new_cols %in% augment_columns),
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
  df_data <- as.data.frame(data)
  df_rows <- df_data
  rownames(df_rows) <- paste0("obs", 1:nrow(data))
  
  list(tibble = tibble_data,
       df = df_data,
       df_rows = df_rows)
}

# example usage:

check_augment_function <- function(a, model, data = NULL, newdata = NULL) {
  
  # TODO: check default behavior when there is a data argument
  # but nothing gets passed to it
  
  args <- names(formals(a))
  
  data_passed <- !is.null(data)
  newdata_passed <- !is.null(newdata)
  
  data_arg <- "data" %in% args
  newdata_arg <- "newdata" %in% args
  
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
      tibble_output, df_output,
      info = "Augmented data must be the same for tibble and data frame input."
    )
    
    expect_equal(
      df_output, df_rows_output,
      info = paste(
        "Augmented data must be the same for dataframes with and without",
        "rownames."
      )
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
      tibble_output, df_output,
      info = "Augmented data must be the same for tibble and data frame input."
    )
    
    expect_equal(
      df_output, df_rows_output,
      info = paste(
        "Augmented data must be the same for dataframes with and without",
        "rownames."
      )
    )
    
    ## argument checks happen
    
    expect_error(
      a(model, data = tibble()),
      info = "Augment must throw error when `data` is passed an empty tibble."
    )
    
    expect_error(
      a(model, data = data.frame()),
      info = c(
        "Augment must throw error when `data` is passed an empty dataframe."
      )
    )
    
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
      tibble_output, df_output,
      info = "Augmented data must be the same for tibble and data frame input."
    )
    
    expect_equal(
      df_output, df_rows_output,
      info = paste(
        "Augmented data must be the same for dataframes with and without",
        "rownames."
      )
    )
    
    ## tests when data has missing values
    
    data_list <- augment_data_helper(data, add_missing = TRUE)
    
    tibble_output <- a(model, newdata = data_list$tibble)
    check_augment_output(tibble_output, original_data = data_list$tibble)
    
    df_output <- a(model, newdata = data_list$df)
    check_augment_output(df_output, original_data = data_list$df)
    
    df_rows_output <- a(model, newdata = data_list$df_rows)
    check_augment_output(df_rows_output, original_data = data_list$df_rows)
    
    expect_equal(
      tibble_output, df_output,
      info = "Augmented data must be the same for tibble and data frame input."
    )
    
    expect_equal(
      df_output, df_rows_output,
      info = paste(
        "Augmented data must be the same for dataframes with and without",
        "rownames."
      )
    )
    
    ## argument checks happen
    
    expect_error(
      a(model, data = tibble()),
      info = "Augment must throw error when `data` is passed an empty tibble."
    )
    
    expect_error(
      a(model, data = data.frame()),
      info = c(
        "Augment must throw error when `data` is passed an empty dataframe."
      )
    )
    
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


### TIDY


check_tidy_arguments <- function(t) {
  args <- names(formals(t))
  
  expect_true(
    all(args %in% tidy_argument_glossary),
    info = "Tidy arguments must be listed in the argument glossary."
  )
  
  if ("conf.level" %in% args) {
    expect_true(
      "conf.int" %in% args,
      info = "Must have `conf.int` to pair with `conf.level` argument."
    )
  }
}

check_tidy_output <- function(to) {
  
  expect_s3_class(to, "tbl_df")
  
  # checks for Inf and NaN that work for tibbles?
  
  expect_true(
    all(colnames(to) %in% tidy_columns),
    info = "Column names for tidy output must be in the column glossary."
  )
}

check_dims <- function(tbl, expected_rows = NULL, expected_cols = NULL) {
  
  if (!is.null(expected_rows)) {
    expect_equal(nrow(tbl), expected_rows)
  }
  
  if (!is.null(expected_cols)) {
    expect_equal(ncol(tbl), expected_cols)
  }
}
