## New SF object for county maps in USA

library(sf)
library(tidyverse)
library(tidycensus)

## This key is linked to andres.castroaraujo@tbwachiat.com
census_key <- "1b37027d05fc830c7304e4182eac9198a59046f8"
census_api_key(census_key)

available_vars <- load_variables(2017, "acs5", cache = TRUE)
options(tigris_use_cache = TRUE)

data_counties <- tidycensus::get_acs(
  variables = c(pop_total = "B01003_001"),  
  geography = "county",
  geometry = FALSE) %>% 
  rename_all(str_to_lower) %>% 
  select(-moe) %>%
  spread(variable, estimate) %>% 
  mutate(state = str_extract(name, ", .*") %>% str_remove(", ")) %>% 
  mutate(name = str_remove(name, " County, .*"))


library(albersusa)

albers_map <- counties_sf("aeqd") %>% 
  rename(miles_squared = census_area) %>% 
  mutate_if(is.factor, as.character) %>% 
  mutate(fips = ifelse(fips == "46113", "46102",                    ## Shannon County no more
                       ifelse(fips == "02270", "02158", fips))) %>% ## Wade Hampton no more
  select(-lsad, -name, -state, -iso_3166_2) 

usa_county_map <- albers_map %>% 
  right_join(data_counties, by = c("fips" = "geoid"))


readr::write_rds(usa_county_map, "usa_county_map.rds", compress = "gz")
