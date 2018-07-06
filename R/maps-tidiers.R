#' @templateVar class map
#' @template title_desc_tidy
#'
#' @param x A `map` object returned from [maps::map()].
#' @template param_unused_dots
#'
#' @examples
#' 
#' if (require("maps") && require("ggplot2")) {
#'     
#'     library(maps)
#'     library(ggplot2)
#' 
#'     ca <- map("county", "ca", plot = FALSE, fill = TRUE)
#'     tidy(ca)
#'     qplot(long, lat, data = ca, geom = "polygon", group = group)
#'
#'     tx <- map("county", "texas", plot = FALSE, fill = TRUE)
#'     tidy(tx)
#'     qplot(long, lat, data = tx, geom = "polygon", group = group,
#'           colour = I("white"))
#' }
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
  fix_data_frame(df[stats::complete.cases(df$lat, df$long), ])
}
