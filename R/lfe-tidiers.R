#' @templateVar class felm
#' @template title_desc_tidy
#'
#' @param x A `felm` object returned from [lfe::felm()].
#' @template param_confint
#' @param fe Logical indicating whether or not to include estimates of
#'   fixed effects. Defaults to `FALSE`.
#' @template param_unused_dots
#'
#' @template return_tidy_regression
#'
#' @return If `fe = TRUE`, also includes rows for for fixed effects estimates.
#'   
#' @examples
#'
#' if (require("lfe", quietly = TRUE)) {
#' 
#'     library(lfe)
#'     
#'     N=1e2
#'     DT <- data.frame(
#'       id = sample(5, N, TRUE),
#'       v1 =  sample(5, N, TRUE),
#'       v2 =  sample(1e6, N, TRUE),
#'       v3 =  sample(round(runif(100,max=100),4), N, TRUE),
#'       v4 =  sample(round(runif(100,max=100),4), N, TRUE)
#'     )
#'
#'     result_felm <- felm(v2~v3, DT)
#'     tidy(result_felm)
#'     augment(result_felm)
#'     result_felm <- felm(v2~v3|id+v1, DT)
#'     tidy(result_felm, fe = TRUE)
#'     augment(result_felm)
#'     v1<-DT$v1
#'     v2 <- DT$v2
#'     v3 <- DT$v3
#'     id <- DT$id
#'     result_felm <- felm(v2~v3|id+v1)
#'     tidy(result_felm)
#'     augment(result_felm)
#'     glance(result_felm)
#' }
#'
#' @export
#' @aliases felm_tidiers lfe_tidiers
#' @family felm tidiers
#' @seealso [tidy()], [lfe::felm()]
tidy.felm <- function(x, conf.int = FALSE, conf.level = .95, fe = FALSE, ...) {
  nn <- c("estimate", "std.error", "statistic", "p.value")
  ret <- fix_data_frame(stats::coef(summary(x)), nn)

  if (conf.int) {
    # avoid "Waiting for profiling to be done..." message
    CI <- suppressMessages(stats::confint(x, level = conf.level))
    colnames(CI) <- c("conf.low", "conf.high")
    ret <- cbind(ret, unrowname(CI))
  }

  if (fe) {
    ret <- mutate(ret, N = NA, comp = NA)
    object <- lfe::getfe(x)
    
    nn <- c("estimate", "std.error", "N", "comp")
    ret_fe <- lfe::getfe(x, se = TRUE, bN = 100) %>%
      select(effect, se, obs, comp) %>%
      fix_data_frame(nn) %>%
      mutate(statistic = estimate / std.error) %>%
      mutate(p.value = 2 * (1 - stats::pt(statistic, df = N)))
    
    if (conf.int) {
      
      crit_val_low <- stats::qnorm(1 - (1 - conf.level) / 2)
      crit_val_high <- stats::qnorm(1 - (1 - conf.level) / 2)
      
      ret_fe <- ret_fe %>%
        mutate(
          conf.low = estimate - crit_val_low * std.error,
          conf.high = estimate +  crit_val_high * std.error
        )
    }
    ret <- rbind(ret, ret_fe)
  }
  as_tibble(ret)
}

#' @templateVar class felm
#' @template title_desc_augment
#' 
#' @inheritParams tidy.felm
#' @template param_data 
#' 
#' @template return_augment_columns
#' 
#' @export
#' @family felm tidiers
#' @seealso [augment()], [lfe::felm()]
augment.felm <- function(x, data = NULL, ...) {
  
  # TODO: consider adding connencted component and fixed effect summaries
  # back in. need to think about if this makes sense. removing at the 
  # moment because of errors and time crunch for CRAN.
  
  mf <- model.frame(x)
  
  if (is.null(data)) {
    data <- as_tibble(mf)  # will fail for poly terms
  } else {
    data <- fix_data_frame(data, newcol = ".rownames")
  }
  
  mutate(data, .fitted = x$fitted.values, .resid = x$residuals)
}

#' @templateVar class felm
#' @template title_desc_glance
#' 
#' @inheritParams tidy.felm
#'
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{r.squared}{The percent of variance explained by the model}
#'   \item{adj.r.squared}{r.squared adjusted based on the degrees of freedom}
#'   \item{sigma}{The square root of the estimated residual variance}
#'   \item{statistic}{F-statistic}
#'   \item{p.value}{p-value from the F test}
#'   \item{df}{Degrees of freedom used by the coefficients}
#'   \item{df.residual}{residual degrees of freedom}
#'
#' @export
glance.felm <- function(x, ...) {
  ret <- with(
    summary(x),
    tibble(
      r.squared = r2,
      adj.r.squared = r2adj,
      sigma = rse,
      statistic = fstat,
      p.value = pval,
      df = df[1],
      df.residual = rdf
  ))
  finish_glance(ret, x)
}
