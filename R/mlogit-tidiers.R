#' Tidying methods for logit models
#' 
#' These methods tidy the coefficients of mnl and nl models generated
#' by the functions of the `mlogit` package.
#' 
#' @param x an object returned from [mlogit::mlogit()].
#' @template param_confint
#' @template param_unused_dots
#' 
#' @evalRd return_tidy(regression = TRUE)
#' 
#' @examplesIf rlang::is_installed("mlogit")
#' 
#' # load libraries for models and data
#' library(mlogit)
#' 
#' data("Fishing", package = "mlogit")
#' Fish <- dfidx(Fishing, varying = 2:9, shape = "wide", choice = "mode")
#' 
#' # fit model
#' m <- mlogit(mode ~ price + catch | income, data = Fish)
#' 
#' # summarize model fit with tidiers
#' tidy(m)
#' augment(m)
#' glance(m)
#' 
#' @aliases mlogit_tidiers
#' @export
#' @family mlogit tidiers
#' @seealso [tidy()], [mlogit::mlogit()]
#' 
tidy.mlogit <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
  check_ellipses("exponentiate", "tidy", "mlogit", ...)
  
  # construct parameter table
  s <- summary(x)
  ret <- as_tidy_tibble(
    s$CoefTable,
    new_names =  c("estimate", "std.error", "statistic", "p.value")
  )
  
  # calculate confidence interval
  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }
  
  ret
}

#' @templateVar class mlogit
#' @template title_desc_augment
#'
#' @evalRd return_augment(".fitted", ".probability")
#'
#' @inherit tidy.mlogit params examples
#' @param data Not currently used
#'
#' @details At the moment this only works on the estimation dataset. Need to set
#'   it up to predict on another dataset.
#'
#' @export
#' @seealso [augment()]
#' @family mlogit tidiers
#' 
#' 
augment.mlogit <- function(x, data = x$model, ...) {
  check_ellipses("newdata", "augment", "mlogit", ...)
  
  # the ID variables are really messed up, so we're going to do some 
  # retrofitting because this ends up being a pretty important element of
  # what we want to do with the results.
  idx <- x$model$idx
  
  reg <- x$model %>%
    as_augment_tibble()  %>%
    dplyr::select(-idx) %>%
    
    # rename the column indicating the chosen alternative
    dplyr::rename(
      chosen = 1,
      .probability = probabilities,
      .fitted = linpred
    )  %>%
  
    # reappend the id columns
    dplyr::mutate(
      id = idx$id1,
      alternative = idx$id2,
      .resid = as.vector(x$residuals)
    ) %>%
    dplyr::select(id, alternative, chosen, everything())
      
  reg
}

#' @templateVar class mlogit
#' @template title_desc_glance
#' 
#' @inherit tidy.mlogit params examples
#' 
#' @evalRd return_glance(
#'   "logLik", 
#'   "rho2",
#'   "rho20",
#'   "AIC", 
#'   "BIC",
#'   "nobs"
#' )
#' @export
#' @family mlogit tidiers
#' @seealso [glance()], [mlogit::mlogit()]
#' 
#' 
glance.mlogit <- function(x, ...) {
  
  # compute mcfadden r2
  # model log likelihood
  llM <- as.numeric(logLik(x))
  # null model: equal odds for all alternatives
  n_alts <- length(x$freq)
  ll0 <- sum(x$freq * log(1/n_alts))
  # market shares model: odds equal to chosen proportions
  llC <- sum(x$freq*log(prop.table(x$freq))) 
  
  
  res <- as_glance_tibble(
    logLik = llM,
    rho2 = 1 - llM / llC,
    rho20 = 1 - llM / ll0,
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    nobs =  sum(x$freq),
    na_types = "rrrrri"
  )
  
  res
  
}


