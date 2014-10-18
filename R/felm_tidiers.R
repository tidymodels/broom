#' Tidying methods for a models with multiple group fixed effects
#' 
#' These methods tidy the coefficients of a linear model with multiple group fixed effects
#'
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#'
#' @name felm_tidiers
#' 
#' @param x lm object
#' @param data Original data, defaults to the extracting it from the model
#'

#' N=1e2
#' DT <- data.frame(
#'   id = sample(5, N, TRUE),
#'   v1 =  sample(5, N, TRUE),                          # int in range [1,5]
#'   v2 =  sample(1e6, N, TRUE),                        # int in range [1,1e6]
#'   v3 =  sample(round(runif(100,max=100),4), N, TRUE), # numeric e.g. 23.5749
#'   v4 =  sample(round(runif(100,max=100),4), N, TRUE) # numeric e.g. 23.5749
#' )
#' 
#' result_felm <- felm(v2~v3, DT)
#' tidy(result_felm)
#' augment(result_felm)
#' result_felm <- felm(v2~v3|id+v1, DT)
#' tidy(result_felm)
#' augment(result_felm)
#' v1<-DT$v1
#' v2 <- DT$v2
#' v3 <- DT$v3
#' id <- DT$id
#' result_felm <- felm(v2~v3|id+v1)
#' tidy(result_felm)
#' augment(result_felm)
NULL


#' @rdname felm_tidiers
#' 
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level of the interval, used only if
#' \code{conf.int=TRUE}#' 
#' @details If \code{conf.int=TRUE}, the confidence interval is computed with
#' the \code{\link{confint}} function.
#' 
#' @return \code{tidy.lm} returns one row for each coefficient, with five columns:
#'   \item{term}{The term in the linear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{stderror}{The standard error from the linear model}
#'   \item{statistic}{t-statistic}
#'   \item{p.value}{two-sided p-value}
#' 
#' If \code{cont.int=TRUE}, it also includes columns for \code{conf.low} and
#' \code{conf.high}, computed with \code{\link{confint}}.
#' 
#' @export
tidy.felm <- function(x, conf.int=FALSE, conf.level=.95, fe = FALSE, fe.error = fe, ...) {
    nn <- c("estimate", "stderror", "statistic", "p.value")
    ret <- fix_data_frame(coef(summary(x)), nn)
    trans <- identity

    if (conf.int) {
        # avoid "Waiting for profiling to be done..." message
        CI <- suppressMessages(confint(x, level = conf.level))
        colnames(CI) = c("conf.low", "conf.high")
        ret <- cbind(ret, trans(unrowname(CI)))
    }

    if (fe){
      ret <- mutate(ret, N = NA, comp = NA)
      object <- getfe(x)
      print(fe.error)
      if (fe.error){
        nn <- c("estimate", "stderror", "N", "comp")
        ret_fe <- getfe(x) %>%
                  btrap(x) %>%
                  select(effect, se, obs, comp) %>%
                  fix_data_frame(nn) %>%
                  mutate(statistic = estimate/(stderror/sqrt(N))) %>%
                  mutate(p.value = 2*pnorm(statistic)-1) 
      } else{
        nn <- c("estimate", "N", "comp")
        ret_fe <- getfe(x) %>%
                  select(effect, obs, comp) %>%
                  fix_data_frame(nn)  %>% 
                  mutate(statistic = NA, p.value = NA) 
      }
      ret <- rbind(ret, ret_fe)
    }
    ret$estimate <- trans(ret$estimate)
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
#'   Columns with prefix \item{.fe_} for fixed effects
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
    object <-  getfe(x)
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
                              statistic=fstat[1],   
                              p.value = pval,                
                              df=df,
                              df.residual = rdf, 
                              ))
    ret
}
