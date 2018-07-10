#' @templateVar class lm
#' @template title_desc_tidy
#' 
#' @param x An `lm` object created by [stats::lm()].
#' @template param_confint 
#' @template param_quick
#' @template param_exponentiate
#' @template param_unused_dots
#' 
#' @template return_tidy_regression
#' 
#' @return If the linear model is an `mlm` object (multiple linear model),
#'   there is an additional column:
#' 
#'   \item{response}{Which response column the coefficients correspond to
#'   (typically Y1, Y2, etc)}
#' 
#' @details If you have missing values in your model data, you may need to refit
#' the model with `na.action = na.exclude`.
#' 
#' @examples
#'
#' library(ggplot2)
#' library(dplyr)
#'
#' mod <- lm(mpg ~ wt + qsec, data = mtcars)
#'
#' tidy(mod)
#' glance(mod)
#'
#' # coefficient plot
#' d <- tidy(mod) %>% 
#'   mutate(
#'     low = estimate - std.error,
#'     high = estimate + std.error
#'   )
#'   
#' ggplot(d, aes(estimate, term, xmin = low, xmax = high, height = 0)) +
#'      geom_point() +
#'      geom_vline(xintercept = 0) +
#'      geom_errorbarh()
#'
#' augment(mod)
#' augment(mod, mtcars)
#'
#' # predict on new data
#' newdata <- mtcars %>% head(6) %>% mutate(wt = wt + 1)
#' augment(mod, newdata = newdata)
#'
#' au <- augment(mod, data = mtcars)
#'
#' ggplot(au, aes(.hat, .std.resid)) +
#'   geom_vline(size = 2, colour = "white", xintercept = 0) +
#'   geom_hline(size = 2, colour = "white", yintercept = 0) +
#'   geom_point() + geom_smooth(se = FALSE)
#'
#' plot(mod, which = 6)
#' ggplot(au, aes(.hat, .cooksd)) +
#'   geom_vline(xintercept = 0, colour = NA) +
#'   geom_abline(slope = seq(0, 3, by = 0.5), colour = "white") +
#'   geom_smooth(se = FALSE) +
#'   geom_point()
#' 
#' # column-wise models
#' a <- matrix(rnorm(20), nrow = 10)
#' b <- a + rnorm(length(a))
#' result <- lm(b ~ a)
#' tidy(result)
#'
#' @aliases lm_tidiers
#' @export
#' @seealso [tidy()], [stats::summary.lm()]
#' @family lm tidiers
tidy.lm <- function(x, conf.int = FALSE, conf.level = .95,
                    exponentiate = FALSE, quick = FALSE, ...) {
  if (quick) {
    co <- stats::coef(x)
    ret <- data.frame(term = names(co), estimate = unname(co),
                      stringsAsFactors = FALSE)
    return(process_lm(ret, x, conf.int = FALSE, exponentiate = exponentiate))
  }
  s <- summary(x)
  ret <- tidy.summary.lm(s)

  process_lm(ret, x,
    conf.int = conf.int, conf.level = conf.level,
    exponentiate = exponentiate
  )
}


#' @rdname tidy.lm
#' @export
tidy.summary.lm <- function(x, ...) {
  co <- stats::coef(x)
  nn <- c("estimate", "std.error", "statistic", "p.value")
  if (inherits(co, "listof")) {
    # multiple response variables
    ret <- map_df(co, fix_data_frame, nn[1:ncol(co[[1]])],
      .id = "response"
    )
    ret$response <- stringr::str_replace(ret$response, "Response ", "")
  } else {
    ret <- fix_data_frame(co, nn[1:ncol(co)])
  }

  as_tibble(ret)
}

