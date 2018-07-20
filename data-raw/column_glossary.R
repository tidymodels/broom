suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(purrr))
suppressPackageStartupMessages(library(yaml))

# col_desc() sources this file and then returns an roxygen2::rd_octlet()
# so that the column glossary is automatically rebuilt everytime
# devtools::document() is called. this means edits to tidy.yaml, etc, will be
# reflected immediately after calling document() with no need to manually
# build the column glossary. sourcing roxygen2 here makes rd_octlet() available
# to col_desc() so that we don't need to add roxygen2 to Suggests. needless to
# say, this is a hack 
library(roxygen2)  

load_columns <- function(file) {
  paste0("data-raw/", file) %>% 
    yaml.load_file() %>% 
    map(as_tibble) %>% 
    bind_rows()
}

column_glossary <- 
  bind_rows(
    load_columns("glance.yaml"),
    load_columns("augment.yaml"),
    load_columns("tidy.yaml"),
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
rm(load_columns, column_glossary)
