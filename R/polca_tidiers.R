#' Tidiers for poLCA objects
#' 
#' Tidiers for poLCA latent class regression models. Summarize the
#' probabilities of each outcome for each variable within each class
#' with \code{tidy}, add predictions to the data with \code{augment},
#' or find the log-likelihood/AIC/BIC with \code{glance}.
#' 
#' @param x A poLCA object
#' @param data For \code{augment}, the original dataset used to fit
#' the latent class model. If not given, uses manifest variables in
#' \code{x$y} and, if applicable, covariates in \code{x$x}
#' @param ... Extra arguments, not used
#' 
#' @name poLCA_tidiers
#' 
#' @template boilerplate
#' 
#' @return \code{tidy} returns a data frame with one row per
#' variable-class-outcome combination, with columns:
#' \describe{
#'   \item{variable}{Manifest variable}
#'   \item{class}{Latent class ID, an integer}
#'   \item{outcome}{Outcome of manifest variable}
#'   \item{estimate}{Estimated class-conditional response probability}
#'   \item{std.error}{Standard error of estimated probability}
#' }
#' 
#' @examples 
#' 
#' if (require("poLCA", quietly = TRUE)) {
#'   library(poLCA)
#'   library(dplyr)
#'   
#'   data(values)
#'   f <- cbind(A, B, C, D)~1
#'   M1 <- poLCA(f, values, nclass = 2, verbose = FALSE)
#'   
#'   M1
#'   tidy(M1)
#'   head(augment(M1))
#'   glance(M1)
#'   
#'   library(ggplot2)
#'   
#'   ggplot(tidy(M1), aes(factor(class), estimate, fill = factor(outcome))) +
#'     geom_bar(stat = "identity", width = 1) +
#'     facet_wrap(~ variable)
#'   
#'   set.seed(2016)
#'   # compare multiple
#'   mods <- data_frame(nclass = 1:3) %>%
#'     group_by(nclass) %>%
#'     do(mod = poLCA(f, values, nclass = .$nclass, verbose = FALSE))
#'   
#'   # compare log-likelihood and/or AIC, BIC
#'   mods %>%
#'     glance(mod)
#'   
#'   ## Three-class model with a single covariate.
#'   
#'   data(election)
#'   f2a <- cbind(MORALG,CARESG,KNOWG,LEADG,DISHONG,INTELG,
#'                MORALB,CARESB,KNOWB,LEADB,DISHONB,INTELB)~PARTY
#'   nes2a <- poLCA(f2a, election, nclass = 3, nrep = 5, verbose = FALSE)
#'   
#'   td <- tidy(nes2a)
#'   head(td)
#'   
#'   # show 
#'   
#'   ggplot(td, aes(outcome, estimate, color = factor(class), group = class)) +
#'     geom_line() +
#'     facet_wrap(~ variable, nrow = 2) +
#'     theme(axis.text.x = element_text(angle = 90, hjust = 1))
#'   
#'   au <- augment(nes2a)
#'   head(au)
#'   au %>%
#'     count(.class)
#'   
#'   # if the original data is provided, it leads to NAs in new columns
#'   # for rows that weren't predicted
#'   au2 <- augment(nes2a, data = election)
#'   head(au2)
#'   dim(au2)
#' }
#' 
#' @export
tidy.poLCA <- function(x, ...) {
    probs <- plyr::ldply(x$probs, reshape2::melt, .id = "variable") %>%
        transmute(variable,
                  class = stringr::str_match(Var1, "class (.*):")[, 2],
                  outcome = Var2,
                  estimate = value)
    if (all(stringr::str_detect(probs$outcome, "^Pr\\(\\d*\\)$"))) {
        probs$outcome <- as.numeric(stringr::str_match(probs$outcome,
                                                       "Pr\\((\\d*)\\)")[, 2])
    }
    
    probs <- probs %>%
        mutate(class = utils::type.convert(class))
    
    probs_se <- plyr::ldply(x$probs.se, reshape2::melt, .id = "variable")
    probs$std.error <- probs_se$value
    
    probs
}


#' @rdname poLCA_tidiers
#' 
#' @return \code{augment} returns a data frame with one row
#' for each original observation, augmented with the following
#' columns:
#' \describe{
#'   \item{.class}{Predicted class, using modal assignment}
#'   \item{.probability}{Posterior probability of predicted class}
#' }
#' 
#' If the \code{data} argument is given, those columns are included in the output
#' (only rows for which predictions could be made).
#' Otherwise, the \code{y} element of the poLCA object, which contains the
#' manifest variables used to fit the model, are used, along with any covariates,
#' if present, in \code{x}.
#' 
#' Note that while the probability of all the classes (not just the predicted
#' modal class) can be found in the \code{posterior} element, these are not
#' included in the augmented output, since it would result in potentially
#' many additional columns, which augment tends to avoid.
#' 
#' @export
augment.poLCA <- function(x, data, ...) {
    indices <- cbind(seq_len(nrow(x$posterior)), x$predclass)
    ret <- data.frame(.class = x$predclass,
                      .probability = x$posterior[indices],
                      stringsAsFactors = FALSE)

    if (missing(data)) {
        data <- x$y
        if (!is.null(x$x)) {
            data <- cbind(data, x$x)
        }
    } else {
        if (nrow(data) != nrow(ret)) {
            # rows may have been removed for NAs.
            # For those rows, the new columns get NAs
            rownames(ret) <- rownames(x$y)
            ret <- ret[rownames(data), ]
        }
    }
    
    ret <- cbind(data, ret)
    
    unrowname(ret)
}


#' @rdname poLCA_tidiers
#' 
#' @return \code{glance} returns a one-row data frame with the
#' following columns:
#' \describe{
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'   \item{g.squared}{The likelihood ratio/deviance statistic}
#'   \item{chi.squared}{The Pearson Chi-Square goodness of fit statistic
#'   for multiway tables}
#'   \item{df}{Number of parameters estimated, and therefore degrees of
#'   freedom used}
#'   \item{df.residual}{Number of residual degrees of freedom left}
#' }
#' 
#' @export
glance.poLCA <- function(x, ...) {
    data.frame(logLik = x$llik, AIC = x$aic, BIC = x$bic,
               g.squared = x$Gsq,
               chi.squared = x$Chisq,
               df = x$npar,
               df.residual = x$resid.df)
}
