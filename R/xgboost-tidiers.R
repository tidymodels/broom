#' Extract xgboost importance table
#'
#' @param model an xgb.Booster object
#' @param ... arguments to be passed to xgboost::xgb.importance()
#'
#' @return tibble::tibble() containing gain, cover, frequency for each feature.
xgb_feature_importance <- function(model, ...) {
  if ("feature_names" %in% names(model)) {
    base_table <- tibble::tibble(feature = model[["feature_names"]])
    statistics <- xgboost::xgb.importance(model = model, ...)
    names(statistics) <- tolower(names(statistics))
    
    ret <- base_table %>% 
      dplyr::left_join(y = statistics, by = "feature") %>% 
      dplyr::mutate_if(is.numeric, function(x) tidyr::replace_na(x, replace = 0))
  } else {
    ret <- xgboost::xgb.importance(model = model, ...) %>% 
      tibble::as_tibble() %>% 
      dplyr::rename_all(tolower)
  }
  
  ret
}

#' Extract xgboost tree structure
#'
#' @param model an xgb.Booster object
#' @param ... arguments to be passed to xgboost::xgb.model.dt.tree()
#'
#' @return tibble::tibble() containing the tree structure - one row per split decision
xgb_trees <- function(model, ...) {
  ret <- xgboost::xgb.model.dt.tree(model = model, ...) %>% 
    tibble::as_tibble() %>% 
    dplyr::rename_all(tolower)
  
  ret
}

#' @templateVar class xgb.Booster
#' @template title_desc_tidy
#'
#' @param x an xgb.Booster object
#' @param type result to return - either \code{feature_importance} for the
#'   importance table, or \code{trees} for the tree structure. Default
#'   \code{feature_importance}.
#' @param ... additional arguments to pass to \code{xgboost::xgb.importance}
#'   (when \code{type = 'feature_importance'}) or
#'   \code{xgboost::xgb.model.dt.tree} (when \code{type = 'trees'}).
#'
#' @return A tibble::tibble containing the relevant components of the model.
#' @export
#'
#' @examples
#' 
#' mdl <- copy(iris)
#' features <- setdiff(names(iris), "Species")
#' mdl[['Species']] <- as.integer(mdl[['Species']]) - 1
#' dtrain <- xgb.DMatrix(as.matrix(mdl[1:120, features]), label = mdl[['Species']][1:120])
#' dvalidate <- xgb.DMatrix(as.matrix(mdl[121:150, features]), label = mdl[['Species']][121:150])
#' xgb_params <- list(
#'   objective = 'multi:softmax', 
#'   eval_metric = c('mlogloss', 'merror'), 
#'   num_class = 3
#' )
#' fit <- xgb.train(
#'   data = dtrain, 
#'   params = xgb_params, 
#'   watchlist = list(train = dtrain, validate = dvalidate), 
#'   nrounds = 50, 
#'   early_stopping_rounds = 5, 
#'   verbose = 0
#' )
#' tidy(fit, type = "feature_importance")
#' tidy(fit, type = "trees")
#' 
#' @seealso [xgboost::xgb.train()], [xgboost:xgboost()]
tidy.xgb.Booster <- function(x, type = c("feature_importance", "trees"), ...) {
  type <- rlang::arg_match(type)
  switch(
    EXPR = type[1],
    "feature_importance" = xgb_feature_importance(x, ...),
    "trees" = xgb_trees(x, ...)
  )
}

#' @templateVar class xgb.Booster
#' @template title_desc_tidy
#'
#' @param x an xgb.Booster object
#'
#' @return A summary of evaluation metric results for at the last iteration of the xgb.Booster object, and, if \code{early_stopping_rounds} was specified during training, the results at the best iteration.
#' @export
#'
#' @examples
#' 
#' mdl <- copy(iris)
#' features <- setdiff(names(iris), "Species")
#' mdl[['Species']] <- as.integer(mdl[['Species']]) - 1
#' dtrain <- xgb.DMatrix(as.matrix(mdl[1:120, features]), label = mdl[['Species']][1:120])
#' dvalidate <- xgb.DMatrix(as.matrix(mdl[121:150, features]), label = mdl[['Species']][121:150])
#' xgb_params <- list(
#'   objective = 'multi:softmax', 
#'   eval_metric = c('mlogloss', 'merror'), 
#'   num_class = 3
#' )
#' fit <- xgb.train(
#'   data = dtrain, 
#'   params = xgb_params, 
#'   watchlist = list(train = dtrain, validate = dvalidate), 
#'   nrounds = 50, 
#'   early_stopping_rounds = 5, 
#'   verbose = 0
#' )
#' glance(fit)
#' 
#' @seealso [xgboost::xgb.train()], [xgboost:xgboost()]
glance.xgb.Booster <- function(x) {
  evaluation_log <- x[["evaluation_log"]] %>% 
    tibble::as_tibble()
  
  max_iteration <- x[["niter"]]
  max_iteration_results <- evaluation_log %>% 
    dplyr::filter(iter == max_iteration) %>% 
    dplyr::rename_all(function(x) paste0("max_", x))
  
  best_iteration_results <- tibble::tibble()
  if (!is.null(x[["callbacks"]][["cb.early.stop"]])) {
    best_iteration <- x[["best_ntreelimit"]]
    best_iteration_results <- evaluation_log %>% 
      dplyr::filter(iter == best_iteration) %>% 
      dplyr::rename_all(function(x) paste0("best_", x))
  }
  
  dplyr::bind_cols(max_iteration_results, best_iteration_results)
}
