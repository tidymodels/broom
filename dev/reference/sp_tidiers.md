# Tidy a(n) SpatialPolygonsDataFrame object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

Note that the `sf` package now defines tidy spatial objects and is the
recommended approach to spatial data. `sp` tidiers are now deprecated in
favor of
[`sf::st_as_sf()`](https://r-spatial.github.io/sf/reference/st_as_sf.html)
and coercion methods found in other packages. See
<https://r-spatial.org/r/2023/05/15/evolution4.html> for more on
migration from retiring spatial packages.

## Usage

``` r
# S3 method for class 'SpatialPolygonsDataFrame'
tidy(x, region = NULL, ...)

# S3 method for class 'SpatialPolygons'
tidy(x, ...)

# S3 method for class 'Polygons'
tidy(x, ...)

# S3 method for class 'Polygon'
tidy(x, ...)

# S3 method for class 'SpatialLinesDataFrame'
tidy(x, ...)

# S3 method for class 'Lines'
tidy(x, ...)

# S3 method for class 'Line'
tidy(x, ...)
```

## Arguments

- x:

  A `SpatialPolygonsDataFrame`, `SpatialPolygons`, `Polygons`,
  `Polygon`, `SpatialLinesDataFrame`, `Lines` or `Line` object.

- region:

  name of variable used to split up regions

- ...:

  not used by this method
