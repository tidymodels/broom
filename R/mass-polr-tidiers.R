
#' @rdname ordinal_tidiers
#' @export
#' @examples
#' 
#' library(MASS)
#' data(housing)
#' mod <- polr(Sat ~ Infl + Type + Cont, weights = Freq, data = housing)    
#' tidy(mod)
#' glance(mod)
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
    if (!is.matrix(CI)) {
      CI <- rbind(CI)
      rownames(CI) <- names(coef(x))
    }
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
#' @evalRd return_glance(
#'  "edf",
#'  "logLik",
#'  "AIC",
#'  "BIC",
#'  "deviance",
#'  "df.residual",
#'  "nobs"
#' )
#' @export
glance.polr <- function(x, ...) {
  ret <- tibble(edf = x$edf,
                logLik = as.numeric(stats::logLik(x)),
                AIC = stats::AIC(x),
                BIC = stats::BIC(x),
                deviance = stats::deviance(x),
                df.residual = stats::df.residual(x),
                nobs = stats::nobs(x)
                )
  ret
}

#' @rdname ordinal_tidiers
#' @export
augment.polr <- function(x, data = model.frame(x), newdata = NULL,
                         type.predict = c("probs", "class"), ...) {
  type <- rlang::arg_match(type.predict)
  augment_columns(x, data, newdata, type = type.predict)
}
