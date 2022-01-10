#' @templateVar class boot
#' @template title_desc_tidy
#'
#' @param x A [boot::boot()] object.
#' @template param_confint
#' @param conf.method Passed to the `type` argument of [boot::boot.ci()].
#'   Defaults to `"perc"`. The allowed types are `"perc"`, `"basic"`,
#'   `"bca"`, and `"norm"`. Does not support `"stud"` or `"all"`.
#' @template param_unused_dots
#'
#' @evalRd return_tidy("bias", "std.error", "term",
#'   statistic = "Original value of the statistic."
#' )
#'
#' @details If weights were provided to the `boot` function, an `estimate`
#' column is included showing the weighted bootstrap estimate, and the
#' standard error is of that estimate.
#'
#' If there are no original statistics in the "boot" object, such as with a
#' call to `tsboot` with `orig.t = FALSE`, the `original`
#' and `statistic` columns are omitted, and only `estimate` and
#' `std.error` columns shown.
#'
#' @examples
#' 
#' # feel free to ignore the following line—it allows {broom} to supply 
#' # examples without requiring the model-supplying package to be installed.
#' if (requireNamespace("boot", quietly = TRUE)) {
#'
#' # load modeling library
#' library(boot)
#'
#' clotting <- data.frame(
#'   u = c(5, 10, 15, 20, 30, 40, 60, 80, 100),
#'   lot1 = c(118, 58, 42, 35, 27, 25, 21, 19, 18),
#'   lot2 = c(69, 35, 26, 21, 18, 16, 13, 12, 12)
#' )
#'
#' # fit models
#' g1 <- glm(lot2 ~ log(u), data = clotting, family = Gamma)
#'
#' bootfun <- function(d, i) {
#'   coef(update(g1, data = d[i, ]))
#' }
#'
#' bootres <- boot(clotting, bootfun, R = 999)
#' 
#' # summarize model fits with tidiers
#' tidy(g1, conf.int = TRUE)
#' tidy(bootres, conf.int = TRUE)
#' 
#' }
#' 
#' @export
#' @aliases boot_tidiers
#' @seealso [tidy()], [boot::boot()], [boot::tsboot()], [boot::boot.ci()],
#'   [rsample::bootstraps()]
tidy.boot <- function(x,
                      conf.int = FALSE,
                      conf.level = 0.95,
                      conf.method = c("perc", "bca", "basic", "norm"),
                      ...) {
  conf.method <- rlang::arg_match(conf.method)

  # calculate the bias and standard error
  # this is an adapted version of the code in print.boot, where the bias
  # and standard error are calculated
  boot.out <- x
  index <- 1:ncol(boot.out$t)
  t <- matrix(boot.out$t[, index], nrow = nrow(boot.out$t))
  allNA <- apply(t, 2L, function(t) all(is.na(t)))
  index <- index[!allNA]
  t <- matrix(t[, !allNA], nrow = nrow(t))

  if (is.null(t0 <- boot.out$t0)) {
    if (is.null(boot.out$call$weights)) {
      op <- cbind(
        apply(t, 2L, mean, na.rm = TRUE),
        sqrt(apply(t, 2L, function(t.st) var(t.st[!is.na(t.st)])))
      )
    } else {
      op <- NULL
      for (i in index) op <- rbind(op, boot::imp.moments(boot.out, index = i)$rat)
      op[, 2L] <- sqrt(op[, 2])
    }
    colnames(op) <- c("estimate", "std.error")
  } else {
    t0 <- boot.out$t0[index]
    if (is.null(boot.out$call$weights)) {
      op <- cbind(t0, apply(t, 2L, mean, na.rm = TRUE) -
        t0, sqrt(apply(t, 2L, function(t.st) var(t.st[!is.na(t.st)]))))
      colnames(op) <- c("statistic", "bias", "std.error")
    }
    else {
      op <- NULL
      for (i in index) {
        op <- rbind(op, boot::imp.moments(boot.out,
          index = i
        )$rat)
      }
      op <- cbind(t0, op[, 1L] - t0, sqrt(op[, 2L]), apply(t,
        2L, mean,
        na.rm = TRUE
      ))
      colnames(op) <- c("statistic", "bias", "std.error", "estimate")
    }
  }

  # bring in rownames as "term" column, and turn into a data.frame
  ret <- as_tidy_tibble(op)

  if (conf.int) {
    ci.list <- lapply(seq_along(x$t0),
      boot::boot.ci,
      boot.out = x,
      conf = conf.level, type = conf.method
    )

    # boot.ci uses c("norm", "basic", "perc", "stud") for types
    # stores them with longer names
    ci.pos <- pmatch(conf.method, names(ci.list[[1]]))

    if (conf.method == "norm") {
      ci.tab <- cbind(ci.list[[1]][ci.pos][[1]][2:3], ci.list[[2]][ci.pos][[1]][2:3])
    } else {
      ci.tab <- t(sapply(ci.list, function(x) x[[ci.pos]][4:5]))
    }

    colnames(ci.tab) <- c("conf.low", "conf.high")
    ret <- cbind(ret, ci.tab)
  }
  as_tibble(ret)
}
