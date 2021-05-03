#' @templateVar class felm
#' @template title_desc_tidy
#'
#' @param x A `felm` object returned from [lfe::felm()].
#' @template param_confint
#' @param fe Logical indicating whether or not to include estimates of
#'   fixed effects. Defaults to `FALSE`.
#' @param se.type Character indicating the type of standard errors. Defaults to
#'   using those of the underlying felm() model object, e.g. clustered errors
#'   for models that were provided a cluster specification. Users can override
#'   these defaults by specifying an appropriate alternative: "iid" (for 
#'   homoskedastic errors), "robust" (for Eicker-Huber-White robust errors), or
#'   "cluster" (for clustered standard errors; if the model object supports it).
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @examples
#'
#' library(lfe)
#'
#' # Use built-in "airquality" dataset
#' head(airquality)
#'
#' # No FEs; same as lm()
#' est0 <- felm(Ozone ~ Temp + Wind + Solar.R, airquality)
#' tidy(est0)
#' augment(est0)
#' 
#' # Add month fixed effects
#' est1 <- felm(Ozone ~ Temp + Wind + Solar.R  | Month, airquality)
#' tidy(est1)
#' tidy(est1, fe = TRUE)
#' augment(est1)
#' glance(est1)
#'
#' # The "se.type" argument can be used to switch out different standard errors 
#' # types on the fly. In turn, this can be useful exploring the effect of 
#' # different error structures on model inference.
#' tidy(est1, se.type = "iid")
#' tidy(est1, se.type = "robust")
#' 
#' # Add clustered SEs (also by month)
#' est2 <- felm(Ozone ~ Temp + Wind + Solar.R  | Month | 0 | Month, airquality)
#' tidy(est2, conf.int = TRUE) 
#' tidy(est2, conf.int = TRUE, se.type = "cluster")
#' tidy(est2, conf.int = TRUE, se.type = "robust")
#' tidy(est2, conf.int = TRUE, se.type = "iid")
#' @export
#' @aliases felm_tidiers lfe_tidiers
#' @family felm tidiers
#' @seealso [tidy()], [lfe::felm()]
tidy.felm <- function(x, conf.int = FALSE, conf.level = .95, fe = FALSE, se.type = c("default", "iid", "robust", "cluster"), ...) {
  has_multi_response <- length(x$lhs) > 1
  
  # warn users about deprecated "robust" argument
  dots <- list(...)
  if (!is.null(dots$robust)) {
    warning('\nThe "robust" argument has been deprecated in tidy.felm and will be ignored. Please use the "se.type" argument instead.\n')
  }
  
  # match SE args
  se.type <- match.arg(se.type)
  if (se.type == "default") {
    se.type <- NULL
  }
  
  # get "robust" logical to pass on to summary.lfe
  if (is.null(se.type)) {
    robust <- !is.null(x$clustervar) 
  } else if (se.type == 'iid') {
    robust <- FALSE
  } else {
    # catch potential user error, asking for clusters where none exist
    if (se.type == "cluster" && is.null(x$clustervar)) {
       warning("Clustered SEs requested, but weren't calculated in underlying model object. Reverting to default SEs.\n")
       se.type <- NULL
    }
    
    robust <- TRUE
  }
  
  nn <- c("estimate", "std.error", "statistic", "p.value")
  if (has_multi_response) {
    ret <- map_df(x$lhs, function(y) {
      stats::coef(summary(x, lhs = y, robust = robust)) %>%
        as_tidy_tibble(new_names = nn) %>%
        mutate(response = y)
    }) %>%
      select(response, dplyr::everything())
  } else {
    ret <- as_tidy_tibble(
      stats::coef(summary(x, robust = robust)),
      new_names = nn
    )
  }
  
  # Catch edge case where users specify "robust" SEs on felm() object that
  # contains clusters. Reason: Somewhat confusingly, summary.felm(robust = TRUE) 
  # reports clustered SEs even though robust SEs are available. In contrast,
  # confint.felm distinguishes between robust and clustered SEs regardless
  # of the underlying model. See also: https://github.com/sgaure/lfe/pull/17/files
  if (!is.null(se.type)) {
    if (se.type == "robust" && !is.null(x$clustervar)) {
      ret$std.error <- x$rse
      ret$statistic <- x$rtval
      ret$p.value <- x$rpval
    }
  }
  
  
  if (conf.int) {
    if (has_multi_response) {
      ci <- map_df(x$lhs, function(y) {
        broom_confint_terms(x, level = conf.level, type = NULL, lhs = y) %>% 
          mutate(response=y)
      })
      ret <- dplyr::left_join(ret, ci, by = c("response", "term"))
    } else {
      ci <- broom_confint_terms(x, level = conf.level, type = se.type)
      ret <- dplyr::left_join(ret, ci, by = "term")
    }
  }
  
  if (fe) {
    ret <- mutate(ret, N = NA, comp = NA)
    
    nn <- c("estimate", "std.error", "N", "comp")
    ret_fe_prep <- lfe::getfe(x, se = TRUE, bN = 100) %>%
      tibble::rownames_to_column(var = "term") %>%
      # effect and se are multiple if multiple y
      select(term, contains("effect"), contains("se"), obs, comp) %>%
      rename(N = obs)
    
    if (has_multi_response) {
      ret_fe_prep <- ret_fe_prep %>%
        tidyr::pivot_longer(
          cols = c(
            starts_with("effect."),
            starts_with("se.")
          ),
          names_to = "stat_resp",
          values_to = "value"
        ) %>%
        tidyr::separate(
          col = "stat_resp",
          c("stat", "response"),
          sep = "\\."
        ) %>%
        tidyr::pivot_wider(
          id_cols = c(term, N, comp, response),
          names_from = stat,
          values_from = value
        ) %>%
        dplyr::arrange(term) %>%
        as.data.frame()
    }
    ret_fe <- ret_fe_prep %>%
      rename(estimate = effect, std.error = se) %>%
      select(contains("response"), dplyr::everything()) %>%
      mutate(statistic = estimate / std.error) %>%
      mutate(p.value = 2 * (1 - stats::pt(statistic, df = N)))
    
    if (conf.int) {
      crit_val_low <- stats::qnorm(1 - (1 - conf.level) / 2)
      crit_val_high <- stats::qnorm(1 - (1 - conf.level) / 2)
      
      ret_fe <- ret_fe %>%
        mutate(
          conf.low = estimate - crit_val_low * std.error,
          conf.high = estimate + crit_val_high * std.error
        )
    }
    ret <- rbind(ret, ret_fe)
  }
  as_tibble(ret)
}

