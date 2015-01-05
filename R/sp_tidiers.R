#' tidying methods for classes from the sp package.
#'
#' Tidy classes from the sp package to allow them to be plotted using ggplot2.
#' To figure out the correct variable name for region, inspect
#' \code{as.data.frame(x)}.
#' 
#' These functions originated in the ggplot2 package as "fortify" functions.
#'
#' @param x \code{SpatialPolygonsDataFrame} to convert into a dataframe.
#' @param region name of variable used to split up regions
#' @param ... not used by this method
#' 
#' @name sp_tidiers
#' 
#' @examples
#' if (require("maptools")) {
#'     sids <- system.file("shapes/sids.shp", package="maptools")
#'     nc1 <- readShapePoly(sids,
#'     proj4string = CRS("+proj=longlat +datum=NAD27"))
#'     nc1_df <- tidy(nc1)
#' }
#' 
#' @importFrom plyr ldply
NULL

#' @rdname sp_tidiers
#' @export
#' @method tidy SpatialPolygonsDataFrame
tidy.SpatialPolygonsDataFrame <- function(x, region = NULL, ...) {
    attr <- as.data.frame(x)
    # If not specified, split into regions based on polygons
    if (is.null(region)) {
        coords <- ldply(x@polygons,tidy)
        message("Regions defined for each Polygons")
    } else {
        cp <- sp::polygons(x)

        # Union together all polygons that make up a region
        unioned <- maptools::unionSpatialPolygons(cp, attr[, region])
        coords <- tidy(unioned)
        coords$order <- 1:nrow(coords)
    }
    coords
}

#' @rdname sp_tidiers
#' @export
#' @method tidy SpatialPolygons
tidy.SpatialPolygons <- function(x, ...) {
    ldply(x@polygons, tidy)
}


#' @rdname sp_tidiers 
#' @export
#' @method tidy Polygons
tidy.Polygons <- function(x, ...) {
    subpolys <- x@Polygons
    pieces <- ldply(seq_along(subpolys), function(i) {
        df <- tidy(subpolys[[x@plotOrder[i]]])
        df$piece <- i
        df
    })
    
    within(pieces,{
        order <- 1:nrow(pieces)
        id <- x@ID
        piece <- factor(piece)
        group <- interaction(id, piece)
    })
}

#' @rdname sp_tidiers
#' @export
#' @method tidy Polygon
tidy.Polygon <- function(x, ...) {
    df <- as.data.frame(x@coords)
    names(df) <- c("long", "lat")
    df$order <- 1:nrow(df)
    df$hole <- x@hole
    df
}

#' @rdname sp_tidiers
#' @export
#' @method tidy SpatialLinesDataFrame
tidy.SpatialLinesDataFrame <- function(x, ...) {
    ldply(x@lines, tidy)
}

#' @rdname sp_tidiers
#' @export
#' @method tidy Lines
tidy.Lines <- function(x, ...) {
    lines <- x@Lines
    pieces <- ldply(seq_along(lines), function(i) {
        df <- tidy(lines[[i]])
        df$piece <- i
        df
    })
    
    within(pieces,{
        order <- 1:nrow(pieces)
        id <- x@ID
        piece <- factor(piece)
        group <- interaction(id, piece)
    })
}

#' @rdname sp_tidiers
#' @export
#' @method tidy Line
tidy.Line <- function(x, ...) {
    df <- as.data.frame(x@coords)
    names(df) <- c("long", "lat")
    df$order <- 1:nrow(df)
    df
}
