# helper functions for testing

# TODO: document these functions with roxygen, and also in adding new tidiers

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

argument_glossary <- c(
  glance_argument_glossary,
  augment_argument_glossary,
  tidy_argument_glossary
)

## output column names: allowable columns names in tidier output

glance_columns <- tribble(
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
  ".cooksd", "", c("betareg", ""),
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

column_glossary <- bind_rows(
  glance_columns,
  augment_columns,
  tidy_columns,
  .id = "method"
) %>% 
  mutate(method = recode(method, 
    "1" = "glance",
    "2" = "augment",
    "3" = "tidy"
  ))

#' Check that tidying methods use allowed argument names
#' 
#' Use this function to test tidying methods in broom tests. 
#' Called for side effects. Will throw a useful error if
#' `tidy_method` has unacceptably named arguments.
#' Otherwise silent.
#'
#' @param tidy_method A tidying method. For example: `glance.Arima`.
#'
#' @seealso [testthat], [testthat::expect_true()]
#' @examples
#' 
#' check_arguments(tidy.Arima)
#' 
check_arguments <- function(tidy_method) {
  args <- names(formals(tidy_method))
  func_name <- as.character(substitute(tidy_method))
  
  expect_true(
    all(args %in% argument_glossary),
    info = paste0(
      "Arguments to `", func_name, "` must be listed in the argument glossary."
    )
  )
}

#' Check the output of a tidying method
#' 
#' Do not use `check_tibble` in broom tests. `check_glance_output`,
#' `check_augment_function` and `check_tidy_output` all call `check_tibble`.
#' Use those instead. This function is called for its side effects.
#' Throws a useful error if `output` is not a `tibble`. Checks that
#' columns in output use acceptable names as defined in the glossary.
#' Optionally can check for `NaN` or `Inf` values. Silent if
#' everything goes well.
#'
#' @param output Object returned from [tidy()], [augment()] or [glance()].
#' @param method One of `"tidy"`, `"augment"` or `"glance"`. Determines
#'   which set of column name checks are applied.
#' @param check_values Whether to check if `output` contains `NaN` or `Inf`.
#'   Defaults to `FALSE`.
#' @param columns The names of the columns in the output data frame. Defaults
#'   to the column names of `output`. Useful for `augment` when you only
#'   want to check the new columns in the data frame, as opposed to all
#'   columns.
#'
#' @examples
#' 
#' fit <- lm(hp ~ ., mtcars)
#' gl <- glance(fit)
#' 
#' # but don't do this, use: `check_glance_output(gl)` instead
#' check_tibble(gl, method = "glance", check_values = TRUE)  
#' 
check_tibble <- function(
  output,
  method,
  check_values = FALSE,
  columns = colnames(output)) {
  
  expect_s3_class(output, "tbl_df")
  
  # TODO: implement NaN / Inf checks
  
  acceptable_columns <- column_glossary %>% 
    filter(method == !!method) %>% 
    pull(column)
  
  expect_true(
    all(columns %in% acceptable_columns),
    info = paste0(
      "Column names for `", method, "` output must be in the column glossary."
    )
  )
}

#' Check the output of a glance method
#' 
#' Use this function to test glance methods in broom tests. 
#' Called for side effects. Will throw a useful error if
#' `glance` specification is violated. Otherwise silent.
#'
#' @param ... Outputs returned from calls to (the same) [glance] method.
#' 
#' @seealso [check_tibble()]
#' @examples
#' 
#' fit <- lm(hp ~ ., mtcars)
#' fit2 <- lm(hp ~ 1, mtcars)
#' 
#' gl <- glance(fit)
#' gl2 <- glance(fit2)
#' 
#' check_glance_outputs(gl)  # can check a single glance
#' 
#' # checking multiple glance outputs for same model type makes sure
#' # column names are consistent
#' 
#' check_glance_outputs(gl, gl2)
#'
check_glance_outputs <- function(...) {
  
  check_single_glance_output <- function(gl) {
    check_tibble(gl, method = "glance")
    expect_equal(
      nrow(gl), 1,
      info = "Glance must return a tibble with exactly 1 row."
    )
  }
  
  glances <- list(...)
  walk(glances, check_single_glance_output)
  
  # check that all elements of a list are equal
  # from SO: https://tinyurl.com/list-elems-equal-r
  all_equal_list <- function(x) sum(duplicated.default(x)) == length(x) - 1L
  
  expect_true(
    all_equal_list(map(glances, colnames)),
    info = "Glance column names and order must agree across all ouputs."
  ) 
}


#' Check the output of an augment method
#' 
#' Do not use `check_single_augment_output` in broom tests.
#' Use `check_augment_function` instead, which will call this function
#' for many relevant inputs. As always, call for side effects. Errors
#' when `augment` specification is violated, otherwise silent.
#'
#' @param au Output from a call to [augment]
#' @param passed_data Whichever of `data` or `newdata` was passed to
#'   `augment`. Should be a data frame of some sort.
#'
#' @examples
#' 
#' fit <- lm(hp ~ ., mtcars)
#' au <- augment(fit)
#' check_single_augment_output(au, mtcars)
#' 
check_single_augment_output <- function(au, passed_data) {
  
  orig_cols <- colnames(passed_data)
  aug_cols <- colnames(au)
  new_cols <- setdiff(aug_cols, orig_cols)
  
  check_tibble(au, method = "augment", columns = new_cols)
  
  expect_equal(nrow(au), nrow(passed_data),
    info = "Augmented data must have same number of rows as original data."
  )
  
  expect_true(
    all(orig_cols %in% aug_cols),
    info = "Original columns must be presented in augmented data."
  )
  
  if (.row_names_info(passed_data) > 0) {
    expect_true(
      ".rownames" %in% aug_cols,
      info = paste(
        "A `.rownames` column must be present in augmented data when input",
        "data is a data.frame with rownames"
      )
    )
  }
}

#' Get copies of a dataset with various rowname behaviors
#' 
#' Helper function for [check_helper_function()]. There should be no need
#' to ever use this in tests. Takes an arbitrary dataset and returns a list
#' with three copies of the dataset. Optionally introduces `NA` values into
#' the dataset.
#'
#' @param data A data set as a `data.frame` or `tibble`.
#' @param add_missing Whether or not to set some values in `data` to `NA`.
#'   When `TRUE` sets the diagonal elements of `data` to `NA` and adds a
#'   row of all `NA`s to the end of data. This ensures that every column
#'   has missing data. Defaults to `FALSE`.
#'
#' @return A list with three copes of `data`:
#' - **tbl**: the data in a [tibble::tibble()].
#' - **no_row_nm**: the data in a [data.frame()] without row names.
#' - **has_row_nm**: the data in a `data.frame`, with row names.
#'
#' @seealso [.row_names_info()], [rownames()], [tibble::rownames_to_column()]
#' @examples
#' 
#' augment_data_helper(iris, add_missing = TRUE)
#' 
augment_data_helper <- function(data, add_missing) {
  
  if (add_missing) {
    diag(data) <- NA
    data[nrow(data) + 1, ] <- rep(NA, ncol(data))
  }
  
  tbl <- as_tibble(data)
  
  no_row_nm <- data
  rownames(no_row_nm) <- NULL
  
  row_nm <- data
  rownames(row_nm) <- paste0("obs", 1:nrow(data))
  
  list(tbl = tbl, no_row_nm = no_row_nm, row_nm = row_nm)
}

check_augment_data_specification <- function(aug, model, add_missing, newdata) {
  
  # aug, data pulled from environment of calling function?
  
  dl <- augment_data_helper(data, add_missing)
  new_dl <- dl
  
  if (newdata) {
    dl <- list()
    passed_data <- new_dl
  } else {
    new_dl <- list()
    passed_data <- dl
  }
  
  au_tbl <- aug(model, data = dl$tbl, newdata = new_dl$tbl)
  au_no_row_nm <- aug(model, data = dl$no_row_nm, newdata = new_dl$no_row_nm)
  au_row_nm <- aug(model, data = dl$row_nm, newdata = new_dl$row_nm)
  
  au_list <- list(au_tbl, au_no_row_nm, au_row_nm)
  walk2(au_list, passed_data, check_single_augment_output)
  
  expect_equal(au_tbl, au_no_row_nm,
    info = "Augmented data must be the same for tibble and data frame input."
  )
  
  # au_row_nm should have a `.rownames` column not present in `au_tbl` or
  # `au_no_row_nm`. presence is checked in `check_single_augment_output`,
  # here we just that that the results are the same after stripping this
  # column out.
  
  expect_equal(
    df_output,
    dplyr::select(au_row_nm, -.rownames),
    info = paste(
      "Augmented data must be the same for dataframes with and without",
      "rownames."
    )
  )
}


#' Check that an augment method works correctly
#'
#' @param aug 
#' @param model 
#' @param data 
#' @param newdata 
#'
#' @return
#' @export
#'
#' @examples
#' 
#' library(betareg)
#' fit <- betareg(yield ~ batch + temp, data = GasolineYield)
#' 
#' check_augment_function(
#'   aug = augment.betareg,
#'   model = fit,
#'   data = GasolineYield,
#'   newdata = GasolineYield
#' )
#' 
check_augment_function <- function(aug, model, data = NULL, newdata = NULL) {
  
  # TODO: check default behavior when there is a data argument
  # but nothing gets passed to it
  
  # TODO: throw informative error when data can't be coerced to tibble,
  #   hint that this is likely because of ugly stuff in model.frame()
  
  args <- names(formals(aug))
  
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
    
    check_augment_data_specification(
      aug = aug,
      model = model,
      add_missing = FALSE,
      newdata = FALSE
    )
    
    check_augment_data_specification(
      aug = aug,
      model = model,
      add_missing = TRUE,
      newdata = FALSE
    )
    
    expect_error(
      aug(model, data = data.frame()),
      info = c(
        "Augment must throw error when `data` is passed an empty dataframe."
      )
    )
    
    expect_error(
      aug(model, data = 1L),
      info = "Augment must throw errow when `data` is not a dataframe."
    )
  }
  
  if (newdata_arg) {
    
    check_augment_data_specification(
      aug = aug,
      model = model,
      add_missing = FALSE,
      newdata = TRUE
    )
    
    check_augment_data_specification(
      aug = aug,
      model = model,
      add_missing = TRUE,
      newdata = TRUE
    )
    
    expect_error(
      aug(model, newdata = data.frame()),
      info = c(
        "Augment must throw error when `newdata` is passed an empty dataframe."
      )
    )
    
    expect_error(
      aug(model, newdata = 1L),
      info = "Augment must throw errow when `newdata` is not a dataframe."
    )
  }
  
  if (data_arg  && newdata_arg) {
    expect_error(
      augment(model, data = data, newdata = newdata),
      info = "Augment must error when both `data` and `newdata` are specified."
    )
  }
}


### TIDY


check_tidy_arguments <- function(t) {
  
  check_arguments(t)
  
  if ("conf.level" %in% args) {
    expect_true(
      "conf.int" %in% args,
      info = "Must have `conf.int` to pair with `conf.level` argument."
    )
  }
}

check_tidy_output <- function(td) {
  check_tibble(td, method = "tidy")
}

check_dims <- function(tbl, expected_rows = NULL, expected_cols = NULL) {
  
  if (!is.null(expected_rows)) {
    expect_equal(nrow(tbl), expected_rows)
  }
  
  if (!is.null(expected_cols)) {
    expect_equal(ncol(tbl), expected_cols)
  }
}
