
#' @rdname ordinal_tidiers
#' @export
tidy.polr <- function(x, conf.int = FALSE, conf.level = .95,
                      exponentiate = FALSE, quick = FALSE, ...) {
  if (quick) {
    co <- coef(x)
    ret <- data.frame(
      term = names(co), estimate = unname(co),
      stringsAsFactors = FALSE
    )
    return(process_polr(ret, x, conf.int = FALSE, exponentiate = exponentiate))
  }
  co <- suppressMessages(coef(summary(x)))
  nn <- c("estimate", "std.error", "statistic", "p.value")
  ret <- fix_data_frame(co, nn[seq_len(ncol(co))])
  process_polr(
    ret, x,
    conf.int = conf.int, conf.level = conf.level,
    exponentiate = exponentiate
  )
}


process_polr <- function(ret, x, conf.int = FALSE, conf.level = .95,
                         exponentiate = FALSE) {
  if (exponentiate) {
    trans <- exp
  } else {
    trans <- identity
  }
  
  if (conf.int) {
    CI <- suppressMessages(trans(stats::confint(x, level = conf.level)))
    colnames(CI) <- c("conf.low", "conf.high")
    CI <- as.data.frame(CI)
    CI$term <- rownames(CI)
    ret <- merge(ret, unrowname(CI), by = "term", all.x = TRUE)
  }
  
  ret$estimate <- trans(ret$estimate)
  ret$coefficient_type <- ""
  ret[ret$term %in% names(x$coefficients), "coefficient_type"] <- "coefficient"
  ret[ret$term %in% names(x$zeta), "coefficient_type"] <- "zeta"
  as_tibble(ret)
}


#' @rdname ordinal_tidiers
#' @export
glance.polr <- function(x, ...) {
  finish_glance(tibble(edf = x$edf), x)
}

#' @rdname ordinal_tidiers
#' @export
augment.polr <- function(x, data = stats::model.frame(x),
                         newdata, type.predict = c("probs", "class"), ...) {
  type.predict <- match.arg(type.predict)
  augment.lm(x, data, newdata, type.predict, ...)
}
