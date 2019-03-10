#' @templateVar class clm
#' @template title_desc_tidy
#' 
#' @param x A `clmm` object returned from [ordinal::clmm()].
#' @template param_confint
#' @template param_exponentiate
#' @template param_quick
#' @template param_unused_dots
#' @param conf.type Which type of confidence interval to use. Passed to the
#'   `type` argument of [ordinal::confint.clm()]. Defaults to `"profile`.
#'   
#' @examples
#' 
#' library(ordinal)
#'  
#' clmm_mod <- clmm(rating ~ temp + contact + (1 | judge), data = wine)
#' 
#' tidy(clmm_mod)
#' glance(clmm_mod)
#' 
#' clmm_mod2 <- clmm(rating ~ temp + (1 | judge), nominal = ~ contact, data = wine)
#' tidy(clmm_mod2)
#'  
#' 
#' @evalRd return_tidy(regression = TRUE)
#'
#' @aliases  ordinal_tidiers
#' @export
#' @seealso [tidy], [ordinal::clm()], [ordinal::clmm()]
#' @family ordinal tidiers
tidy.clm <- function(x, conf.int = FALSE, conf.level = .95,
                     exponentiate = FALSE,
                     conf.type = c("profile", "Wald"), ...) {
  
  conf.type <- rlang::arg_match(conf.type)
  
  co <- coef(summary(x))
  nn <- c("estimate", "std.error", "statistic", "p.value")
  ret <- fix_data_frame(co, nn[seq_len(ncol(co))])
  process_clm(
    ret, x,
    conf.int = conf.int, conf.level = conf.level,
    exponentiate = exponentiate, conf.type = conf.type
  )
}

#' @rdname ordinal_tidiers
#' @export
glance.clm <- function(x, ...) {
  tibble(
    edf = x$edf,
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    logLik = stats::logLik(x),
    df.residual = stats::df.residual(x),
    nobs = stats::nobs(x)
  )
}

#' @rdname ordinal_tidiers
#' @export
glance.clmm <- function(x, ...) {
  tibble(
    edf = x$edf,
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    logLik = stats::logLik(x),
    nobs = stats::nobs(x)
  )
}

#' @param type.predict type of prediction to compute for a CLM; passed on to
#' [ordinal::predict.clm()] or `predict.polr`
#' @rdname ordinal_tidiers
#' @export
augment.clm <- function(x, data = model.frame(x), newdata = NULL,
                        type.predict = c("prob", "class"), ...) {
  type.predict <- rlang::arg_match(type.predict)
  augment_columns(x, data, newdata, type = type.predict)
}

process_clm <- function(ret, x, conf.int = FALSE, conf.level = .95,
                        exponentiate = FALSE, conf.type = "profile") {
  if (exponentiate) {
    trans <- exp
  } else {
    trans <- identity
  }
  
  if (conf.int) {
    CI <- suppressMessages(
      trans(stats::confint(x, level = conf.level, type = conf.type))
    )
    colnames(CI) <- c("conf.low", "conf.high")
    CI <- as.data.frame(CI)
    CI$term <- rownames(CI)
    
    ret$orig_row_order <- seq_len(nrow(ret))
    ret <- merge(ret, unrowname(CI), by = "term", all.x = TRUE)
    ret <- ret[order(ret$orig_row_order),]
    ret$orig_row_order <- NULL
  }
  
  ret$estimate <- trans(ret$estimate)
  ## make sure original order hasn't changed
  if (!identical(ret$term,c(names(x$alpha),names(x$beta),names(x$zeta)))) {
    stop("row order changed; please contact maintainers")
  }
  ret$coefficient_type <- rep(c("alpha","beta","zeta"),
                              vapply(x[c("alpha","beta","zeta")],
                                     length, numeric(1)))
  as_tibble(ret)
}
