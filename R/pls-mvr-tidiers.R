#' @templateVar class mvr
#' @template title_desc_tidy
#'
#' @param x An `mvr` object such as those created by [pls::mvr()], [pls::plsr()], [pls::cppls()]
#'  and [pls::pcr()].
#' @param ncomp The number of components to include in the model. Ignored if comps is specified.
#' @param comps If specified, the values of each component out of comps are shown.
#' @param intercept Whether coefficients for the intercept should be included. Ignored if comps is
#'  specified.
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "response",
#'   "term",
#'   "estimate"
#' )
#'
#' @details
#' The number of components to fit is specified with the argument ncomp.
#' It means from the 1st component to the ncomp-th component are used to fit.
#' If comps is given, however, estimates are the coefficients for a model with only the component
#'  comps\[i\], i.e. the contribution of the component comps\[i\] on the regression coefficients.
#'
#' @family mvr tidiers
#'
#' @examples
#' library(pls)
#' library(dplyr)
#' library(ggplot2)
#'
#' data(yarn) # Single-response model
#' yarn.pls <- plsr(density ~ NIR, 6, data = yarn, validation = "CV")
#' glance(yarn.pls)
#' tidy(yarn.pls)
#' augment(yarn.pls)
#'
#' data(oliveoil) # Multi-response model
#' sens.pls <- plsr(sensory ~ chemical, ncomp = 4, scale = TRUE, data = oliveoil)
#' glance(sens.pls)
#' tidy(sens.pls)
#' augment(sens.pls)
#'
#' set.seed(42)
#' test_id <- sample(1:nrow(yarn), nrow(yarn) / 3)
#' yarn.pls.train <- plsr(density ~ NIR, 3, data = slice(yarn, -test_id))
#' augment(yarn.pls.train, newdata = slice(yarn, test_id)) %>%
#'   mutate(.rownames = test_id) %>%
#'   ggplot(aes(.rownames, .t.squared[, 3])) +
#'   geom_point() +
#'   ggtitle("How far each sample is from the center of the model.")
#' @export
#'
#' @seealso [tidy()], [pls::coef.mvr()]
#'
tidy.mvr <- function(x, ncomp = x$ncomp, comps = NULL, intercept = FALSE, ...) {
  comp_type <- ifelse(is.null(comps), "ncomp", "comps")
  if (comp_type == "comps") {
    if (length(comps) > 1) {
      line <- paste(
        "comps is a multi-component vector:",
        "comps = {comps[1]} will be used."
      )
      message(glue(line))
    }
  } else {
    if (length(ncomp) > 1) {
      line <- paste(
        "ncomp is a multi-component vector:",
        "ncomp = {ncomp[1]} will be used."
      )
      message(glue(line))
    }
  }
  ret <- coef(x, ncomp = ncomp[1], comps = comps[1], intercept = intercept, ...)
  ret <- apply(ret, 3, fix_data_frame)[[1]]
  ret <- tidyr::gather(ret, key = "response", value = "estimate", -"term")
  dplyr::select(ret, "response", "term", "estimate")
}

#' @templateVar class mvr
#' @template title_desc_augment
#'
#' @param x a mvr object such as those created by [pls::mvr()], [pls::plsr()], [pls::cppls()] and
#'  [pls::pcr()].
#' @template param_data
#' @template param_newdata
#' @param ncomp The number of components to include in the model. Ignored if comps is specified.
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   ".rownames",
#'   "response",
#'   ".fitted",
#'   .t.squared="Hotelling's T^2 value."
#' )
#'
#' @inherit tidy.mvr examples
#'
#' @family mvr tidiers
#'
#' @export
#'
#' @seealso [augment()], [pls::predict.mvr()]
#'
augment.mvr <- function(x,
                        data = model.frame(x),
                        newdata = NULL,
                        ncomp = x$ncomp, ...) {
  if (length(ncomp) > 1) {
    line <- paste(
      "ncomp is a multi-component vector:",
      "ncomp = {ncomp[1]} will be used."
    )
    message(glue(line))
  }
  temp <- x
  class(temp) <- c("mvr_temp", class(temp))
  df <- augment_newdata(temp,
    data,
    newdata,
    FALSE,
    ncomp = ncomp[1],
    type = "response", ...
  )
  df$.scores <- predict(x, newdata = newdata, type = "scores", ...)

  t2 <- as.data.frame(df$.scores^2)
  t2 <- purrr::map2(t2, x$Xvar, ~ .x / .y)
  t2 <- purrr::accumulate(t2, `+`)
  t2 <- as.data.frame(t2)
  t2 <- tibble::tidy_names(t2)
  t2 <- as.matrix(t2)
  df$.t.squared <- t2

  df
}

# Make predict(), an S3 method, preferable in augment_newdata() using a temporary class
predict.mvr_temp <- function(object, ncomp, type, ...) {
  pls:::predict.mvr(object, ncomp = ncomp, type = type, ...)[, , 1]
}

#' @templateVar class mvr
#' @template title_desc_glance
#'
#' @param x An `mvr` object such as those created by [pls::mvr()], [pls::plsr()], [pls::cppls()]
#'  and [pls::pcr()].
#' @param ncomp The number of components to include in the model. Ignored if comps is specified.
#' @param test A [data.frame()] or [tibble::tibble()] to estimate the predictive performance of 
#' `x`. It contains all the original predictors used to create `x`.
#' @param estimate Which estimators to use to estimate mesures of fit, containing the mean
#'  squared error of prediction (MSEP) root mean squared error of prediction (RMSEP) and R^2.
#'   "adjCV" is only available for (R)MSEP.
#' @template param_unused_dots
#'
#' @evalRd return_glance(
#'   "estimator",
#'   "r.squared",
#'   msep = "Mean squared error of prediction",
#'   rmsep = "Root mean squared error of prediction"
#' )
#'
#' @inherit tidy.mvr examples
#'
#' @family mvr tidiers
#'
#' @export
#'
#' @seealso [glance()], [pls::R2()]
#'
glance.mvr <- function(x, 
                       ncomp = x$ncomp, 
                       test = NULL,
                       estimate = c("train", "test", "CV", "adjCV"), ...) {
  if (length(ncomp) > 1) {
    line <- paste(
      "ncomp is a multi-component vector:",
      "ncomp = {ncomp[1]} will be used."
    )
    message(glue(line))
  }
  
  estimate <- match.arg(estimate)
  if (!is.null(test) && estimate != "test") {
    message("test is not NULL: estimate = \"test\" will be used.")
    estimate <- "test"
  }
  
  ret <- tibble::tibble(estimator = estimate, r.squared = NA)
  if (estimate != "adjCV") ret$r.squared <- grance.mvr.estimate(x, pls::R2, ncomp[1], test, estimate)
  ret$msep <- grance.mvr.estimate(x, pls::MSEP, ncomp[1], test, estimate)
  ret$rmsep <- grance.mvr.estimate(x, pls::RMSEP, ncomp[1], test, estimate)
  ret
}

grance.mvr.estimate <- function(x, f, ncomp, test, estimate){
  ret <- do.call(f, list(object = x, newdata = test, estimate = estimate, ncomp = ncomp))$val
  response_names <- dimnames(ret)$response
  ret <- ret[, , 2]
  names(ret) <- response_names
  ret <- matrix(ret, ncol = length(ret), dimnames = list(NULL, names(ret)))
  ret
}
