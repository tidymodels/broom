#' @templateVar class poLCA
#' @template title_desc_tidy
#' 
#' @param x A `poLCA` object returned from [poLCA::poLCA()].
#' @template param_unused_dots
#'
#' @return A [tibble::tibble] with one row per variable-class-outcome
#'   combination, with columns:
#' 
#'   \item{variable}{Manifest variable}
#'   \item{class}{Latent class ID, an integer}
#'   \item{outcome}{Outcome of manifest variable}
#'   \item{estimate}{Estimated class-conditional response probability}
#'   \item{std.error}{Standard error of estimated probability}
#' 
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
#'   augment(M1)
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
#'   mods <- tibble(nclass = 1:3) %>%
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
#'   td
#'
#'   # show
#'
#'   ggplot(td, aes(outcome, estimate, color = factor(class), group = class)) +
#'     geom_line() +
#'     facet_wrap(~ variable, nrow = 2) +
#'     theme(axis.text.x = element_text(angle = 90, hjust = 1))
#'
#'   au <- augment(nes2a)
#'   au
#'   au %>%
#'     count(.class)
#'
#'   # if the original data is provided, it leads to NAs in new columns
#'   # for rows that weren't predicted
#'   au2 <- augment(nes2a, data = election)
#'   au2
#'   dim(au2)
#' }
#'
#' @aliases poLCA_tidiers
#' @export
#' @seealso [tidy()], [poLCA::poLCA()]
#' @family poLCA tidiers 
#'
tidy.poLCA <- function(x, ...) {
  probs <- purrr::map_df(x$probs, reshape2::melt, .id = "variable") %>%
    transmute(variable,
      class = stringr::str_match(Var1, "class (.*):")[, 2],
      outcome = Var2,
      estimate = value
    )
  if (all(stringr::str_detect(probs$outcome, "^Pr\\(\\d*\\)$"))) {
    probs$outcome <- as.numeric(stringr::str_match(
      probs$outcome,
      "Pr\\((\\d*)\\)"
    )[, 2])
  }

  probs <- probs %>%
    mutate(class = utils::type.convert(class))

  probs_se <- purrr::map_df(x$probs.se, reshape2::melt, .id = "variable")
  probs$std.error <- probs_se$value

  as_tibble(probs)
}

#' @templateVar class poLCA
#' @template title_desc_augment
#' 
#' @inheritParams tidy.poLCA
#' @param data The original dataset used to fit the latent class model, as
#'   a tibble or data. If not given, uses manifest variables in
#' `x$y` and, if applicable, covariates in `x$x`
#'
#' @return A [tibble::tibble] with one row for each original observation,
#'   with additional columns:
#'   
#'   \item{.class}{Predicted class, using modal assignment}
#'   \item{.probability}{Posterior probability of predicted class}
#'
#' If the `data` argument is given, those columns are included in the output
#' (only rows for which predictions could be made).
#' Otherwise, the `y` element of the poLCA object, which contains the
#' manifest variables used to fit the model, are used, along with any covariates,
#' if present, in `x`.
#'
#' Note that while the probability of all the classes (not just the predicted
#' modal class) can be found in the `posterior` element, these are not
#' included in the augmented output.
#'
#' @export
#' @seealso [augment()], [poLCA::poLCA()]
#' @family poLCA tidiers
augment.poLCA <- function(x, data = NULL, ...) {
  indices <- cbind(seq_len(nrow(x$posterior)), x$predclass)
  ret <- tibble(
    .class = x$predclass,
    .probability = x$posterior[indices]
  )

  if (is.null(data)) {
    data <- x$y
    if (!is.null(x$x)) {
      data <- cbind(data, x$x)
    }
  } else {
    if (nrow(data) != nrow(ret)) {
      # rows may have been removed for NAs.
      # For those rows, the new columns get NAs
      ret$.rownames <- rownames(x$y)
      ret <- ret[rownames(data), ]
    }
  }

  as_tibble(cbind(data, ret))
}

#' @templateVar class poLCA
#' @template title_desc_augment
#' 
#' @inheritParams tidy.poLCA
#'
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'   \item{g.squared}{The likelihood ratio/deviance statistic}
#'   \item{chi.squared}{The Pearson Chi-Square goodness of fit statistic
#'     for multiway tables}
#'   \item{df}{Number of parameters estimated, and therefore degrees of
#'     freedom used}
#'   \item{df.residual}{Number of residual degrees of freedom left}
#'
#' @export
#' @seealso [glance()], [poLCA::poLCA()]
#' @family poLCA tidiers
glance.poLCA <- function(x, ...) {
  with(
    x,
    tibble(
      logLik = llik,
      AIC = aic,
      BIC = bic,
      g.squared = Gsq,
      chi.squared = Chisq,
      df = npar,
      df.residual = resid.df
    )
  )
}
