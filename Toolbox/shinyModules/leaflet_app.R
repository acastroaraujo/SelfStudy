library(tidyverse)
library(leaflet)
library(shiny)
source("leaflet_module.R")

## Data

df <- readr::read_rds("../data/usa_county_map.rds")

df <- sf::st_transform(df, 4326)

df_states <- df %>% 
  group_by(state_fips, state) %>% 
  summarize(geometry = sf::st_union(geometry), 
            pop_total = sum(pop_total),
            miles_squared = sum(miles_squared)) %>% 
  drop_na() %>% ## Dropping NA's will change format from sf to tbl...
  ungroup() %>% 
  rename(name = state)

df_states <- sf::st_as_sf(df_states, sf_column_name = "geometry")  ## Change back


available_squemes <- c(
  "viridis", "magma", "plasma",
  rownames(RColorBrewer::brewer.pal.info)[RColorBrewer::brewer.pal.info$category == "seq"]
)

ui <- fluidPage(
  theme = shinythemes::shinytheme("lumen"),
  navbarPage(
    title = shiny::icon("fas fa-globe-americas"), windowTitle = "leaflet aesthetic",
    tabPanel(title = "States", 
             leafletAestheticsUI("states", available_squemes)),
    tabPanel(title = "Counties", 
             leafletAestheticsUI("counties", available_squemes))
  )
)

server <- function(input, output) {
  
  callModule(leafletAesthetics, "states", DF = df_states)
  callModule(leafletAesthetics, "counties", DF = df)
  
}

shinyApp(ui, server)