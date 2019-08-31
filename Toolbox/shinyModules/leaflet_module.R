library(shiny)

leafletAestheticsUI <- function(id, as) {
  ns <- NS(id)
  tagList(
    sidebarLayout(
      sidebarPanel(
        width = 3, 
        wellPanel(
          ## Colors
          selectInput(inputId = ns("color_scheme"), label = strong("Select color scheme:"), 
                      choices = as, selected = "viridis"),
          ## Opacity
          sliderInput(ns("opacity"), strong("Opacity"), min = 0, max = 1, value = 1, step = 0.05),
          ## Reverse colors
          actionButton(inputId = ns("reverse"), "Reverse color scheme!")
        )
      ),
      mainPanel(leafletOutput(ns("leaflet_map")))
    )
  )
}

leafletAesthetics <- function(input, output, session, DF) {
  
  ## Change color scheme
  rev_button <- reactiveVal(TRUE)
  observeEvent(eventExpr = input$reverse, ignoreNULL = FALSE, { 
    new <- rev_button() == FALSE
    rev_button(new)
  })
  
  fill_pal <- reactive({                            
    rev <- rev_button()                             # This reactive expression represents the palette function,
    fill_pal <- colorNumeric(                       # which changes as the user makes selections in UI.
      palette = input$color_scheme, 
      domain = DF$pop_total, 
      reverse = rev_button())
  })
  
  output$leaflet_map <- leaflet::renderLeaflet({ 
    
    DF %>% 
      leaflet(options = leafletOptions(attributionControl = FALSE)) %>% 
      setView(-96, 37.8, 4) 
    
  })
  
  observe({
    pal <- fill_pal() 
    fill_labels <- paste0(
      "<strong>", DF %>% pull(name), "</strong><br>", "<strong>",
      "Total Population: ", "</strong>", DF %>% pull(pop_total) %>% scales::comma()
    ) %>% purrr::map(htmltools::HTML)
    
    proxy <- leafletProxy("leaflet_map", data = DF) 
    
    proxy %>% 
      clearShapes() %>%
      clearControls() %>% 
      addPolygons(fillColor = ~pal(pop_total),
                  color = "black", weight = 1, smoothFactor = 0.5,
                  opacity = 0.6, fillOpacity = input$opacity, 
                  highlightOptions = highlightOptions(
                    color = "black", 
                    weight = 2,
                    fillOpacity = input$opacity,
                    bringToFront = TRUE),
                  label = fill_labels) %>% 
      addLegend(pal = pal,
                values = ~pop_total,
                opacity = input$opacity,
                title = "Title", bins = 7,
                position = "bottomright")
  })
}
