#' @templateVar class INLA
#' @template title_desc_tidy
#'
#' @param x An `INLA` object returned from a call to [INLA::inla()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "term",
#'   "estimate",
#'   "std.error",
#'   "conf.low",
#'   "conf.high"
#' )
#'
#' @details Tidy `INLA` objects by extracting summaries of fixed and random effects.
#'
#' @examplesIf rlang::is_installed("INLA")
#' # Load INLA and fit a model
#' if (requireNamespace("INLA", quietly = TRUE)) {
#'   library(INLA)
#'   data <- data.frame(y = rnorm(100), x = rnorm(100))
#'   model <- inla(y ~ x, data = data)
#'   tidy(model)
#' }
#'
#' @export
#' @family INLA tidiers
#' @rdname tidy_inla
tidy.INLA <- function(x, ...) {
  fixed_effects <- as_tibble(x$summary.fixed) %>%
    mutate(term = rownames(x$summary.fixed)) %>%
    select(term, estimate = mean, std.error = sd, conf.low = `0.025quant`, conf.high = `0.975quant`)
    if (!is.null(x$summary.random) && length(x$summary.random) > 0) {
    random_effects <- map_dfr(names(x$summary.random), function(name) {
      random <- x$summary.random[[name]]
      tibble(
        term = paste(name, seq_len(nrow(random)), sep = "_"),
        estimate = random$mean,
        std.error = random$sd,
        conf.low = random$`0.025quant`,
        conf.high = random$`0.975quant`
      )
    })
    result <- bind_rows(fixed_effects, random_effects)
  } else {
    result <- fixed_effects
  }
  result
}

#' @templateVar class INLA
#' @template title_desc_glance
#'
#' @inheritParams tidy.INLA
#'
#' @evalRd return_glance(
#'   "dic",
#'   "waic",
#'   "cpo_mean"
#' )
#'
#' @details Glance at `INLA` objects by summarizing fit metrics like DIC and WAIC.
#'
#' @family INLA tidiers
#' @export
#' @rdname glance_inla
glance.INLA <- function(x, ...) {
  dic_value <- if (!is.null(x$dic)) {
    x$dic$dic
  } else {
    message("DIC was not computed. To include it, set `control.compute = list(dic = TRUE)` in your INLA call.")
    NA_real_
  }
    waic_value <- if (!is.null(x$waic)) {
    x$waic$waic
  } else {
    message("WAIC was not computed. To include it, set `control.compute = list(waic = TRUE)` in your INLA call.")
    NA_real_
  }
    cpo_mean <- if (!is.null(x$cpo)) {
    mean(-log(x$cpo$cpo), na.rm = TRUE)
  } else {
    message("CPO was not computed. To include it, set `control.compute = list(cpo = TRUE)` in your INLA call.")
    NA_real_
  }
  # Create glance tibble
  tibble(
    dic = dic_value,
    waic = waic_value,
    cpo_mean = cpo_mean
  )
}
#' @templateVar class INLA
#' @template title_desc_augment
#'
#' @param data The original dataset used to fit the `INLA` model.
#' @inheritParams tidy.INLA
#'
#' @evalRd return_augment(
#'   ".fitted",
#'   ".resid"
#' )
#'
#' @details Augment the original data with fitted values and residuals from `INLA` objects.
#'
#' @examplesIf rlang::is_installed("INLA")
#' if (requireNamespace("INLA", quietly = TRUE)) {
#'   library(INLA)
#'   data <- data.frame(y = rnorm(100), x = rnorm(100))
#'   model <- inla(y ~ x, data = data)
#'   augment(model, data)
#' }
#'
#' @family INLA tidiers
#' @export
#' @rdname augment_inla
augment.INLA <- function(x, data = NULL, response = NULL, ...) {
  # Check if the original dataset is provided
  if (is.null(data)) {
    stop("Original dataset must be provided for augmenting.")
  }
  # Check if the response variable is specified
  if (is.null(response)) {
    stop("The response variable must be specified via the 'response' parameter.")
  }
  if (!response %in% names(data)) {
    stop(glue::glue("The specified response variable '{response}' is not found in the dataset."))
  }
  augmented <- data %>%
    mutate(
      .fitted = x$summary.fitted.values$mean,
      .resid = .data[[response]] - x$summary.fitted.values$mean
    )
  
  augmented
}



### test that it all works ###

# library(tidyverse)
# library(INLA)
# 
# data <- data.frame(
#   y = rnorm(100),
#   x1 = runif(100),
#   x2 = sample(letters[1:3], 100, replace = TRUE)
# )
# 
# fit <- inla(
#   y ~ x1 + x2 + f(x2, model = "iid"),
#     data = data,
#   family = "gaussian", control.compute = list(dic = TRUE)
# )
# 
# tidy.INLA(fit)
# glance.INLA(fit)
# augment.INLA(fit, data, response = "y") |> head()

