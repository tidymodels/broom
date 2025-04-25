#' @templateVar class SpatialPolygonsDataFrame
#' @template title_desc_tidy
#'
#' @description Note that the `sf` package now defines tidy spatial objects
#'   and is the recommended approach to spatial data. `sp` tidiers are now
#'   deprecated in favor of `sf::st_as_sf()` and coercion methods found in
#'   other packages. See
#'   \url{https://r-spatial.org/r/2023/05/15/evolution4.html} for more on
#'   migration from retiring spatial packages.
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
  lifecycle::deprecate_stop(
    when = "1.0.4",
    what = "tidy.SpatialPolygonsDataFrame()",
    details = "Please use functions from the sf package, namely `sf::st_as_sf()`, in favor of sp tidiers."
  )
}

#' @rdname sp_tidiers
#' @export
#' @method tidy SpatialPolygons
tidy.SpatialPolygons <- function(x, ...) {
  lifecycle::deprecate_stop(
    when = "1.0.4",
    what = "tidy.SpatialPolygons()",
    details = "Please use functions from the sf package, namely `sf::st_as_sf()`, in favor of sp tidiers."
  )
}


#' @rdname sp_tidiers
#' @export
#' @method tidy Polygons
tidy.Polygons <- function(x, ...) {
  lifecycle::deprecate_stop(
    when = "1.0.4",
    what = "tidy.Polygons()",
    details = "Please use functions from the sf package, namely `sf::st_as_sf()`, in favor of sp tidiers."
  )
}

#' @rdname sp_tidiers
#' @export
#' @method tidy Polygon
tidy.Polygon <- function(x, ...) {
  lifecycle::deprecate_stop(
    when = "1.0.4",
    what = "tidy.Polygon()",
    details = "Please use functions from the sf package, namely `sf::st_as_sf()`, in favor of sp tidiers."
  )
}

#' @rdname sp_tidiers
#' @export
#' @method tidy SpatialLinesDataFrame
tidy.SpatialLinesDataFrame <- function(x, ...) {
  lifecycle::deprecate_stop(
    when = "1.0.4",
    what = "tidy.SpatialLinesDataFrame()",
    details = "Please use functions from the sf package, namely `sf::st_as_sf()`, in favor of sp tidiers."
  )
}

#' @rdname sp_tidiers
#' @export
#' @method tidy Lines
tidy.Lines <- function(x, ...) {
  lifecycle::deprecate_stop(
    when = "1.0.4",
    what = "tidy.Lines()",
    details = "Please use functions from the sf package, namely `sf::st_as_sf()`, in favor of sp tidiers."
  )
}

#' @rdname sp_tidiers
#' @export
#' @method tidy Line
tidy.Line <- function(x, ...) {
  lifecycle::deprecate_stop(
    when = "1.0.4",
    what = "tidy.Line()",
    details = "Please use functions from the sf package, namely `sf::st_as_sf()`, in favor of sp tidiers."
  )
}
