#' Tidying methods for principal components analysis via [prcomp()]
#'
#' These tidiers operate on the results of a principal components analysis
#' computed using `prcomp`. The `tidy` method returns a data frame
#' with either the eigenvectors representing each row or each column.
#'
#' @param x an object of class `"prcomp"` resulting from a call to
#' [stats::prcomp()]
#' @param matrix character; Indicates which sets of eigenvectors are returned
#' in tidy form. "v", "rotation", or "variables" will return information about
#' each variable, while "u", "x", or "samples" (default) returns the loadings
#' for each original row. "d" or "pcs" returns information about each
#' principal component.
#'
#' @name prcomp_tidiers
#'
#' @seealso [prcomp()], \link{svd_tidiers}
#'
#' @template boilerplate
#'
#' @return If `matrix` is "u", "samples", or "x", the `tidy` method
#' returns
#' \describe{
#'    \item{`row`}{The sample labels (rownames) of the data set on
#'   which PCA was performed}
#'   \item{`PC`}{An integer vector indicating the principal component}
#'   \item{`value`}{The value of the eigenvector (axis score) on the
#'   indicated principal component}
#' }
#'
#' If `matrix` is "v", "variables", or "rotation", the `tidy` method
#' returns
#' \describe{
#'    \item{`row`}{The variable labels (colnames) of the data set on
#'   which PCA was performed}
#'   \item{`PC`}{An integer vector indicating the principal component}
#'   \item{`value`}{The value of the eigenvector (axis score) on the
#'   indicated principal component}
#' }
#'
#' If `matrix` is "d" or "pcs", the `tidy` method returns
#' \describe{
#'   \item{`PC`}{An integer vector indicating the principal component}
#'   \item{`std.dev`}{Standard deviation explained by this PC}
#'   \item{`percent`}{Percentage of variation explained}
#'   \item{`cumulative`}{Cumulative percentage of variation explained}
#' }
#'
#' @author Gavin L. Simpson
#'
#' @examples
#'
#' pc <- prcomp(USArrests, scale = TRUE)
#'
#' # information about rotation
#' head(tidy(pc))
#'
#' # information about samples (states)
#' head(tidy(pc, "samples"))
#'
#' # information about PCs
#' tidy(pc, "pcs")
#'
#' # state map
#' library(dplyr)
#' library(ggplot2)
#'
#' pc %>%
#'   tidy(matrix = "samples") %>%
#'   mutate(region = tolower(row)) %>%
#'   inner_join(map_data("state"), by = "region") %>%
#'   ggplot(aes(long, lat, group = group, fill = value)) +
#'   geom_polygon() +
#'   facet_wrap(~ PC) +
#'   theme_void() +
#'   ggtitle("Principal components of arrest data")
#'
#' au <- augment(pc, data = USArrests)
#' head(au)
#'
#' ggplot(au, aes(.fittedPC1, .fittedPC2)) +
#'   geom_point() +
#'   geom_text(aes(label = .rownames), vjust = 1, hjust = 1)
#'
#' @export
tidy.prcomp <- function(x, matrix = "u", ...) {
  if (length(matrix) > 1) {
    stop("Tidying multiple matrices not supported")
  }

  MATRIX <- c("rotation", "x", "variables", "samples", "v", "u", "pcs", "d")
  matrix <- match.arg(matrix, MATRIX)

  ncomp <- NCOL(x$rotation)
  if (matrix %in% c("pcs", "d")) {
    nn <- c("std.dev", "percent", "cumulative")
    ret <- fix_data_frame(t(summary(x)$importance),
      newnames = nn,
      newcol = "PC"
    )
  } else if (matrix %in% c("rotation", "variables", "v")) {
    labels <- if (is.null(rownames(x$rotation))) {
      1:nrow(x$rotation)
    } else {
      rownames(x$rotation)
    }
    variables <- tidyr::gather(as.data.frame(x$rotation))
    ret <- data.frame(
      label = rep(labels, times = ncomp),
      variables,
      stringsAsFactors = FALSE
    )
    names(ret) <- c("column", "PC", "value")
  } else if (matrix %in% c("x", "samples", "u")) {
    labels <- if (is.null(rownames(x$x))) 1:nrow(x$x) else rownames(x$x)
    samples <- tidyr::gather(as.data.frame(x$x))
    ret <- data.frame(
      label = rep(labels, times = ncomp),
      samples
    )
    names(ret) <- c("row", "PC", "value")
  }

  ## change the PC to a numeric
  ret <- mutate(ret, PC = as.numeric(stringr::str_replace(PC, "PC", "")))
  ret
}


#' @rdname prcomp_tidiers
#'
#' @param data the original data on which principal components analysis
#' was performed. This cannot be recovered from `x`. If `newdata`
#' is supplied, `data` is ignored. If both `data` and `newdata`
#' are missing, only the fitted locations on the principal components are
#' returned.
#' @param newdata data frame; new observations for which locations on principal
#' components are sought.
#' @param ... Extra arguments, not used
#'
#' @return The `augment.prcomp` method returns a data frame containing
#' fitted locations on the principal components for the observed data plus
#' either the original data or the new data if supplied via `data` or
#' `newdata` respectively.
#'
#' @export
augment.prcomp <- function(x, data = NULL, newdata, ...) {
  ret <- if (!missing(newdata)) {
    ret <- data.frame(.rownames = rownames(newdata))
    pred <- as.data.frame(predict(x, newdata = newdata))
    names(pred) <- paste0(".fitted", names(pred))
    cbind(ret, newdata, pred)
  } else {
    pred <- as.data.frame(predict(x))
    names(pred) <- paste0(".fitted", names(pred))
    if (!missing(data) && !is.null(data)) {
      cbind(.rownames = rownames(data), data, pred)
    } else {
      data.frame(.rownames = rownames(x$x), pred)
    }
  }
  ret <- unrowname(ret)
  ret
}
