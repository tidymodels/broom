#' Tidying methods for anova and AOV objects
#' 
#' Tidies the result of an analysis of variance into an ANOVA table.
#' Only a \code{tidy} method is provided, not an \code{augment} or
#' \code{glance} method.
#' 
#' @param x An object of class "anova" or "aov"
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
#' @examples
#' 
#' a <- anova(lm(mpg ~ wt + qsec + disp, mtcars))
#' tidy(a)
#' 
#' a <- aov(mpg ~ wt + qsec + disp, mtcars)
#' tidy(a)
#' 
#' @name anova_tidiers
NULL


#' @rdname anova_tidiers
#' @export
tidy.anova <- function(x, ...) {
    nn <- c("df", "sumsq", "meansq", "statistic", "p.value")
    fix_data_frame(x, nn)
}


#' @rdname anova_tidiers
#' @export
tidy.aov <- function(x, ...) {
    nn <- c("df", "sumsq", "meansq", "statistic", "p.value")
    fix_data_frame(summary(x)[[1]], nn)
}
