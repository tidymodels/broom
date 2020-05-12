#' @templateVar class drc
#' @template title_desc_tidy
#'
#' @param x A `drc` object produced by a call to [drc::drm()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(   
#'   curve = "Index identifying the curve.",
#'   regression = TRUE
#' )
#' 
#' @details The tibble has one row for each curve and term in the regression.
#'   The `curveid` column indicates the curve.
#'  
#' @examples 
#' 
#' library(drc)
#' 
#' mod <- drm(dead/total~conc, type, 
#'    weights = total, data = selenium, fct = LL.2(), type = "binomial")
#' 
#' tidy(mod)
#' tidy(mod, conf.int = TRUE)
#' 
#' glance(mod)
#' 
#' augment(mod, selenium)
#' 
#' 
#' @export
#' @seealso [tidy()], [drc::drm()]
#' @family drc tidiers
#' @aliases drc_tidiers
tidy.drc <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
  
  ret <- coef(summary(x))
  ret <- as_tibble(ret, rownames = "term")
  names(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")

  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }
  
  tidyr::separate(ret, term, c("term", "curve"))
}

#' @templateVar class drc
#' @template title_desc_glance
#' 
#' @inherit tidy.drc params examples
#' @template param_unused_dots
#' 
#' @evalRd return_glance(
#'   "logLik", 
#'   "AIC",
#'   "AICc" = "AIC corrected for small samples",
#'   "BIC",
#'   "df.residual"
#' )
#' @seealso [glance()], [drc::drm()]
#' @export
#' @family drc tidiers
glance.drc <- function(x, ...) {
  tibble(
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    logLik = stats::logLik(x),
    df.residual =  x$df.residual
  )
}

#' @templateVar class drc
#' @template title_desc_augment

#' @inherit tidy.drc params examples
#' @template param_data
#' @template param_newdata
#' @template param_confint
#' @template param_se_fit
#' @template param_unused_dots
#'
#' @evalRd return_augment(
#'   ".conf.low",
#'   ".conf.high",
#'   ".se.fit",
#'   ".fitted",
#'   ".resid",
#'   ".cooksd"
#' )
#' 
#' @seealso [augment()], [drc::drm()]
#' @export
#' 
#' @family drc tidiers
augment.drc <- function(x, data = NULL, newdata = NULL,
  se_fit = FALSE,  conf.int = FALSE, conf.level = 0.95, ...) {

  if (is.null(data) && is.null(newdata)) {
    stop("Must specify either `data` or `newdata` argument.", call. = FALSE)
  }

  # drc doesn't like tibbles
  if (inherits(newdata, "tbl")) {
    newdata <- data.frame(newdata)
  }

  # drc doesn't like NA in the type
  if (!missing(newdata) || is.null(newdata)) {
    original <- newdata
    original$.rownames <- rownames(original)
  }

  if (!missing(newdata) && x$curveVarNam %in% names(newdata) && 
    any(is.na(newdata[[x$curveVarNam]]))) {
      newdata <- newdata[!is.na(newdata[[x$curveVarNam]]), ]
  }

  ret <- augment_columns(x, data, newdata, se.fit = FALSE)

  if (!is.null(newdata)) {
    if (conf.int) {
      preds <- data.frame(predict(x, newdata = newdata, interval = "confidence",
        level = conf.level))
      ret[[".conf.low"]] <- preds[["Lower"]]
      ret[[".conf.high"]] <- preds[["Upper"]]
    }
    if (se_fit) {
      preds <- data.frame(predict(x, newdata = newdata, se.fit = TRUE))
      ret[[".se.fit"]] <- preds[["SE"]]
    }
  }

  # join back removed rows
  if (!".rownames" %in% names(ret)) {
    ret$.rownames <- rownames(ret)
  }

  if (!is.null(original)) {
    reto <- ret %>% select(starts_with("."))
    ret <- merge(reto, original, by = ".rownames", all.y = TRUE)
  }

  # reorder to line up with original
  ret <- ret[order(match(ret$.rownames, rownames(original))), ]
  rownames(ret) <- NULL

  # if rownames are just the original 1...n, they can be removed
  if (all(ret$.rownames == seq_along(ret$.rownames))) {
    ret$.rownames <- NULL
  }

  as_tibble(ret)
}
