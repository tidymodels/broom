#' @templateVar class drc
#' @template title_desc_tidy
#'
#' @param x A `drc` object produced by a call to [drc::drm()].
#' @template param_confint
#' @template param_unused_dots
#' @param quick whether to compute a smaller and faster version, containing
#' only the \code{term}, \code{curveid} and \code{estimate} columns.
#' @evalRd return_tidy(   
#'       curveid = "Id of the curve",   
#'       "term",
#'       "estimate",
#'       "std.error",
#'       "statistic",
#'       "p.value",
#'       "conf.low",
#'       "conf.high"
#' )
#' @details The tibble has one row for each curve and term in the regression. The
#'   `curveid` column indicates the curve.
#' @author Eduard Szoecs, \email{eduardszoecs@@gmail.com}
#' @examples 
#' library(drc)
#' mod <- drm(dead/total~conc, type, 
#'    weights = total, data = selenium, fct = LL.2(), type = "binomial")
#' mod
#' 
#' tidy(mod)
#' tidy(mod, conf.int = TRUE)
#' tidy(mod, quick = TRUE)

#' glance(mod)

#' # augment(mod)
#' @export
#' @seealso [tidy()], [drc::drm()]
#' @family drc tidiers
#' @aliases drc_tidiers
tidy.drc <- function(x, conf.int = FALSE, conf.level = 0.95, quick = FALSE, ...) {
  if (quick) {
    co <- coef(x)
    nam <- names(co)
    term <- gsub("^(.*):(.*)$", "\\1", nam)
    curves <- x[["dataList"]][["curveid"]]
    if (length(unique(curves)) > 1) {
      curveid <- gsub("^(.*):(.*)$", "\\2", nam)
    } else {
      curveid <- unique(curves)
    }
    ret <- tibble(term = term,
                      curveid = curveid,
                      estimate = unname(co))
    return(ret)
  }

  co <- coef(summary(x))

  nam <- rownames(co)
  term <- gsub("^(.*):(.*)$", "\\1", nam)
  curves <- x[["dataList"]][["curveid"]]
  if (length(unique(curves)) > 1) {
    curveid <- gsub("^(.*):(.*)$", "\\2", nam)
  } else {
    curveid <- unique(curves)
  }
  ret <- data.frame(term = term,
                    curveid = curveid,
                    co, stringsAsFactors = FALSE)
  names(ret) <- c("term", "curveid", "estimate", "std.error", "statistic",
    "p.value")
  rownames(ret) <- NULL

  if (conf.int) {
    conf <- confint(x, level = conf.level)
    colnames(conf) <- c("conf.low", "conf.high")
    rownames(conf) <- NULL
    ret <- cbind(ret, conf)
  }

  return(as_tibble(ret))
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
  ret <- data.frame(AIC = AIC(x),
                    BIC = BIC(x),
                    logLik = logLik(x),
                    df.residual =  x$df.residual)
  return(as_tibble(ret))
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
#' @evalRd return_augment(".conf.low" = "Lower Confidence Interval",
#'   ".conf.high" = "Upper Confidence Interval",
#'   ".se.fit",
#'   ".fitted",
#'   ".resid",
#'   ".cooksd")
#' 
#' @seealso [augment()], [drc::drm()]
#' @export
#' @author Eduard Szoecs, \email{eduardszoecs@@gmail.com}
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