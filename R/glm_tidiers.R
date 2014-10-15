#' Tidying methods for a glm object
#' 
#' Tidy a \code{glm} object. The \code{tidy} and \code{augment} methods are handled
#' by \code{\link{lm_tidiers}}.
#' 
#' @param x glm object
#' @param ... extra arguments, not used
#' 
#' @return \code{tidy} and \code{augment} return the same values as do
#' \code{\link{tidy.lm}} and \code{\link{augment.lm}}.
#'
#' @seealso \code{\link{tidy.lm}} and \code{\link{augment.lm}}. Also \code{\link{glm}}, which
#' computes the values reported by the \code{glance} method.
#'
#' @name glm_tidiers
#' 
#' @examples
#' 
#' g <- glm(am ~ mpg, mtcars, family = "binomial")
#' glance(g)
#'
#' @export


#' @rdname glm_tidiers
#' 
#' @return \code{glance} returns a one-row data.frame with the columns
#'   \item{null.deviance}{the deviance of the null model}
#'   \item{df.null}{the residual degrees of freedom for the null model}
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'   \item{deviance}{deviance}
#'   \item{df.residual}{residual degrees of freedom}
glance.glm <- function(x, ...) {
    s <- summary(x)
    ret <- unrowname(as.data.frame(s[c("null.deviance", "df.null")]))
    finish_glance(ret, x)
}

#' @rdname glm_tidiers
#' 
#' 
#' @details Code and documentation for \code{augment.glm} originated in the
#' ggplot2 package, where it was called \code{fortify.lm}
#' 
#' @return When \code{newdata} is not supplied \code{augment.glm} returns one row for each observation,
#' with nine columns added to the original data:
#'   \item{.hat}{Diagonal of the hat matrix}
#'   \item{.sigma}{Estimate of residual standard deviation when
#'     corresponding observation is dropped from model}
#'   \item{.cooksd}{Cooks distance, \code{\link{cooks.distance}}}
#'   \item{.fitted.link}{Fitted values of model}
#'   \item{.se.fit.link}{Standard errors of fitted values}
#'   \item{.fitted.response}{Fitted values of model}
#'   \item{.se.fit.response}{Standard errors of fitted values}
#'   \item{.resid}{Residuals}
#'   \item{.stdresid}{Standardised residuals}
#' When \code{newdata} is supplied  \code{augment.glm} returns one row for each observation,
#' with two columns added to the new data:
#'   \item{.fitted.link}{Fitted values of model}
#'   \item{.se.fit.link}{Standard errors of fitted values}
#'   \item{.fitted.response}{Fitted values of model}
#'   \item{.se.fit.response}{Standard errors of fitted values}
#'   
#' @export
augment.glm <- function(x, data = x$model, newdata= NULL, ...) {
  # move rownames if necessary
  # here we need rownames to match the observations in the case of missing data (!)
  if (is.null(newdata)) {
    data$.rownames <- rownames(data) 
    
    infl <- influence(x, do.coef = FALSE)
    infl <- as.data.frame(infl)
    infl$.rownames <- rownames(infl)
    
    infl <- select(infl, .hat=hat, .sigma=sigma, .rownames)
    
    infl$.resid <- resid(x)
    
    prediction <- predict(x, se.fit=TRUE, type = "link")
    infl$.fitted.link <- prediction$fit
    infl$.se.fit.link <- prediction$se.fit
    prediction <- predict(x, se.fit=TRUE, type = "response")
    infl$.fitted.response <- prediction$fit
    infl$.se.fit.response <- prediction$se.fit
    
    
    infl$.cooksd <- cooks.distance(x)
    infl$.stdresid <- rstandard(x)
    
    data <- merge(data, infl, by=".rownames", all.x=TRUE)    
    return(data)
  } else {
    prediction <- predict(x, newdata, se.fit=TRUE, type = "link")
    newdata$.fitted.link <- prediction$fit
    newdata$.se.fit.link <- prediction$se.fit
    prediction <- predict(x, newdata, se.fit=TRUE, type = "response")
    newdata$.fitted.response <- prediction$fit
    newdata$.se.fit.response <- prediction$se.fit
    return(newdata)
  }
}


