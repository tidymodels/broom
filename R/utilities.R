validate_augment_input <- function(model, data = NULL, newdata = NULL) {
  
  # careful: `data` may be non-null due to default argument such as
  # `data = stats::model.frame(x)`
  # newdata argument default *should* always `NULL`
  
  data_passed <- !is.null(data)
  newdata_passed <- !is.null(newdata)
  
  # TODO: the following is bad if someone maps over models to augment
  
  # if (data_passed && newdata_passed) {
  #   warning(
  #     "Both `data` and `newdata` have been specified. Ignoring `data`.",
  #     call. = FALSE
  #   )
  # }
  
  # this test means that for `augment(fit)` to work, `augment.my_model`
  # must have a non-null default value for either `data` or `newdata`.
  
  # if (!data_passed && !newdata_passed) {
  #   message(
  #     "Neither `data` nor `newdata` has been specified.\n",
  #     "Attempting to reconstruct original data."
  #   )
  # }
  
  if (data_passed) {
    
    if (!inherits(data, "data.frame")) {
      stop("`data` argument must be a tibble or dataframe.", call. = FALSE)
    }
    
    tryCatch(
      as_tibble(data),
      error = function(e) {
        stop(
          "`data` is malformed: must be coercable to a tibble.\n",
          "Did you pass `data` the data originally used to fit your model?")
      }
    )

    # experimental checks that all columns in original data are present
    # in `data`. only warns on failure.
    
    possible_mf <- purrr::possibly(model.frame, otherwise = NULL)
    mf <- possible_mf(model)
    
    if (!is.null(mf)) {
      
      if (nrow(data) != nrow(mf)) {
        warning(
          "`data` must contain all rows passed to the original modelling ",
          "function with no extras rows.",
          call. = FALSE
        )
      }
      
      orig_cols <- all.vars(stats::terms(mf))
      
      if (!all(orig_cols %in% colnames(data))) {
        warning(
          "`data` might not contain columns present in original data.",
          call. = FALSE
        )
      }
    }
  }
  
  # TODO: check for predictor columns only when newdata is passed?
  # only warn if not found
  # if yes, be sure to add a test in `check_augment_function`
  # to do this, need to be able to determine what the response is
  # 
  # max says to look into `recipes:::get_rhs_vars` as a way to do this
  
  if (newdata_passed) {
    if (!inherits(newdata, "data.frame")) {
      stop("`newdata` argument must be a tibble or dataframe.", call. = FALSE)
    }
  }
}



#' Coerce a data frame to a tibble, preserving rownames
#' 
#' A thin wrapper around [tibble::as_tibble()], except checks for
#' rownames and adds them to a new column `.rownames` if they are
#' interesting (i.e. more than `1, 2, 3, ...`).
#' 
#' Replacement for `fix_data_frame()`.
#'
#' @param data A [data.frame()] or [tibble::tibble()].
#'
#' @return A `tibble` potentially with a `.rownames` column
#' @noRd
as_rw_tibble <- function(data) {
  
  # TODO: write a test for this
  
  row_nm <- rownames(data)
  has_row_nms <- any(row_nm != as.character(seq_along(row_nm)))
  
  df <- as_tibble(data)
  
  if (has_row_nms) {
    df <- tibble::rownames_to_column(df, var = ".rownames")
  }
  
  df
}



#' Ensure an object is a data frame, with rownames moved into a column
#'
#' @param x a data.frame or matrix
#' @param newnames new column names, not including the rownames
#' @param newcol the name of the new rownames column
#'
#' @return a data.frame, with rownames moved into a column and new column
#' names assigned
#'
#' @export
fix_data_frame <- function(x, newnames = NULL, newcol = "term") {
  if (!is.null(newnames) && length(newnames) != ncol(x)) {
    stop("newnames must be NULL or have length equal to number of columns")
  }

  if (all(rownames(x) == seq_len(nrow(x)))) {
    # don't need to move rownames into a new column
    ret <- data.frame(x, stringsAsFactors = FALSE)
    if (!is.null(newnames)) {
      colnames(ret) <- newnames
    }
  }
  else {
    ret <- data.frame(
      ...new.col... = rownames(x),
      unrowname(x),
      stringsAsFactors = FALSE
    )
    colnames(ret)[1] <- newcol
    if (!is.null(newnames)) {
      colnames(ret)[-1] <- newnames
    }
  }
  as_tibble(ret)
}


# strip rownames from a data frame
unrowname <- function(x) {
  rownames(x) <- NULL
  x
}


# remove NULL items in a vector or list
compact <- function(x) Filter(Negate(is.null), x)


#' insert a row of NAs into a data frame wherever another data frame has NAs
#'
#' @param x data frame that has one row for each non-NA row in original
#' @param original data frame with NAs
insert_NAs <- function(x, original) {
  indices <- rep(NA, nrow(original))
  indices[which(stats::complete.cases(original))] <- seq_len(nrow(x))
  x[indices, ]
}


