#' @templateVar class ridgelm
#' @template title_desc_tidy
#'
#' @param x A `ridgelm` object returned from [MASS::lm.ridge()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy("lambda", "GCV", "term",
#'   estimate = "estimate of scaled coefficient using this lambda",
#'   scale = "Scaling factor of estimated coefficient"
#' )
#'
#' @examplesIf rlang::is_installed(c("MASS", "ggplot2"))
#'
#' # load libraries for models and data
#' library(MASS)
#'
#' names(longley)[1] <- "y"
#'
#' # fit model and summarizd results
#' fit1 <- lm.ridge(y ~ ., longley)
#' tidy(fit1)
#'
#' fit2 <- lm.ridge(y ~ ., longley, lambda = seq(0.001, .05, .001))
#' td2 <- tidy(fit2)
#' g2 <- glance(fit2)
#'
#' # coefficient plot
#' library(ggplot2)
#' ggplot(td2, aes(lambda, estimate, color = term)) +
#'   geom_line()
#'
#' # GCV plot
#' ggplot(td2, aes(lambda, GCV)) +
#'   geom_line()
#'
#' # add line for the GCV minimizing estimate
#' ggplot(td2, aes(lambda, GCV)) +
#'   geom_line() +
#'   geom_vline(xintercept = g2$lambdaGCV, col = "red", lty = 2)
#'
#' @export
#' @aliases ridgelm_tidiers
#' @family ridgelm tidiers
#' @seealso [tidy()], [MASS::lm.ridge()]
tidy.ridgelm <- function(x, ...) {
  if (length(x$lambda) == 1) {
    # only one choice of lambda
    ret <- tibble(
      lambda = x$lambda,
      GCV = unname(x$GCV),
      term = names(x$coef),
      estimate = x$coef,
      scale = x$scales
    )
    return(ret)
  }

  # otherwise, multiple lambdas/coefs/etc, have to tidy
  cotidy <- data.frame(
    unrowname(t(x$coef)),
    lambda = x$lambda,
    GCV = unname(x$GCV)
  ) |>
    pivot_longer(
      cols = c(dplyr::everything(), -lambda, -GCV),
      names_to = "term",
      values_to = "estimate"
    ) |>
    as.data.frame() |>
    mutate(term = as.character(term)) |>
    mutate(scale = x$scales[term])

  as_tibble(cotidy)
}


#' @templateVar class ridgelm
#' @template title_desc_glance
#'
#' @inherit tidy.ridgelm params examples
#'
#' @evalRd return_glance(
#'   kHKB = "modified HKB estimate of the ridge constant",
#'   kLW = "modified L-W estimate of the ridge constant",
#'   lambdaGCV = "choice of lambda that minimizes GCV"
#' )
#'
#' @details This is similar to the output of `select.ridgelm`, but it is
#'   returned rather than printed.
#'
#' @export
#' @family ridgelm tidiers
#' @seealso [glance()], [MASS::select.ridgelm()], [MASS::lm.ridge()]
glance.ridgelm <- function(x, ...) {
  as_glance_tibble(
    kHKB = x$kHKB,
    kLW = x$kLW,
    lambdaGCV = x$lambda[which.min(x$GCV)],
    na_types = "rrr"
  )
}
