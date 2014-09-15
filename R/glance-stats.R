### glance methods for S3 classes used by the built-in stats package

#' one-row glance of an lm object
#' 
#' Construct a one-row data frame summarizing an lm object.
#' 
#' @param x lm object
#' @param ... extra arguments, not used
#' 
#' @return a one-row data.frame with the columns
#' \itemize{
#' \item{r.squared}{The percent of variance explained by the model}
#' \item{adj.r.squared}{r.squared adjusted based on the degrees of freedom}
#' \item{sigma}{The square root of the estimated residual variance}
#' \item{statistic}{F-statistic}
#' \item{p.value}{p-value from the F test, describing whether the full regression is significant}
#' }
#' 
#' \code{\link{summary.lm}}, which computes the values shown here, and describes them
#' in greater detail
#' 
#' @export
glance.lm <- function(x, ...) {
    s <- summary(x)
    unrowname(with(s, data.frame(r.squared=r.squared,
                       adj.r.squared=adj.r.squared,
                       sigma=sigma,
                       statistic=fstatistic[1],
                       p.value=pf(fstatistic[1], fstatistic[2], fstatistic[3],
                                 lower.tail=FALSE))))
}


#' one-row glance of a glm object
#' 
#' Construct a one-row data frame summarizing a glm object.
#' 
#' @param x glm object
#' @param ... extra arguments, not used
#' 
#' @return a one-row data.frame with the columns
#' \itemize{
#' \item{aic}{The Akaike Information Criterion}
#' \item{deviance}{Minus twice the maximized log-likelihood}
#' \item{null.deviance}{The deviance of the null model}
#' \item{df.residual}{The residual degrees of freedom}
#' \item{df.null}{The residual degrees of freedom for the null model}
#' }
#'
#' @seealso \code{\link{glm}}, which computes the values shown here, and describes them
#' in greater detail.
#'
#' @export
glance.glm <- function(x, ...) {
    s <- summary(x)
    unrowname(as.data.frame(s[c("aic", "deviance", "null.deviance", "df.residual", "df.null")]))
}


#' one-row glance of an nls object
#' 
#' Construct a one-row data frame summarizing an nls object, including
#' the standard deviation of the residuals, and whether it has converged.
#' 
#' @param x nls object
#' @param ... extra arguments, not used
#' 
#' @return a one-row data.frame with the columns
#' \itemize{
#' \item{sigma}{The square root of the estimated residual variance}
#' \item{isConv}{Whether the fit successfully converged}
#' \item{finTol}{The achieved convergence tolerance}
#' }
#' 
#' @seealso \code{\link{nls}} and \code{\link{summary.nls}}
#' 
#' @export
glance.nls <- function(x, ...) {
    s <- summary(x)
    unrowname(data.frame(sigma=s$sigma, isConv=s$convInfo$isConv, finTol=s$convInfo$finTol))
}


#' one-row glance of an htset object
#' 
#' Returns the same output as \code{\link{tidy.htest}} (since it is already one-line long)
#' 
#' @seealso tidy.htest
#' @param x htest object
#' @param ... extra arguments, not used
#' 
#' @seealso \code{\link{tidy.htest}}
#' 
#' @export
glance.htest <- function(x, ...) tidy(x) 



#' one-row glance of a kmeans object
#' 
#' Construct a one-row data frame summarizing a k-means object.
#' 
#' @param x kmeans object
#' @param ... extra arguments, not used
#' 
#' @return a one-row data.frame with the columns
#' \itemize{
#' \item{totss}{The total sum of squares}
#' \item{tot.withinss}{The total within-cluster sum of squares}
#' \item{betweenss}{The total between-cluster sum of squares}
#' \item{iter}{The numbr of (outer) iterations}
#' }
#' 
#' @seealso \code{\link{kmeans}}
#' 
#' @export
glance.kmeans <- function(x, ...) {
    ret <- as.data.frame(x[c("totss", "tot.withinss", "betweenss", "iter")])
    ret
}
