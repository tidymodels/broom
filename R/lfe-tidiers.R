#' @templateVar class felm
#' @template title_desc_tidy
#'
#' @param x A `felm` object returned from [lfe::felm()].
#' @template param_confint
#' @template param_quick
#' @param fe Logical indicating whether or not to include estimates of
#'   fixed effects. Defaults to `FALSE`.
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'   
#' @examples
#' 
#' library(lfe)
#' 
#' N=1e2
#' DT <- data.frame(
#'   id = sample(5, N, TRUE),
#'   v1 =  sample(5, N, TRUE),
#'   v2 =  sample(1e6, N, TRUE),
#'   v3 =  sample(round(runif(100,max=100),4), N, TRUE),
#'   v4 =  sample(round(runif(100,max=100),4), N, TRUE)
#' )
#'
#' result_felm <- felm(v2~v3, DT)
#' tidy(result_felm)
#' augment(result_felm)
#' 
#' result_felm <- felm(v2~v3|id+v1, DT)
#' tidy(result_felm, fe = TRUE)
#' augment(result_felm)
#' 
#' v1<-DT$v1
#' v2 <- DT$v2
#' v3 <- DT$v3
#' id <- DT$id
#' result_felm <- felm(v2~v3|id+v1)
#' 
#' tidy(result_felm)
#' augment(result_felm)
#' glance(result_felm)
#'
#' @export
#' @aliases felm_tidiers lfe_tidiers
#' @family felm tidiers
#' @seealso [tidy()], [lfe::felm()]
tidy.felm <- function(x, conf.int = FALSE, conf.level = .95, fe = FALSE, quick = FALSE, ...) {

  has_multi_response <- length(x$lhs) > 1
  
  if(quick) {
    co <- stats::coef(x)
    if(has_multi_response) {
      ret <- co <- stats::coef(x) %>%  
        as_tibble(rownames = "term") %>% 
        tidyr::gather(response, estimate, -term) %>% 
        select(response, term, estimate) 
    } else {
      ret <- data_frame(term = names(co), estimate = unname(co))  
    }
    
  } else {
    nn <- c("estimate", "std.error", "statistic", "p.value")
    if(has_multi_response) {
      ret <-  map_df(x$lhs, function(y) stats::coef(summary(x, lhs = y)) %>% 
               fix_data_frame(nn) %>% 
               mutate(response = y)) %>% 
        select(response, everything())
      
    } else {
      ret <- fix_data_frame(stats::coef(summary(x)), nn)  
    }
  }
  

  if (!quick & conf.int) {
    # avoid "Waiting for profiling to be done..." message
    CI <- suppressMessages(stats::confint(x, level = conf.level))
    colnames(CI) <- c("conf.low", "conf.high")
    ret <- cbind(ret, unrowname(CI))
  }

  if (fe) {
    ret <- mutate(ret, N = NA, comp = NA)
    if(quick) {
      ret_fe_prep <- lfe::getfe(x) %>% 
        tibble::rownames_to_column(var = "term") 
      if(has_multi_response) ret_fe_prep <-  ret_fe_prep %>% 
          tidyr::gather(response, effect, starts_with("effect.")) %>% 
          mutate(response = stringr::str_remove(response, "effect."))
      
      ret_fe <-  ret_fe_prep%>%
        select(contains("response"), term, effect, obs, comp) %>%
        rename(N = obs,
               estimate = effect)
    } else {
      nn <- c("estimate", "std.error", "N", "comp")
      ret_fe_prep <- lfe::getfe(x, se = TRUE, bN = 100) %>% 
        tibble::rownames_to_column(var = "term") %>% 
        select(term, contains("effect"),  contains("se"), obs, comp) %>% # effect and se are multiple if multiple y
        rename(N=obs) 
      
      if(has_multi_response) {
        ret_fe_prep <-  ret_fe_prep  %>% 
          tidyr::gather(key = "stat_resp", value, starts_with("effect."), starts_with("se.")) %>% 
          tidyr::separate(col = "stat_resp", c("stat", "response"), sep="\\.") %>% 
          tidyr::spread(key = "stat", value) 
        # nn <-  c("response", nn)
      }
      ret_fe <-  ret_fe_prep %>%
        rename(estimate = effect, std.error = se) %>% 
        select(contains("response"), everything()) %>%
        # fix_data_frame(nn) %>%
        mutate(statistic = estimate / std.error) %>%
        mutate(p.value = 2 * (1 - stats::pt(statistic, df = N)))  
    }
    
    if (!quick & conf.int) {
      
      crit_val_low <- stats::qnorm(1 - (1 - conf.level) / 2)
      crit_val_high <- stats::qnorm(1 - (1 - conf.level) / 2)
      
      ret_fe <- ret_fe %>%
        mutate(
          conf.low = estimate - crit_val_low * std.error,
          conf.high = estimate +  crit_val_high * std.error
        )
    }
    ret <- rbind(ret, ret_fe)
  }
  as_tibble(ret)
}

#' @templateVar class felm
#' @template title_desc_augment
#' 
#' @inherit tidy.felm params examples
#' @template param_data 
#' 
#' @evalRd return_augment()
#' 
#' @export
#' @family felm tidiers
#' @seealso [augment()], [lfe::felm()]
augment.felm <- function(x, data = model.frame(x), ...) {
  has_multi_response <- length(x$lhs) > 1
  
  if(has_multi_response) {
    stop(
      "Augment does not support linear models with multiple responses.",
      call. = FALSE
    )  
  } 
  df <- as_broom_tibble(data)
  mutate(df, .fitted = x$fitted.values, .resid = x$residuals)
  
  
}

#' @templateVar class felm
#' @template title_desc_glance
#' 
#' @inherit tidy.felm params examples
#' 
#' @evalRd return_glance(
#'   "r.squared",
#'   "adj.r.squared",
#'   "sigma",
#'   "statistic",
#'   "p.value",
#'   "df",
#'   "df.residual",
#'   "nobs"
#' )
#'
#' @export
glance.felm <- function(x, ...) {
  
  has_multi_response <- length(x$lhs) > 1
  
  if(has_multi_response) {
    stop(
      "Glance does not support linear models with multiple responses.",
      call. = FALSE
    )  
  } 
  ret <- with(
    summary(x),
    tibble(
      r.squared = r2,
      adj.r.squared = r2adj,
      sigma = rse,
      statistic = fstat,
      p.value = pval,
      df = df[1],
      df.residual = rdf,
      nobs = stats::nobs(x)
  ))
  ret
}
