#' Tidying methods for models with multiple group fixed effects
#' 
#' These methods tidy the coefficients of a linear model with multiple group fixed effects
#'
#' @template boilerplate
#'
#' @name felm_tidiers
#' 
#' @param x felm object
#' @param data Original data, defaults to extracting it from the model
#' @examples
#' 
#' if (require("lfe", quietly = TRUE)) {
#'     N=1e2
#'     DT <- data.frame(
#'       id = sample(5, N, TRUE),
#'       v1 =  sample(5, N, TRUE),                          
#'       v2 =  sample(1e6, N, TRUE),                        
#'       v3 =  sample(round(runif(100,max=100),4), N, TRUE),
#'       v4 =  sample(round(runif(100,max=100),4), N, TRUE) 
#'     )
#'     
#'     result_felm <- felm(v2~v3, DT)
#'     tidy(result_felm)
#'     augment(result_felm)
#'     result_felm <- felm(v2~v3|id+v1, DT)
#'     tidy(result_felm, fe = TRUE)
#'     augment(result_felm)
#'     v1<-DT$v1
#'     v2 <- DT$v2
#'     v3 <- DT$v3
#'     id <- DT$id
#'     result_felm <- felm(v2~v3|id+v1)
#'     tidy(result_felm)
#'     augment(result_felm)
#'     glance(result_felm)
#' }
NULL


#' @rdname felm_tidiers
#' 
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level of the interval, used only if
#' \code{conf.int=TRUE}
#' @param fe whether to include estimates of fixed effects
#' @param fe.error whether to include standard error of fixed effects
#' 
#' @details If \code{conf.int=TRUE}, the confidence interval is computed 
#' 
#' @return \code{tidy.felm} returns one row for each coefficient. If \code{fe=TRUE}, it also includes rows for for fixed effects estimates. 
#' There are five columns:
#'   \item{term}{The term in the linear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error from the linear model}
#'   \item{statistic}{t-statistic}
#'   \item{p.value}{two-sided p-value}
#' 
#' If \code{cont.int=TRUE}, it also includes columns for \code{conf.low} and \code{conf.high}, computed with \code{\link{confint}}.
#' @export
tidy.felm <- function(x, conf.int=FALSE, conf.level=.95, fe = FALSE, fe.error = fe, ...) {
    nn <- c("estimate", "std.error", "statistic", "p.value")
    ret <- fix_data_frame(coef(summary(x)), nn)

    if (conf.int) {
        # avoid "Waiting for profiling to be done..." message
        CI <- suppressMessages(confint(x, level = conf.level))
        colnames(CI) = c("conf.low", "conf.high")
        ret <- cbind(ret, unrowname(CI))
    }

    if (fe){
      ret <- mutate(ret, N = NA, comp = NA)
      object <- lfe::getfe(x)
      if (fe.error){
        nn <- c("estimate", "std.error", "N", "comp")
        ret_fe <- lfe::getfe(x, se = TRUE, bN = 100) %>%
                  select(effect, se, obs, comp) %>%
                  fix_data_frame(nn) %>%
                  mutate(statistic = estimate/std.error) %>%
                  mutate(p.value = 2*(1-pt(statistic, df = N))) 
      } else{
        nn <- c("estimate", "N", "comp")
        ret_fe <- lfe::getfe(x) %>%
                  select(effect, obs, comp) %>%
                  fix_data_frame(nn)  %>% 
                  mutate(statistic = NA, p.value = NA) 
      }
      if (conf.int){
        ret_fe <- ret_fe %>%
                  mutate(conf.low=estimate-qnorm(1-(1-conf.level)/2)*std.error,
                         conf.high=estimate+qnorm(1-(1-conf.level)/2)*std.error
                         )
      }
      ret <- rbind(ret, ret_fe)
    }  
    ret
}

# Things it does not do (no simple way to get it)
# 1. does not work if new data
# 2. does not give SE of the fit
#' @rdname felm_tidiers
#' @return  \code{augment.felm} returns  one row for each observation, with multiple columns added to the original data:
#'   \item{.fitted}{Fitted values of model}
#'   \item{.resid}{Residuals}
#'   If fixed effect are present,  
#'   \item{.comp}{Connected component}
#'   \item{.fe_}{Fixed effects (as many columns as factors)} 
#' @export
augment.felm <- function(x, data = NULL, ...) {
    if (is.null(data)){
        if (is.null(x$call$data)){
            list <- lapply(all.vars(x$call$formula), as.name)
            data <- eval(as.call(list(quote(data.frame),list)), parent.frame())
        } else{
            data <- eval(x$call$data,parent.frame())
        }
        if (!is.null(x$na.action)){
          data <- slice(data,- as.vector(x$na.action))
        }
    }    
    data <- fix_data_frame(data, newcol = ".rownames")
    y <- eval(x$call$formula[[2]], envir = data)
    data$.fitted <- x$fitted.values
    data$.resid <- x$residuals
    object <-  lfe::getfe(x)
    if (!is.null(object)){
        fe_list <- levels(object$fe)
        object <- object %>% mutate(effect = as.numeric(effect))%>% mutate(fe = as.character(fe))
        length <- length(object)
            for (fe in names(x$fe)){
            if ("xnam" %in% names(attributes(x$fe[[fe]]))){
                factor_name <- attributes(x$fe[[fe]])$fnam
            } else{
                factor_name <- fe
            }
           formula1 <- as.formula(paste0("~fe==","\"",fe,"\""))
           ans <- object %>% filter_(formula1)
          if (is.character(data[,factor_name])){
            ans <-  ans %>% mutate_(.dots = setNames(list(~as.character(idx)), factor_name))
          } else if (is.numeric(data[,factor_name])){
            ans <- ans %>% mutate_(.dots = setNames(list(~as.numeric(as.character(idx))), factor_name))
          } else{
            ans <- ans %>% mutate_(.dots = setNames(list(~idx), factor_name))
            }

          if (fe==names(x$fe)[1]){
            ans <- select_(ans, .dots= c("effect", "comp", "obs", factor_name))
            names(ans) <- c(paste0(".fe.",fe), ".comp", ".obs", factor_name)
          }
          else{
            ans <- select_(ans, .dots= c("effect", factor_name))
            names(ans) <- c(paste0(".fe.",fe), factor_name)
          }
          data <- left_join(data, ans , factor_name)
        }
    }
    return(data)
}




#' @rdname felm_tidiers
#' 
#' @param ... extra arguments (not used)
#' 
#' @return \code{glance.lm} returns a one-row data.frame with the columns
#'   \item{r.squared}{The percent of variance explained by the model}
#'   \item{adj.r.squared}{r.squared adjusted based on the degrees of freedom}
#'   \item{sigma}{The square root of the estimated residual variance}
#'   \item{statistic}{F-statistic}
#'   \item{p.value}{p-value from the F test}
#'   \item{df}{Degrees of freedom used by the coefficients}
#'   \item{df.residual}{residual degrees of freedom}
#' 
#' @export
glance.felm <- function(x, ...) {
    s <- summary(x)
    ret <- with(s, data.frame(r.squared=r2,
                              adj.r.squared=r2adj,
                              sigma = rse,
                              statistic=fstat,   
                              p.value = pval,                
                              df=df[1],
                              df.residual = rdf
                              ))
    ret
}
