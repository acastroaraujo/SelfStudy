# ************************************************************
# This script returns metadata on books from goodreads
# ************************************************************

library(tidyverse)
library(rvest)

full_link <- function(x) {
  paste0("https://www.goodreads.com/work/editions/", x, "?&sort=num_ratings&per_page=50&expanded=true")
}

goodreads <- function(id, progress_bar = NULL) {
  stopifnot(length(url) == 1)
  
  webpage <- read_html(full_link(id))
  
  num_editions <- webpage %>% 
    html_nodes(".greyText .smallText") %>% 
    html_text() %>%
    str_squish() %>% 
    str_remove("Showing 1-50 of ") %>%
    str_remove(",") %>% 
    as.integer()
  
  title <- webpage %>% 
    html_nodes("h1 a") %>% 
    html_text() %>%
    str_squish() 
  
  author <- webpage %>% 
    html_nodes("h2 a") %>% 
    html_text() %>% 
    str_squish()
  
  original_pub_date <- webpage %>% 
    html_nodes(".originalPubDate") %>% 
    html_text() %>% 
    str_squish()
  
  edition <- webpage %>% 
    html_nodes(".editionData > .dataRow:nth-child(2)") %>% 
    html_text() %>% 
    str_squish()
  
  ratings <- webpage %>% 
    html_nodes(".dataRow~ .dataRow+ .dataRow .greyText") %>% 
    html_text() %>% 
    str_squish() %>%
    str_sub(start = 2, end = -10) %>% 
    str_remove(",") %>% 
    as.integer()
  
  image <- webpage %>% 
    html_nodes(".leftAlignedImag img") %>% 
    html_attr("src") %>% 
    str_remove("_SY75_.|_SX50_.")
  
  language <- webpage %>% 
    html_nodes(".dataRow:nth-child(3) .dataValue") %>% 
    html_text() %>% 
    str_squish()
  
  language <- ifelse(str_detect(language, "ratings\\)"), NA, language)
  
  
  output <- try(tibble(title, author, original_pub_date, edition, num_editions, language, ratings, image))
  
  if (!is.null(progress_bar)) {
    try(progress_bar$tick()$print())            ## create this object with pb <- dplyr::progress_estimated(length(links))
  }
  
  cat("\nFinished with", title, "\n")
  Sys.sleep(sample(20:60, 1) / 10)   ## random wait time between 2 and 6 seconds
  
  return(output)
  
}

# ************************************************************
# Scraping
# ************************************************************

book_id <- c(
  alice = "55548884-alice-s-adventures-in-wonderland",
  jekyll_hyde = "3164921-strange-case-of-dr-jekyll-and-mr-hyde",
  treasure_island = "3077988-treasure-island",
  frankenstein = "4836639-frankenstein-or-the-modern-prometheus",
  scarlet_letter = "4925227-the-scarlet-letter",
  moby_dick = "2409320-moby-dick"
)

pb <- dplyr::progress_estimated(length(book_id))
output <- purrr::map(book_id, goodreads, progress_bar = pb)

readr::write_csv(bind_rows(output), "multi_editions/top50_goodreads.csv")