#' @templateVar class lm
#' @template title_desc_augment
#' 
#' @template augment_NAs
#' 
#' @inheritParams tidy.lm
#' @template param_data
#' @template param_newdata
#' @param type.predict Type of predictions to use when `x` is a `glm` object. 
#'   Passed to [stats::predict.glm()].
#' @param type.residuals Type of residuals to use when `x` is a `glm` object. 
#'   Passed to [stats::residuals.glm()].
#'
#' @return When `newdata` is not supplied `augment.lm` returns
#'   one row for each observation, with seven columns added to the original
#'   data:
#' 
#'   \item{.hat}{Diagonal of the hat matrix}
#'   \item{.sigma}{Estimate of residual standard deviation when
#'     corresponding observation is dropped from model}
#'   \item{.cooksd}{Cooks distance, [cooks.distance()]}
#'   \item{.fitted}{Fitted values of model}
#'   \item{.se.fit}{Standard errors of fitted values}
#'   \item{.resid}{Residuals}
#'   \item{.std.resid}{Standardised residuals}
#'
#'   Some unusual `lm` objects, such as `rlm` from MASS, may omit `.cooksd`
#'   and `.std.resid`. `gam` from mgcv omits `.sigma`.
#'
#'   When `newdata` is supplied, returns one row for each observation, with
#'   three columns added to the new data:
#' 
#'   \item{.fitted}{Fitted values of model}
#'   \item{.se.fit}{Standard errors of fitted values}
#'   \item{.resid}{Residuals of fitted values on the new data}
#'
#' @export
#' @seealso [augment()], [stats::predict.lm()]
#' @family lm tidiers
augment.lm <- function(x, data = stats::model.frame(x), newdata,
                       type.predict, type.residuals, ...) {
  augment_columns(x, data, newdata,
    type.predict = type.predict,
    type.residuals = type.residuals
  )
}


#' @templateVar class lm
#' @template title_desc_glance
#'
#' @inheritParams tidy.lm
#'
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{r.squared}{The percent of variance explained by the model}
#'   \item{adj.r.squared}{r.squared adjusted based on the degrees of freedom}
#'   \item{sigma}{The square root of the estimated residual variance}
#'   \item{statistic}{F-statistic}
#'   \item{p.value}{p-value from the F test, describing whether the full
#'   regression is significant}
#'   \item{df}{Degrees of freedom used by the coefficients}
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'   \item{deviance}{deviance}
#'   \item{df.residual}{residual degrees of freedom}
#'
#' @export
#' @seealso [glance()]
#' @family lm tidiers
glance.lm <- function(x, ...) {
  # use summary.lm explicity, so that c("aov", "lm") objects can be
  # summarized and glanced at
  s <- stats::summary.lm(x)
  ret <- glance.summary.lm(s, ...)
  ret <- finish_glance(ret, x)
  as_tibble(ret)
}


#' @rdname glance.lm
#' @export
glance.summary.lm <- function(x, ...) {
  ret <- with(x, cbind(
    data.frame(
      r.squared = r.squared,
      adj.r.squared = adj.r.squared,
      sigma = sigma
    ),
    if (exists("fstatistic")) {
      data.frame(
        statistic = fstatistic[1],
        p.value = pf(fstatistic[1], fstatistic[2],
          fstatistic[3],
          lower.tail = FALSE
        )
      )
    }
    else {
      data.frame(
        statistic = NA_real_,
        p.value = NA_real_
      )
    },
    data.frame(
      df = df[1]
    )
  ))

  as_tibble(ret)
}

#' @export
augment.mlm <- function(x, ...) {
  stop(
    "Augment does not support linear models with multiple responses.",
    call. = FALSE
  )
}


#' @export
glance.mlm <- function(x, ...) {
  stop(
    "Glance does not support linear models with multiple responses.",
    call. = FALSE
  )
}

# TODO: the various process_* functions need to be consolidated

process_lm <- function(ret, x, conf.int = FALSE, conf.level = .95,
                       exponentiate = FALSE) {
  if (exponentiate) {
    # save transformation function for use on confidence interval
    if (is.null(x$family) ||
      (x$family$link != "logit" && x$family$link != "log")) {
      warning(paste(
        "Exponentiating coefficients, but model did not use",
        "a log or logit link function."
      ))
    }
    trans <- exp
  } else {
    trans <- identity
  }

  if (conf.int) {
    # avoid "Waiting for profiling to be done..." message
    CI <- suppressMessages(stats::confint(x, level = conf.level))
    # Handle case if regression is rank deficient
    p <- x$rank
    if (!is.null(p) && !is.null(x$qr)) {
      piv <- x$qr$pivot[seq_len(p)]
      CI <- CI[piv, , drop = FALSE]
    }
    colnames(CI) <- c("conf.low", "conf.high")
    ret <- cbind(ret, trans(unrowname(CI)))
  }
  ret$estimate <- trans(ret$estimate)

  as_tibble(ret)
}