#' add fitted values, residuals, and other common outputs to
#' an augment call
#'
#' Add fitted values, residuals, and other common outputs to
#' the value returned from `augment`.
#'
#' In the case that a residuals or influence generic is not implemented for the
#' model, fail quietly.
#'
#' @param x a model
#' @param data original data onto which columns should be added
#' @param newdata new data to predict on, optional
#' @param type Type of prediction and residuals to compute
#' @param type.predict Type of prediction to compute; by default
#' same as `type`
#' @param type.residuals Type of residuals to compute; by default
#' same as `type`
#' @param se.fit Value to pass to predict's `se.fit`, or NULL for
#' no value
#' @param ... extra arguments (not used)
#'
#' @export
augment_columns <- function(x, data, newdata, type, type.predict = type,
                            type.residuals = type, se.fit = TRUE, ...) {
  notNAs <- function(o) {
    if (is.null(o) || all(is.na(o))) NULL else o
  }
  
  residuals0 <- purrr::possibly(stats::residuals, NULL)
  influence0 <- purrr::possibly(stats::influence, NULL)
  cooks.distance0 <- purrr::possibly(stats::cooks.distance, NULL)
  rstandard0 <- purrr::possibly(stats::rstandard, NULL)
  predict0 <- purrr::possibly(stats::predict, NULL)

  # call predict with arguments
  args <- list(x)
  if (!missing(newdata)) {
    args$newdata <- newdata
  }
  if (!missing(type.predict)) {
    args$type <- type.predict
  }
  args$se.fit <- se.fit
  args <- c(args, list(...))



  if ("panelmodel" %in% class(x)) {
    # work around for panel models (plm)
    # stat::predict() returns wrong fitted values when applied to random or fixed effect panel models [plm(..., model="random"), plm(, ..., model="pooling")]
    # It works only for pooled OLS models (plm( ..., model="pooling"))
    pred <- model.frame(x)[, 1] - residuals(x)
  } else {
    # suppress warning: geeglm objects complain about predict being used
    pred <- suppressWarnings(do.call(predict0, args))
  }

  if (is.null(pred)) {
    # try "fitted" instead- some objects don't have "predict" method
    pred <- do.call(stats::fitted, args)
  }

  if (is.list(pred)) {
    ret <- data.frame(.fitted = pred$fit)
    ret$.se.fit <- pred$se.fit
  } else {
    ret <- data.frame(.fitted = as.numeric(pred))
  }

  na_action <- if (isS4(x)) {
    attr(stats::model.frame(x), "na.action")
  } else {
    stats::na.action(x)
  }

  if (missing(newdata) || is.null(newdata)) {
    if (!missing(type.residuals)) {
      ret$.resid <- residuals0(x, type = type.residuals)
    } else {
      ret$.resid <- residuals0(x)
    }

    infl <- influence0(x, do.coef = FALSE)
    if (!is.null(infl)) {
      if (inherits(x, "gam")) {
        ret$.hat <- infl
        ret$.sigma <- NA
      } else {
        ret$.hat <- infl$hat
        ret$.sigma <- infl$sigma
      }
    }

    # if cooksd and rstandard can be computed and aren't all NA
    # (as they are in rlm), do so
    ret$.cooksd <- notNAs(cooks.distance0(x))
    ret$.std.resid <- notNAs(rstandard0(x))

    original <- data

    if (class(na_action) == "exclude") {
      # check if values are missing
      if (length(stats::residuals(x)) > nrow(data)) {
        warning(
          "When fitting with na.exclude, rows with NA in ",
          "original data will be dropped unless those rows are provided ",
          "in 'data' argument"
        )
      }
    }
  } else {
    original <- newdata
  }

  if (is.null(na_action) || nrow(original) == nrow(ret)) {
    # no NAs were left out; we can simply recombine
    original <- fix_data_frame(original, newcol = ".rownames")
    return(as_tibble(cbind(original, ret)))
  } else if (class(na_action) == "omit") {
    # if the option is "omit", drop those rows from the data
    original <- fix_data_frame(original, newcol = ".rownames")
    original <- original[-na_action, ]
    return(as_tibble(cbind(original, ret)))
  }

  # add .rownames column to merge the results with the original; resilent to NAs
  ret$.rownames <- rownames(ret)
  original$.rownames <- rownames(original)
  ret <- merge(original, ret, by = ".rownames")

  # reorder to line up with original
  ret <- ret[order(match(ret$.rownames, rownames(original))), ]

  rownames(ret) <- NULL
  # if rownames are just the original 1...n, they can be removed
  if (all(ret$.rownames == seq_along(ret$.rownames))) {
    ret$.rownames <- NULL
  }
  
  as_tibble(ret)
}


