# **************************************************************************************
# This script returns very personal stories about women's experience with ovarian cancer
# Source: https://ovarian.org.uk/
# **************************************************************************************

library(tidyverse)
library(rvest)

get_urls <- function() {

  url <- "https://ovarian.org.uk/news-and-blog/your-stories/"
  output <- list()
  n <- 1
  
  repeat {
    
    website <- read_html(paste0(url, "?page=", n)) 
    
    story_links <- website %>% 
      html_nodes(".listings__wrapper_text a") %>% 
      html_attr("href")
    
    output <- append(output, story_links)
    
    n <- n + 1
    
    range <- website %>% 
      html_nodes(".pagination , strong") %>% 
      html_text() %>% 
      .[2] %>% 
      str_extract("\\d{2} of \\d{2}") %>% 
      str_extract_all("\\d{2}") %>% 
      unlist()
    
    if (range[[1]] == range[[2]]) {
      break
    }
    cat(range, " story links collected\n")
  }
  return(unlist(output))
}

get_story <- function(path, progress_bar = NULL) {
  
  website <- read_html(paste0("https://ovarian.org.uk", path))
  
  story <- website %>% 
    html_nodes(".rich-text") %>% 
    html_text() 
  
  image <- website %>% 
    html_nodes(".article-content__header-image") %>% 
    html_attr("src")
  
  title <- website %>% 
    html_nodes("h2") %>% 
    html_text()
  
  cat("\n", title, "\n")
  
  if (!is.null(progress_bar)) {
    try(progress_bar$tick()$print()) ## pb <- dplyr::progress_estimated(length(links))
  }
  
  Sys.sleep(runif(1, 2, 6))          ## random wait time between 2 and 6 seconds
  
  return(try(tibble(title, paste(story, collapse = "\n"), list(image))))
}


# ***********************************************************************
# Demo
# ***********************************************************************

url_list <- get_urls()
pb <- dplyr::progress_estimated(length(url_list))
output <- purrr::map(url_list, get_story, progress_bar = pb)

write_rds(bind_rows(output), "ovarian cancer action/stories.rds")

