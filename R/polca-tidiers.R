#' @templateVar class poLCA
#' @template title_desc_tidy
#' 
#' @param x A `poLCA` object returned from [poLCA::poLCA()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   variable = "Manifest variable",
#'   "class",
#'   "outcome",
#'   estimate = "Estimated class-conditional response probability",
#'   "std.error"
#' )
#' 
#' @examples
#'
#' library(poLCA)
#' library(dplyr)
#'
#' data(values)
#' f <- cbind(A, B, C, D)~1
#' M1 <- poLCA(f, values, nclass = 2, verbose = FALSE)
#'
#' M1
#' tidy(M1)
#' augment(M1)
#' glance(M1)
#'
#' library(ggplot2)
#'
#' ggplot(tidy(M1), aes(factor(class), estimate, fill = factor(outcome))) +
#'   geom_bar(stat = "identity", width = 1) +
#'   facet_wrap(~ variable)
#' ## Three-class model with a single covariate.
#'
#' data(election)
#' f2a <- cbind(MORALG,CARESG,KNOWG,LEADG,DISHONG,INTELG,
#'              MORALB,CARESB,KNOWB,LEADB,DISHONB,INTELB)~PARTY
#' nes2a <- poLCA(f2a, election, nclass = 3, nrep = 5, verbose = FALSE)
#'
#' td <- tidy(nes2a)
#' td
#'
#' # show
#'
#' ggplot(td, aes(outcome, estimate, color = factor(class), group = class)) +
#'   geom_line() +
#'   facet_wrap(~ variable, nrow = 2) +
#'   theme(axis.text.x = element_text(angle = 90, hjust = 1))
#'
#' au <- augment(nes2a)
#' au
#' count(au, .class)
#'
#' # if the original data is provided, it leads to NAs in new columns
#' # for rows that weren't predicted
#' au2 <- augment(nes2a, data = election)
#' au2
#' dim(au2)
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
#' @inherit tidy.poLCA params examples
#' @template param_data
#' 
#' @evalRd return_augment(
#'   .fitted = FALSE,
#'   .resid = FALSE,
#'   ".class",
#'   ".probability"
#' )
#' 
#' @details If the `data` argument is given, those columns are included in
#'   the output (only rows for which predictions could be made).
#'   Otherwise, the `y` element of the poLCA object, which contains the
#'   manifest variables used to fit the model, are used, along with any
#'   covariates, if present, in `x`.
#'
#'   Note that while the probability of all the classes (not just the predicted
#'   modal class) can be found in the `posterior` element, these are not
#'   included in the augmented output.
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
    data <- bind_cols(x$y, x$x)
  } else {
    if (nrow(data) != nrow(ret)) {
      # Rows may have been removed for NAs. For those rows, the new columns NAs
      ret$.rownames <- rownames(x$y)
      ret <- ret[rownames(data), ]
    }
  }
  
  as_tibble(bind_cols(data, ret))
}

#' @templateVar class poLCA
#' @template title_desc_glance
#' 
#' @inherit tidy.poLCA params examples
#'
#' @evalRd return_glance(
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "chi.squared",
#'   "df",
#'   "df.residual",
#'   g.squared = "The likelihood ratio/deviance statistic",
#'   "nobs"
#' )
#'
#' @export
#' @seealso [glance()], [poLCA::poLCA()]
#' @family poLCA tidiers
glance.poLCA <- function(x, ...) {
  ret <- with(
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
  ret$nobs <- stats::nobs(x)
  ret
}
