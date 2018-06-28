#' Tidying methods for models with multiple group fixed effects
#'
#' These methods tidy the coefficients of a linear model with multiple group fixed effects
#'
#' @template boilerplate
#'
#' @name felm_tidiers
#'
#' @param x felm object
#' @param data Original data, defaults to extracting it from the model
#' @examples
#'
#' if (require("lfe", quietly = TRUE)) {
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
NULL


#' @rdname felm_tidiers
#'
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level of the interval, used only if
#' `conf.int=TRUE`
#' @param fe whether to include estimates of fixed effects
#'
#' @details If `conf.int=TRUE`, the confidence interval is computed
#'
#' @return `tidy.felm` returns one row for each coefficient. If `fe=TRUE`, it also includes rows for for fixed effects estimates.
#' There are five columns:
#'   \item{term}{The term in the linear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error from the linear model}
#'   \item{statistic}{t-statistic}
#'   \item{p.value}{two-sided p-value}
#'
#' If `cont.int=TRUE`, it also includes columns for `conf.low` and `conf.high`, computed with [confint()].
#' @export
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
      ret_fe <- ret_fe %>%
        mutate(
          conf.low = estimate - stats::qnorm(1 - (1 - conf.level) / 2) * std.error,
          conf.high = estimate + stats::qnorm(1 - (1 - conf.level) / 2) * std.error
        )
    }
    ret <- rbind(ret, ret_fe)
  }
  as_tibble(ret)
}

# Things it does not do (no simple way to get it)
# 1. does not work if new data
# 2. does not give SE of the fit
#' @rdname felm_tidiers
#' @return  `augment.felm` returns  one row for each observation, with multiple columns added to the original data:
#'   \item{.fitted}{Fitted values of model}
#'   \item{.resid}{Residuals}
#' @export
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

#' @rdname felm_tidiers
#'
#' @param ... extra arguments (not used)
#'
#' @return `glance.lm` returns a one-row data.frame with the columns
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
