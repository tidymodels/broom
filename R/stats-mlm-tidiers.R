#' @templateVar class mlm
#' @template title_desc_tidy
#'
#' @param x An `mlm` object created by [stats::lm()] with a matrix as the
#'   response.
#' @template param_confint
#' @template param_quick
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @details In contrast to `lm` object (simple linear model), tidy output for
#'   `mlm` (multiple linear model) objects contain an additional column
#'   `response`.
#'
#'   If you have missing values in your model data, you may need to refit
#'   the model with `na.action = na.exclude`.
#'
#' @examples
#'
#' mod <- lm(cbind(mpg, disp) ~ wt, mtcars)
#' tidy(mod, conf.int = TRUE)
#' @aliases lm_tidiers
#' @export
#' @seealso [tidy()]
#' @family lm tidiers
#' @rdname tidy.mlm
#' @export

tidy.mlm <- function(x,
                     conf.int = FALSE,
                     conf.level = .95,
                     quick = FALSE,
                     ...) {
  # if only term and estimate columns are needed
  if (quick) {
    co <- stats::coef(x)

    ret <-
      dplyr::tibble(
        response = rep(colnames(co), each = nrow(co)),
        term = rep(rownames(co), times = ncol(co)),
        estimate = as.numeric(co),
        stringsAsFactors = FALSE
      )

    return(process_mlm(ret, 
                      x, 
                      conf.int = FALSE))
  }

  # adding other details from summary object
  s <- summary(x)
  ret <- tidy.summary.mlm(s)

  # adding confidence intervals
  process_mlm(
    ret,
    x,
    conf.int = conf.int,
    conf.level = conf.level
  )
}

# mlm objects subclass lm objects so this gives a better error than
# letting augment.lm() fail
#' @include null-and-default-tidiers.R
augment.mlm <- augment.default

#' @export
glance.mlm <- function(x, ...) {
  stop(
    "Glance does not support linear models with multiple responses.",
    call. = FALSE
  )
}

# cleaning up the tidy dataframe
process_mlm <- function(ret,
                        x,
                        conf.int = FALSE,
                        conf.level = .95) {
  if (isTRUE(conf.int)) {
    CI <- stats::confint(x, level = conf.level)
    colnames(CI) <- c("conf.low", "conf.high")
    ret <- cbind(ret, unrowname(CI))
  }

  tibble::as_tibble(ret)
}

#' @rdname tidy.mlm
#' @export
tidy.summary.mlm <- function(x, ...) {
  co <- stats::coef(x)
  nn <- c("estimate", "std.error", "statistic", "p.value")

    # multiple response variables
    ret <- purrr::map_df(co, fix_data_frame, nn[1:ncol(co[[1]])],
                  .id = "response"
    )
    ret$response <- stringr::str_replace(ret$response, "Response ", "")

  as_tibble(ret)
}
