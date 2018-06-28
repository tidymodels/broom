library(dplyr)
library(tibble)

# the goal of this glossary is to keep tidier behavior consistent across broom.
# add new arguments as needed if the current arguments aren't appropriate

# helper function to inspect arguments of exported methods
# need to manually add in list-tidier methods
method_args <- function(method, all = FALSE) {
  m <- suppressWarnings(methods(method))
  df <- attr(m, "info")
  funs <- rownames(df)
  
  # TODO: manually add in list tidier function. errors will show up in tests.
  list_tidiers <- paste0("tidy_", c("optim", "xyz", "irlba", "svd"))
  list_glancers <- "glance_optim"
  
  get_args <- function(fun_name) {
    names(formals(getFromNamespace(fun_name, ns = "broom")))
  }
  
  args <- purrr::map(funs, get_args)
  names(args) <- funs
  
  if (!all) {
    sort(unique(unlist(args)))
  } else {
    args
  }
}

# method_args(tidy)
# method_args(glance)


glance_arguments <- tribble(
  ~argument, ~description,
  "...", "",
  "deviance", "",
  "diagnostics", "",
  "looic", "",
  "mcmc", "",
  "object", "",
  "test", "",
  "x", ""
)

augment_arguments <- tribble(
  ~argument, ~description,
  "...", "",
  "data", "",
  "newdata", "",
  "object", "",
  "type.predict", "",
  "type.residuals", "",
  "weights", "",
  "x", ""
)

tidy_arguments <- tribble(
  ~argument, ~description,
  "...", "",
  "alpha", "",
  "boot_se", "",
  "by_class", "",
  "col.names", "",
  "component", "",
  "conf.int", "",
  "conf.level", "",
  "conf.method", "",
  "conf.type", "",
  "diagonal", "",
  "droppars", "",
  "effects", "",
  "ess", "",
  "estimate.method", "",
  "exponentiate", "",
  "fe", "",
  "intervals", "",
  "matrix", "",
  "na.rm", "",
  "object", "",
  "par_type", "",
  "parameters", "",
  "parametric", "",
  "pars", "",
  "prob", "",
  "quick", "",
  "ran_prefix", "",
  "region", "",
  "return_zeros", "",
  "rhat", "",
  "robust", "",
  "scales", "",
  "se.type", "",
  "strata", "",
  "test", "",
  "trim", "",
  "upper", "",
  "x", ""
)

argument_glossary <- 
  bind_rows(
    glance_arguments,
    augment_arguments,
    tidy_arguments,
    .id = "method"
  ) %>% mutate(
    method = recode(
      method, 
      "1" = "glance",
      "2" = "augment",
      "3" = "tidy"
    )
  )

usethis::use_data(argument_glossary, overwrite = TRUE)
