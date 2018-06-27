## helper and setup functions

tidy_ <- function(x, ...) UseMethod("tidy_")
augment_ <- function(x, data, ...) UseMethod("augment_")
glance_ <- function(x, ...) UseMethod("glance_")

apply_rowwise_df <- function(x, object, func, data, ...) {
  # group by columns that are not lists
  groupers <- colnames(x)[sapply(x, function(e) class(e)[1]) != "list"]
  groupers <- setdiff(groupers, object)
  # suppress "group_by" warning
  x <- suppressWarnings(group_by_(x, .dots = as.list(groupers)))
  # let the "data" argument specify column (for augment)
  if (!missing(data)) {
    if (as.character(substitute(data)) %in% colnames(x)) {
      data_column <- col_name(substitute(data))
      do(x, func(.[[object]][[1]], data = .[[data_column]][[1]], ...))
    } else {
      do(x, func(.[[object]][[1]], data = data, ...))
    }
  } else {
    do(x, func(.[[object]][[1]], ...))
  }
}

wrap_rowwise_df_ <- function(func) {
  function(x, object, ...) apply_rowwise_df(x, object, func, ...)
}

wrap_rowwise_df <- function(func) {
  function(x, object, ...) {
    n <- col_name(substitute(object))
    func(x, n, ...)
  }
}


#' Tidying methods for rowwise_dfs from dplyr, for tidying each row and
#' recombining the results
#' 
#' Rowwise tidiers are deprecated and will be removed from an upcoming version
#' of broom. We strongly recommend moving to a `nest-map-unnest` workflow
#' over a `rowwise-do` workflow. See the vignettes for examples.
#'
#' These `tidy`, `augment` and `glance` methods are for
#' performing tidying on each row of a rowwise data frame created by dplyr's
#' `group_by` and `do` operations. They first group a rowwise data
#' frame based on all columns that are not lists, then perform the tidying
#' operation on the specified column. This greatly shortens a common idiom
#' of extracting tidy/augment/glance outputs after a do statement.
#'
#' @param x a rowwise_df
#' @param object the column name of the column containing the models to
#' be tidied. For tidy, augment, and glance it should be the bare name; for
#' _ methods it should be quoted.
#' @param ... additional arguments to pass on to the respective tidying method
#'
#' @return A `"grouped_df"`, where the non-list columns of the
#' original are used as grouping columns alongside the tidied outputs.
#'
#' @details Note that this functionality is not currently implemented for
#' data.tables, since the result of the do operation is difficult to
#' distinguish from a regular data.table.
#'
#' @examples
#'
#' library(dplyr)
#' regressions <- mtcars %>%
#'     group_by(cyl) %>%
#'     do(mod = lm(mpg ~ wt, .))
#'
#' regressions
#'
#' regressions %>% tidy(mod)
#' regressions %>% augment(mod)
#' regressions %>% glance(mod)
#'
#' # we can provide additional arguments to the tidying function
#' regressions %>% tidy(mod, conf.int = TRUE)
#'
#' # we can also include the original dataset as a "data" argument
#' # to augment:
#' regressions <- mtcars %>%
#'     group_by(cyl) %>%
#'     do(mod = lm(mpg ~ wt, .), original = (.))
#'
#' # this allows all the original columns to be included:
#' regressions %>% augment(mod)  # doesn't include all original
#' regressions %>% augment(mod, data = original)  # includes all original
#'
#' @name rowwise_df_tidiers
NULL

#' @rdname rowwise_df_tidiers
#' @export
tidy.rowwise_df <- wrap_rowwise_df(tidy_.rowwise_df)

#' @rdname rowwise_df_tidiers
#' @export
tidy_.rowwise_df <- wrap_rowwise_df_(tidy)

#' @rdname rowwise_df_tidiers
#' @export
augment.rowwise_df <- wrap_rowwise_df(augment_.rowwise_df)

#' @rdname rowwise_df_tidiers
#' @export
augment_.rowwise_df <- wrap_rowwise_df_(augment)

#' @rdname rowwise_df_tidiers
#' @export
glance.rowwise_df <- wrap_rowwise_df(glance_.rowwise_df)

#' @rdname rowwise_df_tidiers
#' @export
glance_.rowwise_df <- wrap_rowwise_df_(glance)


# when dplyr::do is performed on an ungrouped tbl, it results in
# a one-row tbl_df with list columns. Need a special case for this.

wrap_tbl_df <- function(func, rowwise_func) {
  function(x, ...) {
    # use the rowwise function if it is a one-row tbl_df with all list
    # columns
    if (nrow(x) == 1 && all(sapply(x, function(col) inherits(col, "list")))) {
      return(rowwise_func(x, ...))
    } else {
      # otherwise, do traditional tidy/augment/glancing
      # (generally goes to the data.frame method)
      func(x, ...)
    }
  }
}


#' @rdname rowwise_df_tidiers
#' @export
tidy.tbl_df <- wrap_tbl_df(tidy, tidy.rowwise_df)


#' @rdname rowwise_df_tidiers
#' @export
augment.tbl_df <- wrap_tbl_df(augment, augment.rowwise_df)


#' @rdname rowwise_df_tidiers
#' @export
glance.tbl_df <- wrap_tbl_df(glance, glance.rowwise_df)
