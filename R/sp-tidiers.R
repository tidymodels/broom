#' @templateVar class SpatialPolygonsDataFrame
#' @template title_desc_tidy
#' 
#' @description Note that the `sf` package now defines tidy spatial objects
#'   and is the recommend approach to spatial data. `sp` tidiers are likely
#'   to be deprecated in the near future in favor of `sf::st_as_sf()`.
#'   Development of `sp` tidiers has halted in `broom`.
#' 
#' @param x A `SpatialPolygonsDataFrame`, `SpatialPolygons`, `Polygons`,
#'   `Polygon`, `SpatialLinesDataFrame`, `Lines` or `Line` object.
#' @param region name of variable used to split up regions
#' @param ... not used by this method
#'
#' @name sp_tidiers
#' 
NULL

#' @rdname sp_tidiers
#' @export
#' @method tidy SpatialPolygonsDataFrame
tidy.SpatialPolygonsDataFrame <- function(x, region = NULL, ...) {
  attr <- as.data.frame(x)
  # If not specified, split into regions based on polygons
  if (is.null(region)) {
    coords <- map_df(x@polygons, tidy)
    message("Regions defined for each Polygons")
  } else {
    cp <- sp::polygons(x)

    # Union together all polygons that make up a region
    unioned <- maptools::unionSpatialPolygons(cp, attr[, region])
    coords <- tidy(unioned)
    coords$order <- 1:nrow(coords)
  }
  as_tibble(coords)
}

#' @rdname sp_tidiers
#' @export
#' @method tidy SpatialPolygons
tidy.SpatialPolygons <- function(x, ...) {
  map_df(x@polygons, tidy)
}


#' @rdname sp_tidiers
#' @export
#' @method tidy Polygons
tidy.Polygons <- function(x, ...) {
  subpolys <- x@Polygons
  pieces <- map_df(seq_along(subpolys), function(i) {
    df <- tidy(subpolys[[x@plotOrder[i]]])
    df$piece <- i
    df
  })

  within(pieces, {
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
  df <- as_tibble(x@coords)
  names(df) <- c("long", "lat")
  df$order <- 1:nrow(df)
  df$hole <- x@hole
  df
}

#' @rdname sp_tidiers
#' @export
#' @method tidy SpatialLinesDataFrame
tidy.SpatialLinesDataFrame <- function(x, ...) {
  map_df(x@lines, tidy)
}

#' @rdname sp_tidiers
#' @export
#' @method tidy Lines
tidy.Lines <- function(x, ...) {
  lines <- x@Lines
  pieces <- map_df(seq_along(lines), function(i) {
    df <- tidy(lines[[i]])
    df$piece <- i
    df
  })

  within(pieces, {
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
  df <- as_tibble(x@coords)
  names(df) <- c("long", "lat")
  df$order <- 1:nrow(df)
  unrowname(df)
}
