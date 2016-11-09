#' Tidying methods for a linear model
#' 
#' These methods tidy the factor loadings of a factor analysis, conducted via 
#' \code{\link{factanal}}, into a summary, augment the original data with factor
#' scores, and construct a one-row glance of the model's statistics.
#' 
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#' 
#' @name factanal_tidiers
#' 
#' @param x \code{\link{factanal}} object
#' @param data Original data
#' @param ... Additional arguments, not used
#' 
#' @examples 
#' 
#' mod <- factanal(mtcars, 3, scores = "regression")
#' 
#' glance(mod)
#' tidy(mod)
#' augment(mod)
#' augment(mod, mtcars)  # Must include original data if desired
#' 
#' # Factor loading plot
#' 
#' library(dplyr)
#' library(tidyr)
#' library(ggplot2)
#' 
#' tidy(mod) %>% 
#'     select(-uniqueness) %>% 
#'     gather(factor, loading, -variable) %>% 
#'     mutate(factor = gsub("fl", "", factor),
#'            sign = ifelse(sign(loading) == 1, "b", "a"),
#'            loading = abs(loading)) %>% 
#'     group_by(factor) %>% 
#'     arrange(factor, desc(loading)) %>% 
#'     mutate(order = 1:n()) %>% 
#'     ungroup() %>% 
#'     ggplot(aes(x = factor, y = loading, group = order)) +
#'     geom_bar(aes(fill = sign, alpha = loading),
#'              stat = "identity", position = "dodge", color = "black",
#'              show.legend = FALSE) +
#'     geom_text(aes(label = variable, group = order),
#'               position = position_dodge(width = 0.9),
#'               size = 3.5, angle = 45, hjust = -.4) +
#'     scale_fill_brewer(palette = "Set1") +
#'     theme_bw() +
#'     labs(
#'         x = "Factor",
#'         y = "Loading",
#'         title = "Positive (blue) and negative (red) factor loadings of all variables"
#'     )
NULL

#' @rdname factanal_tidiers
#' 
#' @return \code{tidy.factanal} returns one row for each variable used in the 
#'   analysis and the following columns:
#'   \item{variable}{The variable being estimated in the factor analysis}
#'   \item{uniqueness}{Proportion of residual, or unexplained variance}
#'   \item{flX}{Factor loading of term on factor X. There will be as many columns
#'   of this format as there were factors fitted.}
#' 
#' @export
tidy.factanal <- function(x, ...) {
    # Convert to format that we can work with
    loadings <- stats::loadings(x)
    class(loadings) <- "matrix"
    
    # Place relevant values into a tidy data frame
    tidy_df <- data.frame(variable = rownames(loadings),
                          uniqueness = x$uniquenesses,
                          data.frame(loadings))
    tidy_df$variable <- as.character(tidy_df$variable)
    
    # Remove row names and clean column names
    rownames(tidy_df) <- NULL
    colnames(tidy_df) <- gsub("Factor", "fl", colnames(tidy_df))
    
    tidy_df
}

#' @rdname factanal_tidiers
#' 
#' @return When \code{data} is not supplied \code{augment.factanal} returns one 
#'   row for each observation, with a factor score column added for each factor 
#'   X, (\code{.fsX}). This is because \code{\link{factanal}}, unlike other 
#'   stats methods like \code{\link{lm}}, does not retain the original data.
#' 
#' When \code{data} is supplied, \code{augment.factanal} returns one row for
#' each observation, with a factor score column added for each factor X,
#' (\code{.fsX}).
#' 
#' @export
augment.factanal <- function(x, data, ...) {
    scores <- x$scores
    
    # Check scores were computed
    if (is.null(scores)) {
        stop("Factor scores were not computed. Change the `scores` argument in factanal().")
    }
    
    # Place relevant values into a tidy data frame
    tidy_df <- data.frame(.rowname = rownames(scores),
                          data.frame(scores))
    tidy_df$.rowname <- as.character(tidy_df$.rowname)
    
    # Remove row names and clean column names
    rownames(tidy_df) <- NULL
    colnames(tidy_df) <- gsub("Factor", ".fs", colnames(tidy_df))
    
    # Check if original data provided
    if (missing(data)) {
        return(tidy_df)    
    }
    
    # Bind to data
    data$.rowname <- rownames(data)
    tidy_df <- dplyr::left_join(data, tidy_df, by = ".rowname")
        
    select(tidy_df, contains(".rowname"), everything(), contains(".fs"))
}

#' @rdname factanal_tidiers
#' 
#' @return \code{glance.factanal} returns a one-row data.frame with the columns:
#'   \item{n.factors}{The number of fitted factors}
#'   \item{total.variance}{Total cumulative proportion of variance accounted for by all factors}
#'   \item{statistic}{Significance-test statistic}
#'   \item{p.value}{p-value from the significance test, describing whether the
#'   covariance matrix estimated from the factors is significantly different
#'   from the observed covariance matrix}
#'   \item{df}{Degrees of freedom used by the factor analysis}
#'   \item{n}{Sample size used in the analysis}
#'   \item{method}{The estimation method; always Maximum Likelihood, "mle"}
#'   \item{converged}{Whether the factor analysis converged}
#' 
#' @export
glance.factanal <- function(x, ...) {
    
    # Compute total variance accounted for by all factors
    loadings <- stats::loadings(x)
    class(loadings) <- "matrix"
    total.variance <- sum(apply(loadings, 2, function(i) sum(i^2) / length(i)))
    
    # Results as single-row data frame
    data.frame(
        n.factors = x$factors,
        total.variance = total.variance,
        statistic = unname(x$STATISTIC),
        p.value = unname(x$PVAL),
        df = x$dof,
        n = x$n.obs,
        method = x$method,
        converged = x$converged
    )
}
