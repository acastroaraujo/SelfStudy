library(rvest)
library(tidyverse)

# *********************************************
# Functions
# *********************************************

sn_characters <- function(url, pb = NULL){
  stopifnot(length(url) == 1)
  
  webpage <- read_html(url)
  
  characters <- webpage %>% 
    html_nodes("b") %>% 
    html_text() %>% 
    str_squish()
  
  title <- webpage %>% 
    html_nodes("#interiorpage_title_link1") %>% 
    html_text() %>% 
    str_squish()
  
  author <- webpage %>% 
    html_nodes("#interiorpage_author_link1") %>% 
    html_text() %>% 
    str_squish()
  
  author <- ifelse(is_empty(author), NA, author)   ## some books don't have author names (e.g. Beowulf)
  
  output <- enframe(characters, name = "id", value = "name") %>% 
    mutate(title = title, author = author)
  
  if (!is.null(pb)) {
    try(pb$tick()$print())            ## create this object with pb <- dplyr::progress_estimated(length(links))
  }
  
  cat("\nFinished with", url, "\n")
  Sys.sleep(sample(10:50, 1) / 10)   ## random wait time between 1 and 5 seconds
  
  return(output)
  
}

sn_books <- function() {
  
  website <- read_html("https://www.sparknotes.com/lit/")
  
  available_books <- website %>% 
    html_nodes(".letter-list__filter-title a") %>% 
    html_attr("href")
  
  cat(length(available_books), "books found!")
  return(paste0("https://www.sparknotes.com", available_books, "characters/"))
}


# *********************************************
# Demo
# *********************************************

character_urls <- sn_books()
pb <- dplyr::progress_estimated(length(character_urls))
sn_characters_safe <- function(x, pb) try(sn_characters(x, pb))
output <- purrr::map(character_urls, sn_characters_safe, pb)
