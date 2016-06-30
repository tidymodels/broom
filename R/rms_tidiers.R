#' @name rms_tidiers
#' @title Tidiers for rms model objects
#' 
#' @param x A model object that inherits class \code{rms}
#' @param conf.int Whether to return the confidence intervals in 
#'   the tidy output
#' @param conf.level The confidence level for the confidence intervals
#' @param exponentiate Whether to exponentiate the estimate and
#'   confidence intervals
#' @param ... Extra arguments, not used
#' 
#' @examples
#' DF <- data.frame(
#'   x1 = runif(200),
#'   x2 = runif(200),
#'   x3 = runif(200),
#'   x4 = runif(200)
#' )
#' DF$y <- DF$x1 + DF$x2 + rnorm(200)
#' 
#' fit <- ols(y ~ rcs(x1,4) + x2 + rcs(x3, 3) + x4, data = DF,
#'            x = TRUE, y = TRUE)
#' 
#' tidy(fit)
#' tidy(anova(fit))
#' glance(fit)
#' 
#' dd <- datadist(DF)
#' options(datadist = 'dd')
#' tidy(summary(fit))
#' tidy(validate(fit))
#' 
#' 
#' #* lrm Example
#' set.seed(17)
#' DF <- data.frame(
#'   age = rnorm(1000, 50, 10),
#'   cholesterol = rnorm(1000, 50, 10)
#' )
#' DF$ch <- Hmisc::cut2(DF$cholesterol, g=40, levels.mean=TRUE)
#' 
#' fit <- lrm(ch ~ age, data = DF, x = TRUE, y = TRUE)
#' tidy(fit)
#' tidy(anova(fit))
#' glance(fit)
#' 
#' dd <- datadist(DF)
#' options(datadist = 'dd')
#' tidy(summary(fit))
#' tidy(validate(fit))
#' 
#' 
#' 
#' #* cph Example
#' n <- 1000
#' set.seed(731)
#' DF <- data.frame(
#'     age = 50 + 12*rnorm(1000),
#'     sex = factor(sample(c('Male','Female'), 1000, 
#'                         rep=TRUE, prob=c(.6, .4))),
#'     cens = 15*runif(1000)
#' )
#' 
#' h <- .02*exp(.04*(DF$age-50)+.8*(DF$sex=='Female'))
#' DF$dt = -log(runif(1000) / h)
#' DF$e <- ifelse(DF$dt <= DF$cens,1,0)
#' DF$dt <- pmin(DF$dt, DF$cens)
#' 
#' fit <- cph(Surv(dt, e) ~ rcs(age,4) + sex, data = DF, 
#'            x=TRUE, y=TRUE, surv = TRUE)
#' tidy(fit)
#' tidy(anova(fit))
#' glance(fit)
#' 
#' dd <- datadist(DF)
#' options(datadist = 'dd')
#' tidy(summary(fit))
#' tidy(validate(fit))
#' 
#' @export

tidy.cph <- function(x, conf.int = FALSE, conf.level = 0.95,
                     exponentiate = FALSE, ...)
{
    res <- data.frame(term = names(x$coef),
                      estimate = x$coef,
                      std.error = sqrt(diag(x$var)),
                      stringsAsFactors = FALSE)
    res$statistic <- res$estimate / res$std.error
    res$p.value <- pnorm(abs(res$statistic), lower.tail = FALSE) * 2
    
    if (conf.int){
        ci <- as.data.frame(confint(x, level = conf.level))
        names(ci) <- c("conf.low", "conf.high")
        
        res <- cbind(res, ci)
    }
    
    if (exponentiate){
        res$estimate <- exp(res$estimate)
        
        if (conf.int){
            res$conf.low <- exp(res$conf.low)
            res$conf.high <- exp(res$conf.high)
        }
    }
    
    rownames(res) <- NULL
    res
}

#' @rdname rms_tidiers
#' @export

tidy.lrm <- function(x, conf.int = FALSE, conf.level = 0.95,
                     exponentiate = FALSE, ...)
{
    res <- data.frame(term = names(x$coef),
                      estimate = x$coef,
                      std.error = sqrt(diag(x$var)),
                      stringsAsFactors = FALSE)
    res$statistic <- res$estimate / res$std.error
    res$p.value <- pnorm(abs(res$statistic), lower.tail = FALSE) * 2
    
    if (conf.int){
        ci <- as.data.frame(confint(x, level = conf.level))
        names(ci) <- c("conf.low", "conf.high")
        
        res <- cbind(res, ci)
    }
    
    if (exponentiate){
        res$estimate <- exp(res$estimate)
        
        if (conf.int){
            res$conf.low <- exp(res$conf.low)
            res$conf.high <- exp(res$conf.high)
        }
    }
    
    rownames(res) <- NULL
    res
}

#' @rdname rms_tidiers
#' @export

tidy.ols <- function(x, conf.int = TRUE, conf.level = TRUE,
                     exponentiate = TRUE, ...)
{
    res <- data.frame(term = names(x$coef),
                      estimate = x$coef,
                      std.error = sqrt(diag(x$var)),
                      stringsAsFactors = FALSE)
    res$statistic <- res$estimate / res$std.error
    res$p.value <- pt(abs(res$statistic), x$stats["n"] - 1, lower.tail = FALSE) * 2
    
    if (conf.int){
        ci <- as.data.frame(confint(x, level = conf.level))
        names(ci) <- c("conf.low", "conf.high")
        
        res <- cbind(res, ci)
    }
    
    if (exponentiate){
        res$estimate <- exp(res$estimate)
        
        if (conf.int){
            res$conf.low <- exp(res$conf.low)
            res$conf.high <- exp(res$conf.high)
        }
    }
    
    rownames(res) <- NULL
    res
}

#' @rdname rms_tidiers
#' @export
tidy.anova.rms <- function(x, ...)
{
    res <- tidy.anova(x)
    res$term <- ifelse(res$term == "Nonlinear",
                       sprintf("%s-%s",
                               dplyr::lag(res$term),
                               res$term),
                       res$term)
    res
}

#' @rdname rms_tidiers
#' @export

tidy.summary.rms <- function(x, ...)
{
    res <- fix_data_frame(x)
    names(res) <- c("term", "low", "high", "diff", "effect",
                    "std.error", "conf.low", "conf.high", "type")
    res$term <- trimws(res$term)
    res$term <- ifelse(res$term %in% c("Odds Ratio", "Hazard Ratio"),
                       sprintf("%s-%s",
                               dplyr::lag(res$term),
                               res$term),
                       res$term)
    res
}

#' @rdname rms_tidiers
#' @export

tidy.validate <- function(x, ...)
{
    res <- fix_data_frame(unclass(x)) 
    names(res)[1] <- ".rowname"
    res
}

#' @rdname rms_tidiers
#' @export

glance.rms <- function(x, ...)
{
    renamers <- c("Brier" = "brier",
                  "C" = "c.index",
                  "d.f." = "df",
                  "Dxy" = "somers.d",
                  "Events" = "events",
                  "g" = "g",
                  "Gamma" = "gamma",
                  "gr" = "gr",
                  "gp" = "gp",
                  "Max Deriv" = "max.deriv",
                  "Model L.R." = "model.lr",
                  "n" = "n",
                  "Obs" = "obs",
                  "P" = "p.value",
                  "R2" = "r.squared",
                  "Score" = "score",
                  "Score P" = "score.p",
                  "Sigma" = "sigma",
                  "Tau-a" = "tau.a")
    
    res <- as.data.frame(matrix(x$stats, nrow = 1))
    names(res) <- renamers[names(x$stats)]
    res
}

