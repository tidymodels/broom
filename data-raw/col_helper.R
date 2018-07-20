# this script generates **messy** yaml column description files from existing
# @return sections of .Rd files. useful only during the transition to the new
# documentation strategy.

# **WARNING**: overwrites existing YAML files

library(tidyverse)
library(yaml)

get_yaml_list <- function(fname) {
  class <- str_remove_all(fname, "(tidy\\.|augment\\.|glance\\.|\\.Rd)")
  
  lines <- readLines(fname)
  start_idx <- which(lines == "\\value{")
  end_idx <- which(lines == "}")
  end_idx <- end_idx[which(start_idx < end_idx)[1]] - 1  # drop trailing }
  
  value <- lines[start_idx:end_idx]
  
  first_item <- min(which(str_detect(value, "item") == TRUE))
  
  item_lines <- value[first_item:length(value)]
  item_start <- which(str_detect(item_lines, "item"))
  
  # issue: adds stuff for lines after items finish
  
  yaml_items <- list()
  
  yaml_list <- function(item, class) {
    split <- str_split(item, "\\}\\{")[[1]]
    column <- substring(split[1], 7)
    desc <- str_remove(split[2], "\\}")
    list(list(column = column, description = desc, used_by = class))
  }
  
  for (idx in seq_along(item_start)) {
    start <- item_start[idx]
    
    if (start == tail(item_start, 1)) {
      end <- length(item_lines)
    } else {
      end <- item_start[idx + 1] - 1
    }
    
    item <- paste0(item_lines[start:end], collapse = " ")
    item <- roxygen2md::transform_text(item)
    yaml_items[idx] <- yaml_list(item, class)
  }
  
  yaml_items
}

try_yaml <- purrr::possibly(get_yaml_list, NULL)
files <- list.files()

for (method in c("tidy", "glance", "augment")) {
  
  method_files <- files[str_detect(files, method)]
  method_yaml <- flatten(map(method_files, try_yaml))
  
  # consolidate information about repeated columns names
  
  method_yaml <- bind_rows(method_yaml) %>% 
    nest(-column) %>% 
    arrange(column) %>% 
    mutate(description = map(data, "description"),
           used_by = map(data, "used_by"),
           data = NULL) %>% 
    purrr::transpose()
  
  fname <- paste0(method, ".yaml")
  write_yaml(method_yaml, here::here("data-raw", fname))
}





