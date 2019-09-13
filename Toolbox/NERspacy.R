
# ********************************************************************
# This script uses spacyR for named entity recognition.
# 
# First make sure you have installed this Python library in a suitable
# environment. I recommend doing the following:
#
# library(reticulate)
# library(spacyr)
# conda_create("r-NLP")
# spacy_install(envname = "r-NLP")
#
# This whole script centers around the spacy_parse() and entity_extract()
# functions, so make sure you read the documentation at: 
# 1. http://spacyr.quanteda.io/reference/spacy_parse.html 
# 2. http://spacyr.quanteda.io/reference/entity_extract.html
#
# ********************************************************************

library(tidyverse)
library(spacyr)
spacy_initialize(condaenv = "r-NLP")

get_entity <- function(lookup, type, n, label) {
  
  lookup %>% 
    filter(entity_type == type) %>% 
    count(entity) %>% 
    top_n(n) %>% 
    arrange(desc(n)) %>% 
    mutate(type = label)
  
}

# ********************************************************************
#
# LOOPING OVER MANY BOOKS
#
# The data is supposed to look like this:
#     Observations: N
#     Variables: 3
#     author <chr> "Patti Smith", "Antoine de Saint Exupéry", ...
#     title  <chr> "Just Kids", "The Little Prince", ...
#     text   <chr> "I was asleep when he died. I had called the...", 
#
# ********************************************************************

# df <- read_rds("data/textdata.rds")

output <- vector("list", nrow(df))
pb <- dplyr::progress_estimated(length(output))

for (i in 1:length(output)) {
  
  lookup <- spacy_parse(df$text[[i]], dependency = TRUE, lemma = FALSE, tag = TRUE, nounphrase = TRUE)
  
  entities <- entity_extract(lookup)
  
  ner <- bind_rows(
    get_entity(entities, "PERSON", 10, "main_characters"),
    get_entity(entities, "LANGUAGE", 10, "languages"),
    get_entity(entities, "GPE", 10, "places"),
    get_entity(entities, "NORP", 10, "groups")
  )
  
  output[[i]] <- list(lookup, ner)
  cat("Done parsing:", df$title[[i]], "\n\n")
  try(pb$tick()$print())
}

names(output) <- df$title

# write_rds(output, "data/ner_output.rds")

spacy_finalize()




