# Rename only those columns in a data frame that are present. Example:
# 
# rename2(
#   tibble(dog = 1),
#   cat = dog,
#   mouse = gerbil
# )
#
rename2 <- function(.data, ...) {
  dots <- quos(...)
  present <- purrr::keep(dots, ~quo_name(.x) %in% colnames(.data))
  rename(.data, !!!present)
}

exponentiate <- function(data) {
  
  data <- mutate_at(data, vars(estimate), exp)
  
  if ("conf.low" %in% colnames(data))
    data <- mutate_at(data, vars(conf.low, conf.high), exp)
  
  data
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
#' 
as_broom_tibble <- function(data) {
  
  # TODO: error when there aren't column names?
  
  tryCatch(
    df <- as_tibble(data),
    
    error = function(cnd)
      stop("Could not coerce data to `tibble`. Try explicitly passing a",
           "dataset to either the `data` or `newdata` argument.",
           call. = FALSE)
  )
  
  if (has_rownames(data))
    df <- tibble::add_column(df, .rownames = rownames(data), .before = TRUE)
  df
}

# copied from modeltests. re-export if at some we Import modeltests rather
# than suggest it
has_rownames <- function(df) {
  if (tibble::is_tibble(df))
    return(FALSE)
  any(rownames(df) != as.character(1:nrow(df)))
}


#' Ensure an object is a data frame, with rownames moved into a column
#'
#' @param x a data.frame or matrix
#' @param newnames new column names, not including the rownames
#' @param newcol the name of the new rownames column
#'
#' @return a data.frame, with rownames moved into a column and new column
#' names assigned
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
augment_columns <- function(x, data, newdata = NULL, type, type.predict = type,
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
  if (!is.null(newdata)) {
    args$newdata <- newdata
  }
  if (!missing(type.predict)) {
    args$type <- type.predict
  }
  args$se.fit <- se.fit
  args <- c(args, list(...))



  if ("panelmodel" %in% class(x)) {
    # work around for panel models (plm)
    # stat::predict() returns wrong fitted values when applied to random or
    # fixed effect panel models [plm(..., model="random"), plm(, ..., model="pooling")]
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
        zero_weights <- "weights" %in% names(x) &&
          any(zero_weight_inds <- abs(x$weights) < .Machine$double.eps ^ 0.5)
        if (zero_weights) {
          ret[c(".hat", ".sigma")] <- 0
          ret$.hat[! zero_weight_inds] <- infl$hat
          ret$.sigma[! zero_weight_inds] <- infl$sigma
        } else {
          ret$.hat <- infl$hat
          ret$.sigma <- infl$sigma
        }
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

response <- function(object, newdata = NULL) {
  model.response(model.frame(terms(object), data = newdata, na.action = na.pass))
}

data_error <- function(cnd) {
  stop(
    "Can't augment data with observation level measures.\n",
    "Did you provide `data` with the exact data used for model fitting?",
    call. = FALSE
  )
}

safe_response <- purrr::possibly(response, NULL)

# in weighted regressions, influence measures should be zero for
# data points with zero weight
# helper for augment.lm and augment.glm
add_hat_sigma_cols <-  function(df, x, infl) {
  
  df$.hat <- 0
  df$.sigma <- 0
  
  w <- x$weights
  nonzero_idx <- if (is.null(w)) seq_along(df$.hat) else which(w != 0)
  
  df$.hat[nonzero_idx] <- infl$hat
  df$.sigma[nonzero_idx] <- infl$sigma
  df
}

# adds only the information that can be defined for newdata. no influence
# measure of anything fun like goes here.
#
# add .fitted column
# add .resid column if response is present
# deal with rownames and convert to tibble as necessary
# add .se.fit column if present
# be *incredibly* careful that the ... are passed correctly
augment_newdata <- function(x, data, newdata, .se_fit, ...) {
  passed_newdata <- !is.null(newdata)
  df <- if (passed_newdata) newdata else data
  df <- as_broom_tibble(df)
  
  # NOTE: It is important use predict(x, newdata = newdata) rather than 
  # predict(x, newdata = df). This is to avoid an edge case breakage
  # when augment is called with no data argument, so that data is
  # model.frame(x). When data = model.frame(x) and the model formula
  # contains a term like `log(x)`, the predict method will break. Luckily,
  # predict(x, newdata = NULL) works perfectly well in this case. 
  # 
  # The current code relies on predict(x, newdata = NULL) functioning
  # equivalently to predict(x, newdata = data). An alternative would be to use
  # fitted(x) instead, although this may not play well with missing data,
  # and may behave like na.action = na.omit rather than na.action = na.pass.
  
  # This helper *should not* be used for predict methods that do not have
  # an na.pass argument
  
  if (.se_fit) {
    pred_obj <- predict(x, newdata = newdata, na.action = na.pass, se.fit = TRUE, ...)
    df$.fitted <- pred_obj$fit
    
    # a couple possible names for the standard error element of the list
    # se.fit: lm, glm
    # se: loess
    se_idx <- which(names(pred_obj) %in% c("se.fit", "se"))
    df$.se.fit <- pred_obj[[se_idx]]
  } else if (passed_newdata) {
    df$.fitted <- predict(x, newdata = newdata, na.action = na.pass, ...)
  } else {
    df$.fitted <- predict(x, na.action = na.pass, ...)
  }
  
  resp <- safe_response(x, df)
  if (!is.null(resp) && is.numeric(resp))
    df$.resid <- df$.fitted - resp
  df
}

# this exists to avoid the single predictor gotcha
# this version adds a terms column
broom_confint <- function(x, ...) {
  
  # warn on arguments silently being ignored
  ellipsis::check_dots_used()
  ci <- suppressMessages(confint(x, ...))
  
  # confint called on models with a single predictor
  # often returns a named vector rather than a matrix :(
  
  if (is.null(dim(ci))) {
    ci <- matrix(ci, nrow = 1)
  }
  
  ci <- as_tibble(ci)
  names(ci) <- c("term", "conf.low", "conf.high")
  ci
}

# this version adds a terms column
broom_confint_terms <- function(x, ...) {
  
  # warn on arguments silently being ignored
  ellipsis::check_dots_used()
  ci <- suppressMessages(confint(x, ...))
  
  # confint called on models with a single predictor
  # often returns a named vector rather than a matrix :(
  
  if (is.null(dim(ci))) {
    ci <- matrix(ci, nrow = 1)
    rownames(ci) <- names(coef(x))[1]
  }
  
  ci <- as_tibble(ci, rownames = "term")
  names(ci) <- c("term", "conf.low", "conf.high")
  ci
}

#' @importFrom utils globalVariables
globalVariables(
  c(
    ".",
    ".id",
    ".rownames",
    "aic",
    "bic",
    "ci.lower",
    "ci.upper",
    "column", 
    "column1",
    "column2",
    "comp",
    "comparison",
    "conf.high",
    "conf.low", 
    "cook.d",
    "cov.r",
    "cutoffs",
    "data",
    "dffits",
    "dfbetas",
    "df.residual",
    "distance",
    "effect",
    "est",
    "estimate",
    "expCIWidth", 
    "fit",
    "GCV",
    "group1",
    "group2",
    "hat",
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
    "P-perm (1-tailed)",
    "pvalue",
    "QE.del",
    "rd_roclet",
    "rhs", 
    "rmsea.ci.upper",
    "rowname", 
    "rstudent",
    "se", 
    "series",
    "Slope",
    "statistic", 
    "std.dev",
    "std.error", 
    "step",
    "stratum",
    "surv",
    "tau2.del",
    "term",
    "type",
    "value",
    "Var1",
    "Var2", 
    "variable",
    "wald.test",
    "weight",
    "y",
    "z"
  )
)
