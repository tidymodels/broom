library(dplyr)
library(tibble)

# the goal of this glossary is to keep tidier output behavior consistent
# add new column names as needed if the current arguments aren't appropriate

glance_columns <- tribble(
  ~column, ~description, ~used_by,
  "sigma", "", c("Arima"),
  "logLik", "", c("Arima", "betareg"),
  "AIC", "", c("Arima", "betareg", "biglm"),
  "BIC", "", c("Arima", "betareg"),
  "pseudo.r.squared", "", c("betareg"),
  "df.residual", "", c("betareg"),
  "df.null", "", c("betareg"),
  "r.squared", "", c("biglm"),
  "deviance", "", c("biglm"),
  "power", "", c("binDesign"),
  "power.reached", "", c("binDesign"),
  "n", "", c("binDesign"),
  "maxit", "", c("binDesign")
)

# only new columns added by augment are checked against this list
# all names in this list must begin with a dot

augment_columns <- tribble(
  ~column, ~description, ~used_by,
  ".fitted", "", c("betareg"),
  ".resid", "", c("betareg"),
  ".cooksd", "", c("betareg", ""),
  ".rownames", "", ""
)

tidy_columns <- tribble(
  ~column, ~description, ~used_by,
  "term", "", c("Arima", "betareg"),
  "estimate", "", c("Arima", "betareg"),
  "std.error", "", c("Arima", "betareg"),
  "p.value", "", c("betareg"),
  "conf.low", "", c("Arima", "betareg"),
  "conf.high", "", c("Arima", "betareg"),
  "cutoffs", "", c("roc"),
  "fpr", "", c("roc"),
  "tpr", "", c("roc"),
  "component", "", c("betareg"),
  "statistic", "", c("betareg"),
  "ci.width", "", c("binWidth"),
  "alternative", "", c("binWidth"),
  "p", "", c("binWidth"),
  "n", "", c("binWidth", "binDesign"),
  "power", "", c("binDesign")
)

column_glossary <- 
  bind_rows(
    glance_columns,
    augment_columns,
    tidy_columns,
    .id = "method"
  ) %>% mutate(
    method = recode(
      method, 
      "1" = "glance",
      "2" = "augment",
      "3" = "tidy"
    )
  )

usethis::use_data(column_glossary, overwrite = TRUE)
