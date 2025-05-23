#' @templateVar class lmrob
#' @template title_desc_tidy
#'
#' @param x A `lmrob` object returned from [robustbase::lmrob()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @details For tidiers for robust models from the \pkg{MASS} package see
#'   [tidy.rlm()].
#'
#' @examples
#'
#' if (requireNamespace("robustbase", quietly = TRUE)) {
#'   # load libraries for models and data
#'   library(robustbase)
#'
#'   data(coleman)
#'   set.seed(0)
#'
#'   m <- lmrob(Y ~ ., data = coleman)
#'   tidy(m)
#'   augment(m)
#'   glance(m)
#'
#'   data(carrots)
#'
#'   Rfit <- glmrob(cbind(success, total - success) ~ logdose + block,
#'     family = binomial, data = carrots, method = "Mqle",
#'     control = glmrobMqle.control(tcc = 1.2)
#'   )
#'
#'   tidy(Rfit)
#'   augment(Rfit)
#' }
#' @aliases robustbase_tidiers
#' @export
#' @family robustbase tidiers
#' @rdname tidy.robustbase.lmrob
#' @seealso [robustbase::lmrob()]
tidy.lmrob <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
  check_ellipses("exponentiate", "tidy", "lmrob", ...)

  ret <- coef(summary(x)) |>
    as_tibble(rownames = "term")
  names(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")

  if (conf.int) {
    ci <- stats::confint.default(x, level = conf.level) |>
      as_tibble()

    names(ci) <- c("conf.low", "conf.high")

    ret <- ret |>
      cbind(ci)
  }

  ret
}

#' @templateVar class lmrob
#' @template title_desc_augment
#'
#' @inherit tidy.lmrob params examples
#' @template param_data
#' @template param_newdata
#' @template param_se_fit
#' @template param_unused_dots
#'
#' @evalRd return_augment()
#' @details For tidiers for robust models from the \pkg{MASS} package see
#'   [tidy.rlm()].
#'
#' @export
#' @rdname augment.robustbase.lmrob
#' @family robustbase tidiers
#' @seealso [robustbase::lmrob()]
augment.lmrob <- function(
  x,
  data = model.frame(x),
  newdata = NULL,
  se_fit = FALSE,
  ...
) {
  augment_newdata(
    x,
    data,
    newdata,
    .se_fit = se_fit
  )
}

#' @templateVar class lmrob
#' @template title_desc_glance
#'
#' @inherit tidy.lmrob params examples
#' @template param_unused_dots
#'
#' @details For tidiers for robust models from the \pkg{MASS} package see
#'   [tidy.rlm()].
#'
#' @evalRd return_glance(
#'   "r.squared",
#'   "sigma",
#'   "df.residual"
#' )
#'
#' @export
#' @family robustbase tidiers
#' @rdname glance.robustbase.lmrob
#' @seealso [robustbase::lmrob()]
glance.lmrob <- function(x, ...) {
  s <- summary(x)

  as_glance_tibble(
    r.squared = s$r.squared,
    sigma = s$sigma,
    df.residual = x$df.residual,
    na_types = "rri"
  )
}
