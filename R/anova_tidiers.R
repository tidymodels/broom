#' Tidying methods for anova and AOV objects
#' 
#' Tidies the result of an analysis of variance into an ANOVA table.
#' Only a \code{tidy} method is provided, not an \code{augment} or
#' \code{glance} method.
#' 
#' @param x An object of class "anova", "aov", or "aovlist"
#' @param ... extra arguments (not used)
#' 
#' @return A data.frame with columns
#'   \item{term}{Term within the model, or "Residuals"}
#'   \item{df}{Degrees of freedom used by this term in the model}
#'   \item{sumsq}{Sum of squares explained by this term}
#'   \item{meansq}{Mean of sum of squares among degrees of freedom}
#'   \item{statistic}{F statistic}
#'   \item{p.value}{P-value from F test}
#'
#' In the case of an \code{"aovlist"} object, there is also a \code{stratum}
#' column describing the error stratum
#' 
#' @details Note that the "term" column of an ANOVA table can come with
#' leading or trailing whitespace, which this tidying method trims.
#' 
#' @examples
#' 
#' a <- anova(lm(mpg ~ wt + qsec + disp, mtcars))
#' tidy(a)
#' 
#' a <- aov(mpg ~ wt + qsec + disp, mtcars)
#' tidy(a)
#' 
#' al <- aov(mpg ~ wt + qsec + Error(disp / am), mtcars)
#' tidy(al)
#' 
#' @name anova_tidiers
NULL


#' @rdname anova_tidiers
#' 
#' @import dplyr
#' 
#' @export
tidy.anova <- function(x, ...) {
    nn <- c("df", "sumsq", "meansq", "statistic", "p.value")
    ret <- fix_data_frame(x, nn[1:ncol(x)])

    if ("term" %in% colnames(ret)) {
        # if rows had names, strip whitespace in them
        ret <- ret %>% mutate(term = stringr::str_trim(term))
    }
    ret
}


#' @rdname anova_tidiers
#' 
#' @import dplyr
#' 
#' @export
tidy.aov <- function(x, ...) {
    s <- summary(x)
    tidy.anova(s[[1]])
}


#' @rdname anova_tidiers
#' @export
tidy.aovlist <- function(x, ...) {
    # must filter out Intercept stratum since it has no dimensions
    if (names(x)[1L] == "(Intercept)") {
        x <- x[-1L]
    }

    ret <- plyr::ldply(x, tidy, .id = "stratum")
    # get rid of leading and trailing whitespace in term and stratum columns
    ret <- ret %>% mutate(term = stringr::str_trim(term),
                          stratum = stringr::str_trim(stratum))
    ret
}
