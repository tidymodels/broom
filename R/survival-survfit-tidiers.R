#' @templateVar class survfit
#' @template title_desc_tidy
#'
#' @param x An `survfit` object returned from [survival::survfit()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy(
#'   "time",
#'   "n.risk",
#'   "n.event",
#'   "n.censor",
#'   estimate = "estimate of survival or cumulative incidence rate when
#'     multistate",
#'   "std.error",
#'   "conf.low",
#'   "conf.high",
#'   state = "state if multistate survfit object input",
#'   strata = "strata if stratified survfit object input"
#' )
#' 
#' @examples 
#' 
#' library(survival)
#' cfit <- coxph(Surv(time, status) ~ age + sex, lung)
#' sfit <- survfit(cfit)
#'
#' tidy(sfit)
#' glance(sfit)
#'
#' library(ggplot2)
#' ggplot(tidy(sfit), aes(time, estimate)) + geom_line() +
#'     geom_ribbon(aes(ymin=conf.low, ymax=conf.high), alpha=.25)
#'
#' # multi-state
#' fitCI <- survfit(Surv(stop, status * as.numeric(event), type = "mstate") ~ 1,
#'               data = mgus1, subset = (start == 0))
#' td_multi <- tidy(fitCI)
#' td_multi
#' 
#' ggplot(td_multi, aes(time, estimate, group = state)) +
#'     geom_line(aes(color = state)) +
#'     geom_ribbon(aes(ymin = conf.low, ymax = conf.high), alpha = .25)
#'
#' @aliases survfit_tidiers
#' @export
#' @seealso [tidy()], [survival::survfit()]
#' @family survfit tidiers
#' @family survival tidiers
#' 
tidy.survfit <- function(x, ...) {
  if (inherits(x, "survfitms")) {
    
    # c() coerces to vector
    ret <- data.frame(
      time = x$time,
      n.risk = c(x$n.risk),
      n.event = c(x$n.event),
      n.censor = c(x$n.censor),
      estimate = c(x$pstate),
      std.error = c(x$std.err),
      conf.high = c(x$upper),
      conf.low = c(x$lower),
      state = rep(x$states, each = nrow(x$pstate))
    )
    
    ret <- ret[ret$state != "", ]
  } else {
    ret <- data.frame(
      time = x$time,
      n.risk = x$n.risk,
      n.event = x$n.event,
      n.censor = x$n.censor,
      estimate = x$surv,
      std.error = x$std.err,
      conf.high = x$upper,
      conf.low = x$lower
    )
  }
  # strata are automatically recycled if there are multiple states
  if (!is.null(x$strata)) {
    ret$strata <- rep(names(x$strata), x$strata)
    
    # Pull out strata names
    # Finds one of three possible patterns:
    # 1. Beginning of the string until an equals sign (first stratum)
    # 2. From a ", " string to an equals sign (middle strata)
    # 3. From a ", " string to the end of the string (last stratum)
    strata_names <- stringr::str_extract_all(
      ret$strata,
      pattern = "^[^\\=]*(?=\\=)|(?<=, )[^\\=]*(?=\\=)|(?<= ,)[^\\=]$"
    )
    
    # A series of tests makes sure that the parser will work correctly.  If any
    # of them fail, the function gives a warning and does not create any parsed
    # columns in ret.
    
    # Test that all strata names are the same
    if (all(duplicated.default(strata_names)[-1])) {
      
      # Test that there are the appropriate number of "="
      n_strata <- as.integer(length(strata_names[[1]]))
      if (all(stringr::str_count(ret$strata, stringr::fixed("=")) == n_strata)) {
        
        # Test that there are the appropriate number of ","
        if (all(stringr::str_count(ret$strata, stringr::fixed(",")) == n_strata - 1L)) {
          
          # Extract values into the return dataset.
          # Finds two possible patterns:
          # 1. From an equals sign to a comma (i.e., when this isn't the last stratum)
          # 2. From an equals sign to the end of the string (i.e., when this is the last stratum)
          # Also trims any whitespace
          ret[, strata_names[[1]]] <- as.data.frame(
            apply(
              stringr::str_extract_all(
                ret$strata,
                pattern = "(?<=\\=)[^,]*(?=,)|(?<=\\=)[^,]*$",
                simplify = TRUE
              ),
              MARGIN = 2,
              FUN = stringr::str_trim
              ),
            stringsAsFactors = FALSE
            )
          
        } else {
          warning("Could not automatically detect strata names.  Found a \",\" in a strata name or value.")
        }
        
      } else {
        warning("Could not automatically detect strata names.  Found an \"=\" in a strata name or value.")
      }
      
    } else {
      warning("Could not automatically detect strata names.  Please parse manually.")
    }
  }
  as_tibble(ret, validate = FALSE)
}

#' @templateVar class survfit
#' @template title_desc_glance
#' 
#' @inherit tidy.survfit params examples
#' 
#' @evalRd return_glance(
#'   "records",
#'   "n.max",
#'   "n.start",
#'   "events",
#'   "rmean",
#'   "rmean.std.error",
#'   conf.low = "lower end of confidence interval on median",
#'   conf.high = "upper end of confidence interval on median",
#'   median = "median survival",
#'   "nobs"
#' )
#' 
#' @export
#' @seealso [glance()], [survival::survfit()]
#' @family cch tidiers
#' @family survival tidiers
#' 
glance.survfit <- function(x, ...) {
  if (inherits(x, "survfitms")) {
    stop("Cannot construct a glance of a multi-state survfit object.")
  }
  if (!is.null(x$strata)) {
    stop("Cannot construct a glance of a multi-strata survfit object.")
  }
  
  s <- summary(x)
  ret <- unrowname(as.data.frame(t(s$table)))
  
  colnames(ret) <- dplyr::recode(
    colnames(ret),
    "*rmean" = "rmean",
    "*se(rmean)" = "rmean.std.error"
  )
  
  colnames(ret)[utils::tail(seq_along(ret), 2)] <- c("conf.low", "conf.high")

  ret$nobs <- stats::nobs(x)

  as_tibble(ret)
}
