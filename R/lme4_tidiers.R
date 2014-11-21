#' Tidying methods for mixed effects models
#' 
#' These methods tidy the coefficients of mixed effects models, particularly
#' responses of the \code{merMod} class.
#' 
#' @param x An object of class \code{merMod}, such as those from \code{lmer},
#' \code{glmer}, or \code{nlmer}
#' 
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#' 
#' @name lme4_tidiers
#' 
#' @examples
#' 
#' if (require("lme4")) {
#'     # example regressions are from lme4 documentation
#'     lmm1 <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
#'     tidy(lmm1)
#'     tidy(lmm1, effects = "fixed")
#'     head(augment(lmm1, sleepstudy))
#'     glance(lmm1)
#'     
#'     glmm1 <- glmer(cbind(incidence, size - incidence) ~ period + (1 | herd),
#'                   data = cbpp, family = binomial)
#'     tidy(glmm1)
#'     tidy(glmm1, effects = "fixed")
#'     head(augment(glmm1, cbpp))
#'     glance(glmm1)
#'     
#'     startvec <- c(Asym = 200, xmid = 725, scal = 350)
#'     nm1 <- nlmer(circumference ~ SSlogis(age, Asym, xmid, scal) ~ Asym|Tree,
#'                   Orange, start = startvec)
#'     tidy(nm1)
#'     tidy(nm1, effects = "fixed")
#'     head(augment(nm1, Orange))
#'     glance(nm1)
#' }
NULL


#' @rdname lme4_tidiers
#' 
#' @param effects Either "random" (default) or "fixed"
#' 
#' @return \code{tidy} returns one row for each estimated effect, either
#' random or fixed depending on the \code{effects} parameter. If
#' \code{effects = "random"}, it contains the columns
#'   \item{group}{the group within which the random effect is being estimated}
#'   \item{level}{level within group}
#'   \item{term}{term being estimated}
#'   \item{estimate}{estimated coefficient}
#' 
#' If \code{effects="fixed"}, \code{tidy} returns the columns
#'   \item{term}{gixed term being estimated}
#'   \item{estimate}{estimate of fixed effect}
#'   \item{std.error}{standard error}
#'   \item{statistic}{t-statistic}
#'   \item{p.value}{P-value computed from t-statistic (depending on the model,
#'   this may or may not be calculated and included)}
#' 
#' @importFrom plyr ldply
#' @import dplyr
#' 
#' @export
tidy.merMod <- function(x, effects = "random", ...) {
    effects <- match.arg(effects, c("random", "fixed"))
    if (effects == "fixed") {
        # return tidied fixed effects rather than random
        ret <- coef(summary(x))

        # p-values may or may not be included
        nn <- c("estimate", "std.error", "statistic", "p.value")[1:ncol(ret)]
        return(fix_data_frame(ret, newnames = nn, newcol = "term"))
    }

    # fix each group to be a tidy data frame
    fix <- function(g) {
        newg <- fix_data_frame(g, newnames = colnames(g), newcol = "level")
        # fix_data_frame doesn't create a new column if rownames are numeric,
        # which doesn't suit our purposes
        newg$level <- rownames(g)
        newg
    }

    # combine them and gather terms
    ret <- ldply(coef(x), fix) %>%
        tidyr::gather(term, estimate, -.id, -level)
    colnames(ret)[1] <- "group"
    ret
}



#' @rdname lme4_tidiers
#' 
#' @param data original data this was fitted on; if not given this will
#' attempt to be reconstructed
#' @param newdata new data to be used for prediction; optional
#' 
#' @template augment_NAs
#' 
#' @return \code{augment} returns one row for each original observation,
#' with columns (each prepended by a .) added. Included are the columns
#'   \item{.fitted}{predicted values}
#'   \item{.resid}{residuals}
#'   \item{.fixed}{predicted values with no random effects}
#' 
#' Also added are values from the response object within the model (of type
#' \code{lmResp}, \code{glmResp}, \code{nlsResp}, etc). These include \code{".mu",
#' ".offset", ".sqrtXwt", ".sqrtrwt", ".eta"}.
#'
#' @export
augment.merMod <- function(x, data = model.frame(x), newdata, ...) {    
    # move rownames if necessary
    if (missing(newdata)) {
        newdata <- NULL
    }
    ret <- augment_columns(x, data, newdata, se.fit = NULL)
    
    # add predictions with no random effects (population means)
    predictions <- predict(x, re.form = NA)
    # some cases, such as values returned from nlmer, return more than one
    # prediction per observation. Not clear how those cases would be tidied
    if (length(predictions) == nrow(ret)) {
        ret$.fixed <- predictions
    }

    # columns to extract from resp reference object
    # these include relevant ones that could be present in lmResp, glmResp,
    # or nlsResp objects

    respCols <- c("mu", "offset", "sqrtXwt", "sqrtrwt", "weights", "wtres", "gam", "eta")
    cols <- lapply(respCols, function(n) x@resp[[n]])
    names(cols) <- paste0(".", respCols)
    cols <- as.data.frame(compact(cols))  # remove missing fields
    
    cols <- insert_NAs(cols, ret)
    if (length(cols) > 0) {
        ret <- cbind(ret, cols)
    }

    unrowname(ret)
}


#' @rdname lme4_tidiers
#' 
#' @param ... extra arguments (not used)
#' 
#' @return \code{glance} returns one row with the columns
#'   \item{sigma}{the square root of the estimated residual variance}
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'   \item{deviance}{deviance}
#'   \item{df.residual}{residual degrees of freedom}
#' 
#' @export
glance.merMod <- function(x, ...) {
    ret <- unrowname(data.frame(sigma=lme4::sigma(x)))
    finish_glance(ret, x)
}