#' @templateVar class felm
#' @template title_desc_augment
#'
#' @inherit tidy.felm params examples
#' @template param_data
#'
#' @evalRd return_augment()
#'
#' @export
#' @family felm tidiers
#' @seealso [augment()], [lfe::felm()]
augment.felm <- function(x, data = model.frame(x), ...) {
  has_multi_response <- length(x$lhs) > 1

  if (has_multi_response) {
    stop(
      "Augment does not support linear models with multiple responses.",
      call. = FALSE
    )
  }
  df <- as_augment_tibble(data)
  mutate(df, .fitted = as.vector(x$fitted.values), .resid = as.vector(x$residuals))
}

#' @templateVar class felm
#' @template title_desc_glance
#'
#' @inherit tidy.felm params examples
#'
#' @evalRd return_glance(
#'   "r.squared",
#'   "adj.r.squared",
#'   "sigma",
#'   "statistic",
#'   "p.value",
#'   "df",
#'   "df.residual",
#'   "nobs"
#' )
#'
#' @export
glance.felm <- function(x, ...) {
  has_multi_response <- length(x$lhs) > 1

  if (has_multi_response) {
    stop(
      "Glance does not support linear models with multiple responses.",
      call. = FALSE
    )
  }
  
  s <- summary(x)
  
  as_glance_tibble(
    r.squared = s$r2,
    adj.r.squared = s$r2adj,
    sigma = s$rse,
    statistic = s$fstat,
    p.value = unname(s$pval),
    df = s$df[1],
    df.residual = s$rdf,
    nobs = stats::nobs(x),
    na_types = "rrrrriii"
  )
}
