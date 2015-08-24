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
    # x is stats::anova
    # there are many possible column names that need to be transformed
    renamers <- c("Df" = "df",
                  "Sum Sq" = "sumsq",
                  "Mean Sq" = "meansq",
                  "F value" = "statistic",
                  "Pr(>F)" = "p.value",
                  "Res.Df" = "res.df",
                  "RSS" = "rss",
                  "Sum of Sq" = "sumsq",
                  "F" = "statistic",
                  "Chisq" = "statistic",
                  "P(>|Chi|)" = "p.value")
    
    names(renamers) <- make.names(names(renamers))
    
    x <- fix_data_frame(x)
    unknown_cols <- setdiff(colnames(x), c("term", names(renamers)))
    if (length(unknown_cols) > 0) {
        warning("The following column names in ANOVA output were not ",
                "recognized or transformed: ",
                paste(unknown_cols, collapse = ", "))
    }
    ret <- plyr::rename(x, renamers, warn_missing = FALSE)
    if (!is.null(ret$term)) {
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

    # ret <- plyr::ldply(x, tidy, .id = "stratum")
    ret <- lapply(x, function(a) tidy(stats::anova(a)))
    ret <- lapply(names(ret), 
                  function(a) dplyr::mutate(ret[[a]], stratum = a))
    ret <- do.call("rbind", ret)
    # get rid of leading and trailing whitespace in term and stratum columns
    ret <- ret %>% mutate(term = stringr::str_trim(term),
                          stratum = stringr::str_trim(stratum))
    ret
}
