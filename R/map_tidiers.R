#' Tidy method for map objects.
#'
#' This function turns a map into a data frame.
#' 
#' This code and documentation originated in ggplot2, but was called "fortify."
#' In broom, "fortify" became "augment", which is reserved for functions that *add*
#' columns to existing data (based on a model fit, for example) so these functions
#' were renamed as "tidy."
#'
#' @param x map object
#' @param ... not used by this method
#' 
#' @examples
#' if (require("maps") && require("ggplot2")) {
#'     ca <- map("county", "ca", plot = FALSE, fill = TRUE)
#'     head(tidy(ca))
#'     qplot(long, lat, data = ca, geom = "polygon", group = group)
#'
#'     tx <- map("county", "texas", plot = FALSE, fill = TRUE)
#'     head(tidy(tx))
#'     qplot(long, lat, data = tx, geom = "polygon", group = group,
#'           colour = I("white"))
#' }
#' 
#' @export
tidy.map <- function(x, ...) {
    df <- as.data.frame(x[c("x", "y")])
    names(df) <- c("long", "lat")
    df$group <- cumsum(is.na(df$long) & is.na(df$lat)) + 1
    df$order <- 1:nrow(df)
    
    names <- do.call("rbind", lapply(strsplit(x$names, "[:,]"), "[", 1:2))
    df$region <- names[df$group, 1]
    df$subregion <- names[df$group, 2]
    df[complete.cases(df$lat, df$long), ]
}
