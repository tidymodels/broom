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
  "term", "a", c("Arima", "betareg"),
  "estimate", "a", c("Arima", "betareg"),
  "std.error", "a", c("Arima", "betareg"),
  "p.value", "a", c("betareg"),
  "conf.low", "a", c("Arima", "betareg"),
  "conf.high", "a", c("Arima", "betareg"),
  "cutoffs", "a", c("roc"),
  "fpr", "a", c("roc"),
  "tpr", "a", c("roc"),
  "component", "a", c("betareg"),
  "statistic", "a", c("betareg"),
  "ci.width", "a", c("binWidth"),
  "alternative", "a", c("binWidth"),
  "p", "a", c("binWidth"),
  "n", "a", c("binWidth", "binDesign"),
  "power", "a", c("binDesign")
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
