library(rvest)

scrape_amazon <- function(url, pb = NULL){
  stopifnot(length(url) == 1)
  
  webpage <- read_html(url)
  
  text <- webpage %>%
    html_nodes(".review-text-content span") %>%
    html_text() %>% 
    as_tibble() %>% 
    filter(value != "") %>%
    rename(text = 1)
  
  stars <- webpage %>%
    html_nodes(".a-icon-alt") %>%
    as.character() %>%
    as_tibble() %>%
    slice(4:13) %>%
    rename(rating = 1)
  
  return_df <- try(bind_cols(text, stars))
  
  if (!is.null(pb)) {
    try(pb$tick()$print())            ## create this object with pb <- dplyr::progress_estimated(length(links))
  }
  
  cat("\nFinished with", url, "\n")
  Sys.sleep(sample(40:70, 1) / 10)   ## random wait time between 4 and 7 seconds
  
  return(return_df)
  
}

## see which link creates errors by debugging
get_error_index <- function(x) {
  class(unlist(x)) == "try-error"
}

## And then do this:
## error_index <- map_lgl(output, get_error_index)
## output[which(error_index == TRUE)] <- purrr::map(links[which(error_index == TRUE)], scrape_amazon)