#' Add logLik, AIC, BIC, and other common measurements to a glance of
#' a prediction
#'
#' A helper function for several functions in the glance generic. Methods
#' such as logLik, AIC, and BIC are defined for many prediction
#' objects, such as lm, glm, and nls. This is a helper function that adds
#' them to a glance data.frame can be performed. If any of them cannot be
#' computed, it fails quietly.
#'
#' @details In one special case, deviance for objects of the
#' `lmerMod` class from lme4 is computed with
#' `deviance(x, REML=FALSE)`.
#'
#' @param ret a one-row data frame (a partially complete glance)
#' @param x the prediction model
#'
#' @return a one-row data frame with additional columns added, such as
#'   \item{logLik}{log likelihoods}
#'   \item{AIC}{Akaike Information Criterion}
#'   \item{BIC}{Bayesian Information Criterion}
#'   \item{deviance}{deviance}
#'   \item{df.residual}{residual degrees of freedom}
#'
#' Each of these are produced by the corresponding generics
#'
#' @export
finish_glance <- function(ret, x) {
  ret$logLik <- tryCatch(as.numeric(stats::logLik(x)), error = function(e) NULL)
  ret$AIC <- tryCatch(stats::AIC(x), error = function(e) NULL)
  ret$BIC <- tryCatch(stats::BIC(x), error = function(e) NULL)

  # special case for REML objects (better way?)
  if (inherits(x, "lmerMod")) {
    ret$deviance <- tryCatch(stats::deviance(x, REML = FALSE),
      error = function(e) NULL
    )
  } else {
    ret$deviance <- tryCatch(stats::deviance(x), error = function(e) NULL)
  }
  ret$df.residual <- tryCatch(df.residual(x), error = function(e) NULL)
  
  as_tibble(ret, rownames = NULL)
}


#' Calculate confidence interval as a tidy data frame
#'
#' Return a confidence interval as a tidy data frame. This directly wraps the
#' [confint()] function, but ensures it follows broom conventions:
#' column names of `conf.low` and `conf.high`, and no row names.
#' 
#' `confint_tidy`
#'
#' @param x a model object for which [confint()] can be calculated
#' @param conf.level confidence level
#' @param func A function to compute a confidence interval for `x`. Calling
#'   `func(x, level = conf.level, ...)` must return an object coercable to a
#'   tibble. This dataframe like object should have to columns corresponding
#'   the lower and upper bounds on the confidence interval.
#' @param ... extra arguments passed on to `confint`
#'
#' @return A tibble with two columns: `conf.low` and `conf.high`.
#'
#' @seealso \link{confint}
#'
#' @export
confint_tidy <- function(x, conf.level = .95, func = stats::confint, ...) {
  # avoid "Waiting for profiling to be done..." message for some models
  ci <- suppressMessages(func(x, level = conf.level, ...))
  
  # protect against confidence intervals returned as named vectors
  if (is.null(dim(ci))) {
    ci <- matrix(ci, nrow = 1)
  }
  
  # TODO: informative errors for non-vector, dataframe, tibble CI output
  
  # remove rows that are all NA. *not the same* as na.omit which checks
  # for any NA.
  all_na <- apply(ci, 1, function(x) all(is.na(x)))
  ci <- ci[!all_na, , drop = FALSE]
  colnames(ci) <- c("conf.low", "conf.high")
  as_tibble(ci)
}

# utility function from tidyr::col_name
col_name <- function(x, default = stop("Please supply column name", call. = FALSE)) {
  if (is.character(x)) {
    return(x)
  }
  if (identical(x, quote(expr = ))) {
    return(default)
  }
  if (is.name(x)) {
    return(as.character(x))
  }
  if (is.null(x)) {
    return(x)
  }
  stop("Invalid column specification", call. = FALSE)
}


globalVariables(
  c(
    ".",
    ".id",
    ".rownames",
    "ci.lower",
    "ci.upper",
    "column", 
    "column1",
    "column2",
    "comp",
    "comparison",
    "conf.high",
    "conf.low", 
    "data",
    "df.residual",
    "effect",
    "est",
    "estimate",
    "expCIWidth", 
    "fit",
    "GCV",
    "group1",
    "group2",
    "index",
    "Intercept",
    "item1", 
    "item2",
    "key",
    "lambda",
    "level", 
    "lhs",
    "loading",
    "method", 
    "Method",
    "N", 
    "nobs", 
    "norig",
    "objs",
    "obs",
    "op",
    "p.value", 
    "PC",
    "percent",
    "pvalue",
    "rhs", 
    "rmsea.ci.upper",
    "rowname", 
    "se", 
    "series",
    "Slope",
    "statistic", 
    "std.dev",
    "std.error", 
    "step",
    "stratum",
    "surv",
    "term",
    "type",
    "value",
    "Var1",
    "Var2", 
    "variable",
    "wald.test",
    "z"
  )
)
