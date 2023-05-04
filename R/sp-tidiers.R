#' @templateVar class SpatialPolygonsDataFrame
#' @template title_desc_tidy
#'
#' @description Note that the `sf` package now defines tidy spatial objects
#'   and is the recommended approach to spatial data. `sp` tidiers are now
#'   soft-deprecated in favor of `sf::st_as_sf()`, and will soon be removed
#'   from the package. Development of `sp` tidiers has halted in `broom`.
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
  lifecycle::deprecate_warn(
    when = "1.0.4",
    what = "tidy.SpatialPolygonsDataFrame()",
    details = "Please use functions from the sf package, namely `sf::st_as_sf()`, in favor of sp tidiers.",
    id = "sp"
  )
  
  attr <- as.data.frame(x)
  # If not specified, split into regions based on polygons
  if (is.null(region)) {
    
    coords <- map_df(x@polygons, tidy)
    message("Regions defined for each Polygons")
  } else {
    lifecycle::deprecate_stop(
      when = "1.0.5",
      what = "tidy.SpatialPolygonsDataFrame(region)"
    )
  }
  as_tibble(coords)
}

#' @rdname sp_tidiers
#' @export
#' @method tidy SpatialPolygons
tidy.SpatialPolygons <- function(x, ...) {
  lifecycle::deprecate_warn(
    when = "1.0.4",
    what = "tidy.SpatialPolygons()",
    details = "Please use functions from the sf package, namely `sf::st_as_sf()`, in favor of sp tidiers.",
    id = "sp"
  )
  
  map_df(x@polygons, tidy)
}


#' @rdname sp_tidiers
#' @export
#' @method tidy Polygons
tidy.Polygons <- function(x, ...) {
  lifecycle::deprecate_warn(
    when = "1.0.4",
    what = "tidy.Polygons()",
    details = "Please use functions from the sf package, namely `sf::st_as_sf()`, in favor of sp tidiers.",
    id = "sp"
  )
  
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
  lifecycle::deprecate_warn(
    when = "1.0.4",
    what = "tidy.Polygon()",
    details = "Please use functions from the sf package, namely `sf::st_as_sf()`, in favor of sp tidiers.",
    id = "sp"
  )
  
  sp::coordnames(x) <- c("long", "lat")
  df <- as_tibble(x@coords)
  df$order <- 1:nrow(df)
  df$hole <- x@hole
  df
}

#' @rdname sp_tidiers
#' @export
#' @method tidy SpatialLinesDataFrame
tidy.SpatialLinesDataFrame <- function(x, ...) {
  lifecycle::deprecate_warn(
    when = "1.0.4",
    what = "tidy.SpatialLinesDataFrame()",
    details = "Please use functions from the sf package, namely `sf::st_as_sf()`, in favor of sp tidiers.",
    id = "sp"
  )
  
  map_df(x@lines, tidy)
}

#' @rdname sp_tidiers
#' @export
#' @method tidy Lines
tidy.Lines <- function(x, ...) {
  lifecycle::deprecate_warn(
    when = "1.0.4",
    what = "tidy.Lines()",
    details = "Please use functions from the sf package, namely `sf::st_as_sf()`, in favor of sp tidiers.",
    id = "sp"
  )
  
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
  lifecycle::deprecate_warn(
    when = "1.0.4",
    what = "tidy.Line()",
    details = "Please use functions from the sf package, namely `sf::st_as_sf()`, in favor of sp tidiers.",
    id = "sp"
  )
  
  sp::coordnames(x) <- c("long", "lat")
  df <- as_tibble(x@coords)
  df$order <- 1:nrow(df)
  unrowname(df)
}
