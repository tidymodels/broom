## helper and setup functions

tidy_ <- function(x, ...) UseMethod("tidy_")
augment_ <- function(x, data, ...) UseMethod("augment_")
glance_ <- function(x, ...) UseMethod("glance_")

apply_rowwise_df <- function(x, object, func, ...) {
    # group by columns that are not lists
    groupers <- colnames(x)[sapply(x, function(e) class(e)[1]) != "list"]
    groupers <- setdiff(groupers, object)
    # suppress "group_by" warning
    x <- suppressWarnings(group_by_(x, .dots = as.list(groupers)))
    do(x, func(.[[object]][[1]], ...))
}

wrap_rowwise_df_ <- function(func) {
    function(x, data, ...) apply_rowwise_df(x, data, func, ...)
}

wrap_rowwise_df <- function(func) {
    function(x, data, ...) {
        n <- col_name(substitute(data))
        func(x, n, ...)
    }
}


#' Tidying methods for rowwise_dfs from dplyr, for tidying each row and
#' recombining the results
#' 
#' These \code{tidy}, \code{augment} and \code{glance} methods are for
#' performing tidying on each row of a rowwise data frame created by dplyr's
#' \code{group_by} and \code{do} operations. They first group a rowwise data
#' frame based on all columns that are not lists, then perform the tidying
#' operation on the specified column. This greatly shortens a common idiom
#' of extracting tidy/augment/glance outputs after a do statement.
#' 
#' @param x a rowwise_df
#' @param data the column name of the column containing the models to
#' be tidied. For tidy, augment, and glance it should be the bare name; for
#' _ methods it should be quoted. Note that this argument is named \code{data}
#' so as to be consistent with the \code{augment} generic.
#' @param ... additional arguments to pass on to the respective tidying method
#' 
#' @return A \code{"grouped_df"}, where the non-list columns of the
#' original are used as grouping columns alongside the tidied outputs.
#' 
#' @details Note that this functionality is currently implemented for
#' data.tables, since the result of the do operation is difficult to
#' distinguish from a regular data.table.
#' 
#' @examples
#' 
#' library(dplyr)
#' regressions <- mtcars %>% group_by(cyl) %>% do(mod = lm(mpg ~ wt, .))
#' regressions
#' 
#' regressions %>% tidy(mod)
#' regressions %>% augment(mod)
#' regressions %>% glance(mod)
#' 
#' # we can provide additional arguments to the tidying function
#' regressions %>% tidy(mod, conf.int = TRUE)
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
