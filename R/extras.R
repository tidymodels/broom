# this contains functions that are useful to use with broom, but are not
# actually involved in tidying objects.

#' Set up bootstrap replicates of a dplyr operation
#'
#' @param df a data frame
#' @param m number of bootstrap replicates to perform
#'
#' @details This code originates from Hadley Wickham (with a few small
#' corrections) here:
#'
#' https://github.com/hadley/dplyr/issues/269
#'
#' Some examples can be found at
#'
#' https://github.com/dgrtwo/broom/blob/master/vignettes/bootstrapping.Rmd
#'
#' @examples
#'
#' library(dplyr)
#' mtcars %>% bootstrap(10) %>% do(tidy(lm(mpg ~ wt, .)))
#' 
#' @export
bootstrap <- function(df, m) {
    n <- nrow(df)
    
    attr(df, "indices") <- replicate(m, sample(n, replace = TRUE) - 1,
                                     simplify = FALSE)
    attr(df, "drop") <- TRUE
    attr(df, "group_sizes") <- rep(n, m)
    attr(df, "biggest_group_size") <- n
    attr(df, "labels") <- data.frame(replicate = 1:m)
    attr(df, "vars") <- list(quote(replicate))
    class(df) <- c("grouped_df", "tbl_df", "tbl", "data.frame")
    
    df
}


#' Copy tidy data to clipboard
#'
#' @param df a data.frame, atmoic vector, or matrix
#' @param sep a character vector of length 1 indicating how the pasted columns
#' are separated, defaults to a tab character
#' 
#' @details This function copies df to the clipboard, for easy pasting into 
#' word processors and spreadsheets (e.g., MS Excel). 
#'
#' @examples
#' 
#' library(magrittr)
#' mtcars %>% 
#' lm(qsec ~ cyl + wt + hp, data = .) %>%
#' tidy %>%
#' copyData
#' 
#'
#' @export

copyData <- function(df, sep = "\t"){
  label <- deparse(substitute(df))
  sep   <- as.character(sep)
  
  if(!(is.data.frame(df) | is.matrix(df) | is.vector(df))){
    stop("'", label, "' should be a dataframe, matrix, or atomic vector",
         call. = FALSE)
  }
  
  rbind(names(df), df) %>%
  apply(1, paste0, collapse = sep)%>%
  writeClipboard

}
