# File: modules/server_module.R

species_mod_filter <- function(input, output, session, poland_data) {
  
  # Show welcome message on app start
  observe({
    show_welcome_message()
  })
  
  # Reactive data filtering based on user input
  filteredData <- reactive({
    req(filter(poland_data, scientificName == input$species | vernacularName == input$species)) %>%
      mutate(eventDate = lubridate::ymd(eventDate))
  })
  
  # Render the map
  output$map <- renderLeaflet({
    leaflet(filteredData()) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addMarkers(~longitude, ~latitude, popup = ~popup_label, clusterOptions = markerClusterOptions()) %>%
      addDrawToolbar(
        targetGroup = "drawnItems",
        position= 'bottomleft',
        editOptions = editToolbarOptions(selectedPathOptions = selectedPathOptions())
      ) %>%
      setView(21.017532, 52.237049, zoom = 6)
  })
  
  # Update markers dynamically
  observe({
    leafletProxy("map", data = filteredData()) %>%
      clearShapes() %>% 
      clearControls() %>% 
      addMarkers(~longitude, ~latitude, popup = ~popup_label, clusterOptions = markerClusterOptions()) 
  })
  
  # Render yearly occurrences chart
  output$occurences <- renderHighchart({
    chartData <- filteredData() %>% 
      group_by(year = lubridate::floor_date(eventDate, "year")) %>% 
      summarize(occurences_per_year = n()) %>% 
      mutate(year = as.numeric(substr(year, 1, 4)))
    
    hchart_year_observations(chartData)
  })
  
  # Render timeline chart
  output$timeline <- renderHighchart({
    Views_over_time <- filteredData() %>%
      group_by(eventDate) %>%
      dplyr::summarise(Views = n())
    
    time_series <- xts(
      Views_over_time$Views, order.by = Views_over_time$eventDate)
    
    highchart(type = "stock") %>% 
      hc_title(text = paste("Selected Species Observations Timeline")) %>% 
      hc_subtitle(text = "") %>% 
      hc_add_series(time_series, name = "Observations", color = "red") %>% 
      hc_add_theme(hc_theme_smpl()) %>% 
      hc_chart(backgroundColor = "transparent")
  })
}