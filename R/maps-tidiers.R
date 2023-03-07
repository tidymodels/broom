#' @templateVar class map
#' @template title_desc_tidy
#'
#' @param x A `map` object returned from [maps::map()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "term",
#'   long = "Longitude.",
#'   lat = "Latitude.",
#'   .post = "Remaining columns give information on geographic attributes
#'     and depend on the inputted map object. See ?maps::map for more information."
#' )
#'
#' @examplesIf rlang::is_installed(c("maps", "ggplot2"))
#'
#' # load libraries for models and data
#' library(maps)
#' library(ggplot2)
#'
#' ca <- map("county", "ca", plot = FALSE, fill = TRUE)
#'
#' tidy(ca)
#'
#' qplot(long, lat, data = ca, geom = "polygon", group = group)
#'
#' tx <- map("county", "texas", plot = FALSE, fill = TRUE)
#' tidy(tx)
#' qplot(long, lat,
#'   data = tx, geom = "polygon", group = group,
#'   colour = I("white")
#' )
#'
#' @export
#' @seealso [tidy()], [maps::map()]
#' @aliases maps_tidiers
tidy.map <- function(x, ...) {
  df <- as.data.frame(x[c("x", "y")])
  names(df) <- c("long", "lat")
  df$group <- cumsum(is.na(df$long) & is.na(df$lat)) + 1
  df$order <- 1:nrow(df)

  names <- do.call("rbind", lapply(strsplit(x$names, "[:,]"), "[", 1:2))
  df$region <- names[df$group, 1]
  df$subregion <- names[df$group, 2]
  as_tidy_tibble(df[stats::complete.cases(df$lat, df$long), ])
}
