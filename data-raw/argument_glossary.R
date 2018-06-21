library(dplyr)
library(tibble)

# the goal of this glossary is to keep tidier behavior consistent across broom.
# add new arguments as needed if the current arguments aren't appropriate

glance_arguments <- tribble(
  ~argument, ~description,
  "x", "",
  "...", ""
)

augment_arguments <- tribble(
  ~argument, ~description,
  "x", "",
  "data", "",
  "newdata", "",
  "type.predict", "",
  "type.residuals", "",
  "weights", "",
  "...", ""
)

tidy_arguments <- tribble(
  ~argument, ~description,
  "x", "",
  "conf.int", "",
  "conf.level", "",
  "exponentiate", "",
  "quick", "",
  "...", ""
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
