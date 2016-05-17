##' Tidying methods for principal components analysis via \code{\link{prcomp}}
##'
##' These tidiers operate on the results of a principal components analysis computed using \code{prcomp}. The \code{tidy} method returns a truly tidy data frame, with a variable indicating the principal omponent and another variable containing the values of all eigenvectors.
##'
##' The \code{glance} method returns the standard deviation, proportion variance explained, or cumulative proportion variance explained for each principal component, depending on the value of argument \code{type}.
##'
##' @param x an object of class \code{"prcomp"} resulting from a call to \code{\link[stats]{prcomp}}
##' @param matrix character; one of \code{"rotation"} or \code{"x"}, or their respective aliases \code{"variables"} and \code{"samples"}. Indicates which sets of eigenvectors are returned in tidy form. The default is \code{c("rotation", "x")}.
##' @param components numeric; a vector of indices selecting which principal components are to be included in the returned object. The default is to return all principal components
##' @param ... extra arguments passed to other methods. Not used in this method.
##'
##' @name prcomp_tidiers
##'
##' @seealso \code{\link{prcomp}}.
##'
##' @return The \code{tidy} method returns a data frame with components
##'
##'   \item{\code{Type}}{ Indicator as to which set of eigenvectors each row relates to.}
##'   \item{\code{Label}}{ A text identifier for each row; the variable names or the sample lables (rownames) of the data set on which PCA was performed.}
##'   \item{\code{PC}}{ An integer vector indicating the principal component}
##'   \item{\code{Value}}{ The value of the eigenvector (axis score) on the indicated principal component.}
##' @author Gavin L. Simpson
##'
##' @export
##'
##' @examples
##'
##' pc <- prcomp(USArrests, scale = TRUE)
##' head(tidy(pc))                      # tidy object
##'
##' pc <- prcomp(~ Murder + Assault + Rape, data = USArrests, scale = TRUE)
##' head(tidy(pc))                      # tidy object
##'
##' glance(pc)                          # default = standard deviations
##' glance(pc, type = "prop")           # proportion variance explained
##'
##' head(augment(pc))                   # no `data` so only fitted values
##' head(augment(pc, data = USArrests)) # augment data with fitted values
`tidy.prcomp` <- function(x, matrix, components, ...) {
    MATRIX <- c("rotation","x","variables","samples")
    if (missing(matrix)) {
        matrix <- c("rotation", "x")
    }
    take <- match(matrix, MATRIX)
    ind <- take > 2
    if (any(ind)) {
        take[ind] <- take[ind] - 2
        take <- unique(take)
    }
    matrix <- MATRIX[take]
    if (!length(matrix) > 1L) {
        stop("'matrix' not recognised")
    }
    ncomp <- NCOL(x$rotation)
    if (missing(components)) {
        components <- seq_len(ncomp)
    } else {
        take <- components %in% seq_len(ncomp)
        if (any(take)) {
            if (!all(take)) {
                warning("Some 'components' invalid; ignoring these!")
            }
            components <- components[take]
        } else {
            stop("No valid components to tidy!")
        }
    }
    ncom <- length(components)
    samples <- variables <- NULL
    if ("rotation" %in% matrix) {
        labels <- rownames(x$rotation)
        variables <- tidyr::gather(as.data.frame(x$rotation[, components,
                                                            drop = FALSE]))
        variables <- cbind(Type = rep("Variables", NROW(variables)),
                           Label = rep(labels, times = ncomp),
                           variables)
    }
    if ("x" %in% matrix) {
        labels <- rownames(x$x)
        samples <- tidyr::gather(as.data.frame(x$x[, components,
                                                   drop = FALSE]))
        samples <- cbind(Type = rep("Samples", NROW(samples)),
                         Label = rep(labels, times = ncomp),
                         samples)
    }
    ret <- if (!(is.null(samples) && is.null(variables))) {
        rbind(variables, samples)
    } else if (!is.null(samples)) {
        samples
    } else {
        variables
    }
    names(ret) <- c("Type","Label", "PC","Value")
    ## change the PC to a numeric
    ret <- transform(ret, PC = as.numeric(sub("PC", "", PC)))
    ret
}

##' @rdname prcomp_tidiers
##'
##' @param type character; which type of summary statistic to return. One of \code{"sdev"}, \code{"proportion"}, or \code{"cumulative"}. May be abbreviated.
##' @export
##'
##' @return The \code{glance.prcomp} method returns a one-row data frame with as many columns as extracted principal components. The values in the data frame are either the standard deviations (square roots) of the eigenvalues (\code{type = "sdev"}), or the proportion (\code{type = "proportion"}) or cumulative proportion (\code{type = "cumulative"}) variance explained by each principal component.
`glance.prcomp` <- function(x, type = c("sdev", "proportion", "cumulative"), ...) {
    type <- match.arg(type)
    summ <- as.data.frame(summary(x)$importance)
    ret <- switch(type,
                  "sdev"       = summ[1, , drop = FALSE],
                  "proportion" = summ[2, , drop = FALSE],
                  "cumulative" = summ[3, , drop = FALSE])
    ret <- unrowname(ret)
    ret
}

##' @rdname prcomp_tidiers
##'
##' @param data the original data on which principal components analysis was performed. This cannot be recovered from \code{x}. If \code{newdata} is supplied, \code{data} is ignored. If both \code{data} and \code{newdata} are missing, only the fitted locations on the principal components are returned.
##' @param newdata data frame; new observations for which locations on principal components are sought.
##'
##' @return The \code{augment.prcomp} method returns a data frame containing fitted locations on the principal components for the observed data plus either the original data or the new data if supplied via \code{data} or \code{newdata} respectively.
##'
##' @export
`augment.prcomp` <- function(x, data = NULL, newdata, ...) {
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
