#' @templateVar class ridgelm
#' @template title_desc_tidy
#' 
#' @param x A `ridgelm` object returned from [MASS::lm.ridge()].
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with one row for each combination of lambda and
#'   a term in the formula, with columns:
#'   \item{lambda}{choice of lambda}
#'   \item{GCV}{generalized cross validation value for this lambda}
#'   \item{term}{the term in the ridge regression model being estimated}
#'   \item{estimate}{estimate of scaled coefficient using this lambda}
#'   \item{scale}{Scaling factor of estimated coefficient}
#'
#' @examples
#'
#' names(longley)[1] <- "y"
#' fit1 <- MASS::lm.ridge(y ~ ., longley)
#' tidy(fit1)
#'
#' fit2 <- MASS::lm.ridge(y ~ ., longley, lambda = seq(0.001, .05, .001))
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
      term = names(x$coef),
      estimate = x$coef,
      scale = x$scales,
      xm = x$xm
    )
    return(ret)
  }

  # otherwise, multiple lambdas/coefs/etc, have to tidy
  cotidy <- data.frame(unrowname(t(x$coef)),
    lambda = x$lambda,
    GCV = unname(x$GCV)
  ) %>%
    tidyr::gather(term, estimate, -lambda, -GCV) %>%
    mutate(term = as.character(term)) %>%
    mutate(scale = x$scales[term])

  as_tibble(cotidy)
}


#' @templateVar class ridgelm
#' @template title_desc_glance
#' 
#' @inheritParams tidy.ridgelm
#'
#' @return A one-row [tibble::tibble] with columns:
#'   \item{kHKB}{modified HKB estimate of the ridge constant}
#'   \item{kLW}{modified L-W estimate of the ridge constant}
#'   \item{lambdaGCV}{choice of lambda that minimizes GCV}
#'
#' @details This is similar to the output of `select.ridgelm`, but it is
#'   returned rather than printed.
#'
#' @export
#' @family ridgelm tidiers
#' @seealso [glance()], [MASS::select.ridgelm()], [MASS::lm.ridge()]
glance.ridgelm <- function(x, ...) {
  tibble(
    kHKB = x$kHKB, 
    kLW = x$kLW,
    lambdaGCV = x$lambda[which.min(x$GCV)]
  )
}
