#' Check that all elements of a list are equal
#' 
#' From SO: https://tinyurl.com/list-elems-equal-r
#'
#' @param x A list
#' 
#' @return Either `TRUE` or `FALSE`
#' 
all_equal_list <- function(x) {
  sum(duplicated.default(x)) == length(x) - 1L
}

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
check_arguments <- function(tidy_method, strict = FALSE) {
  
  if (!strict) {
    expect_true(TRUE)  # prevent skip message
    return(invisible(NULL))
  }
  
  args <- names(formals(tidy_method))
  func_name <- as.character(substitute(tidy_method))
  
  stop("Informative message on mistakes to update argument_glossary")
  
  # functions might be: tidy.irlba *or* tidy_irlba for list tidiers
  prefix <- gsub("[\\.|_].*","", func_name)
  allowed_args <- dplyr::filter(argument_glossary, method == !!prefix)$argument
  
  if ("conf.level" %in% args) {
    expect_true(
      "conf.int" %in% args,
      info = "Tidiers with `conf.level` argument must have `conf.int` argument."
    )
  }
  
  expect_true(
    all(args %in% allowed_args),
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
  columns = colnames(output),
  strict = FALSE) {
  
  expect_s3_class(output, "tbl_df")
  
  if (!strict) {
    return(invisible(NULL))
  }
  
  # TODO: implement NaN / Inf checks
  
  acceptable_columns <- column_glossary %>% 
    dplyr::filter(method == !!method) %>% 
    dplyr::pull(column)
  
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
check_glance_outputs <- function(..., strict = FALSE) {
  
  check_single_glance_output <- function(gl) {
    check_tibble(gl, method = "glance")
    expect_equal(
      nrow(gl), 1,
      info = "Glance must return a tibble with exactly 1 row."
    )
  }
  
  glances <- list(...)
  purrr::walk(glances, check_single_glance_output)
  
  if (!strict) {
    return(invisible(NULL))
  }
  
  expect_true(
    all_equal_list(purrr::map(glances, colnames)),
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
check_single_augment_output <- function(au, passed_data, strict = FALSE) {
  
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
  
  if (!strict) {
    return(invisible(NULL))
  }
  
  if (.row_names_info(passed_data) > 0) {
    row_nm <- rownames(passed_data)
    if (all(row_nm != seq_along(row_nm))) {
      expect_true(
        ".rownames" %in% aug_cols,
        info = paste(
          "A `.rownames` column must be present in augmented data when input\n",
          "data is a data.frame with rownames other than 1, 2, 3, ..."
        )
      )
    }
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
#' - **tibble**: the data in a [tibble::tibble()].
#' - **no_row**: the data in a [data.frame()] without row names.
#' - **row_nm**: the data in a `data.frame`, with row names.
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
  
  tibble <- tibble::as_tibble(data)
  
  no_row <- as.data.frame(data)
  rownames(no_row) <- NULL
  
  row_nm <- data
  rownames(row_nm) <- paste0("obs", 1:nrow(data))
  
  list(tibble = tibble, no_row = no_row, row_nm = row_nm)
}

#' Title
#'
#' @param aug 
#' @param model 
#' @param data 
#' @param add_missing 
#' @param test_newdata 
#'
#' @return
#' @export
#'
#' @examples
check_augment_data_specification <- function(
  aug,
  model,
  data,
  add_missing,
  test_newdata) {
  
  # aug, data pulled from environment of calling function?
  
  dl <- augment_data_helper(data, add_missing)
  new_dl <- dl
  
  if (test_newdata) {
    dl <- list()
    passed_data <- new_dl
  } else {
    new_dl <- list()
    passed_data <- dl
  }
  
  au_tibble <- aug(model, data = dl$tibble, newdata = new_dl$tibble)
  au_no_row <- aug(model, data = dl$no_row, newdata = new_dl$no_row)
  au_row_nm <- aug(model, data = dl$row_nm, newdata = new_dl$row_nm)
  
  au_list <- list(au_tibble, au_no_row, au_row_nm)
  purrr::walk2(au_list, passed_data, check_single_augment_output)
  
  expect_equal(au_tibble, au_no_row,
    info = "Augmented data must be the same for tibble and data frame input."
  )
  
  # au_row_nm should have a `.rownames` column not present in `au_tibble` or
  # `au_no_row`. presence is checked in `check_single_augment_output`,
  # here we just that that the results are the same after stripping this
  # column out.
  
  expect_equal(
    au_no_row,
    dplyr::select(au_row_nm, -.rownames),
    info = paste(
      "Augmented data must be the same for dataframes with and without",
      "rownames."
    )
  )
  
  # au_row_nm should have a `.rownames` column not present in `au_tibble` or
  # `au_no_row`. presence is checked in `check_single_augment_output`,
  # here we just that that the results are the same after stripping this
  # column out.
  
  expect_equal(
    au_no_row,
    dplyr::select(au_row_nm, -.rownames),
    info = paste(
      "Augmented data must be the same for dataframes with and without",
      "rownames."
    )
  )
  
  # next up: tests that subsets of the newdata behave appropriately
  # i.e. we should have that results(head(newdata)) == head(results(newdata))
  
  if (test_newdata) {
    
    head_dl <- purrr::map(dl, head)
    head_new_dl <- purrr::map(new_dl, head)
    
    hd_tibble <- aug(model, data = head_dl$tibble, newdata = head_new_dl$tibble)
    hd_no_row <- aug(model, data = head_dl$no_row, newdata = head_new_dl$no_row)
    hd_row_nm <- aug(model, data = head_dl$row_nm, newdata = head_new_dl$row_nm)
    
    hd_list <- list(hd_tibble, hd_no_row, hd_row_nm)
    
    expect_equal(
      hd_list, purrr::map(au_list, head),
      info = paste0(
        "Subsetting data before vs after augmentation must not effect results.",
        "\ni.e. we must have results(head(newdata)) == head(results(newdata))"
      )
    )
  }
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
check_augment_function <- function(
  aug,
  model,
  data = NULL,
  newdata = NULL,
  strict = FALSE) {
  
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
  
  if (!strict) {
    
    if (data_arg) {
      au_data <- augment(model, data = data)
      check_tibble(au_data, method = "augment", strict = strict)
    }
    
    if (newdata_arg) {
      au_newdata <- augment(model, newdata = newdata)
      check_tibble(au_newdata, method = "augment", strict = strict)
    }
    
    return(invisible())
  }
  
  if (data_arg) {
    
    # make sure data in data frame, dataframe with rows, and tibble
    # all give expected results
    
    check_augment_data_specification(
      aug = aug,
      model = model,
      data = data,
      add_missing = FALSE,
      test_newdata = FALSE
    )
    
    # we don't check add_missing = TRUE for the data argument because the
    # user is guaranteeing us that the data they give us is the same
    # they gave to the modelling function. also, the new row of NAs added
    # *should* cause things like influence calculates to break
  }
  
  if (newdata_arg) {
    
    check_augment_data_specification(
      aug = aug,
      model = model,
      data = data,
      add_missing = FALSE,
      test_newdata = TRUE
    )
    
    check_augment_data_specification(
      aug = aug,
      model = model,
      data = data,
      add_missing = TRUE,
      test_newdata = TRUE
    )
  }
}


check_tidy_output <- function(td, strict = FALSE) {
  check_tibble(td, method = "tidy", strict = strict)
}

check_dims <- function(tibble, expected_rows = NULL, expected_cols = NULL) {
  
  if (!is.null(expected_rows)) {
    expect_equal(nrow(tibble), expected_rows)
  }
  
  if (!is.null(expected_cols)) {
    expect_equal(ncol(tibble), expected_cols)
  }
}

## old code to check augment behavior with various NA options



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
