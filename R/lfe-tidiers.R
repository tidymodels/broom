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
#'   these defaults (say, to explore the effect of different error structures
#'   on model inference) by specifying an appropriate alternative. 
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @examples
#'
#' library(lfe)
#'
#' N <- 1e2
#' DT <- data.frame(
#'   id = sample(5, N, TRUE),
#'   v1 = sample(5, N, TRUE),
#'   v2 = sample(1e6, N, TRUE),
#'   v3 = sample(round(runif(100, max = 100), 4), N, TRUE),
#'   v4 = sample(round(runif(100, max = 100), 4), N, TRUE)
#' )
#'
#' result_felm <- felm(v2 ~ v3, DT)
#' tidy(result_felm)
#' augment(result_felm)
#'
#' result_felm <- felm(v2 ~ v3 | id + v1, DT)
#' tidy(result_felm, fe = TRUE)
#' tidy(result_felm, se.type = "robust") ## Same as default above
#' tidy(result_felm, se.type = "iid") ## Non-robust SEs
#' augment(result_felm)
#'
#' ## The "se.type" argument is useful for comparing SEs on the fly.
#' result_felm <- felm(v2 ~ v3 | id + v1 | 0 | id, DT) ## Cluster by id
#' tidy(result_felm, conf.int = TRUE) 
#' tidy(result_felm, conf.int = TRUE, se.type = "cluster") ## Same as default above
#' tidy(result_felm, conf.int = TRUE, se.type = "robust") ## HC SEs
#' tidy(result_felm, se.type = "iid") ## Vanilla SEs
#'
#' v1 <- DT$v1
#' v2 <- DT$v2
#' v3 <- DT$v3
#' id <- DT$id
#' result_felm <- felm(v2 ~ v3 | id + v1)
#'
#' tidy(result_felm)
#' augment(result_felm)
#' glance(result_felm)
#' @export
#' @aliases felm_tidiers lfe_tidiers
#' @family felm tidiers
#' @seealso [tidy()], [lfe::felm()]
tidy.felm <- function(x, conf.int = FALSE, conf.level = .95, fe = FALSE, se.type = c("default", "iid", "robust", "cluster"), ...) {
  has_multi_response <- length(x$lhs) > 1
  
  se.type = match.arg(se.type)
  if (se.type=="default") se.type = NULL
  ## Get "robust" logical to pass on to summary.lfe
  if (is.null(se.type)) {
    robust <- !is.null(x$clustervar) 
  } 
  else {
    if (se.type!='iid') {
      ## Catch potential user error, asking for clusters where none exist
      if (se.type == "cluster" && is.null(x$clustervar)) {
        warning("Clustered SEs requested, but weren't calculated in underlying model object. Reverting to default SEs.\n")
        se.type <- NULL
      }
      robust <- TRUE
    }
    else {
      robust <- FALSE
    }
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
  
  
  if (conf.int) {
    if (has_multi_response) {
      ci <- map_df(x$lhs, function(y) {
        broom_confint_terms(x, level = conf.level, type = NULL, lhs = y)
      })
    } else {
      ci <- broom_confint_terms(x, level = conf.level, type = se.type)
    }
    ret <- dplyr::left_join(ret, ci, by = "term")
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
