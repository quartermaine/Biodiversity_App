# File: modules/ui_module.R

species_mod_UI <- function(id, poland_data) {
  ns <- NS(id)
  
  tagList(
    tags$head(
      tags$link(href = "https://fonts.googleapis.com/css?family=Oswald", rel = "stylesheet"),
      tags$style(type = "text/css", "html, body {width:100%;height:100%; font-family: Oswald, sans-serif;}")
    ),
    
    # Full-screen map output with a drawing toolbar
    div(style = "position:relative; width:100%; height:60vh;",
        leafletOutput(ns("map"), width = "100%", height = "100%")
    ),
    
    # Panels below the map
    div(style = "display:flex; justify-content:space-around; padding: 10px;",
        div(style = "width: 45%;", highchartOutput(ns("occurences"))),
        div(style = "width: 45%;", highchartOutput(ns("timeline")))
    ),
    
    # Top-right panel with title and data source link
    absolutePanel(
      top = 10, right = 10, style = "z-index:500; text-align: right; min-width: 300px;",
      tags$h2("Biodiversity in Poland"),
      tags$a("Data Source", href="https://www.gbif.org/occurrence/search?dataset_key=8a863029-f435-446a-821e-275f4f641165")
    ),
    
    # Left panel for species selection
    absolutePanel(
      top = 100, left = 10, width = "20%", style = "z-index:500; min-width: 300px;",
      pickerInput(ns("species"), label = "Type or select a species name (Vernacular or Scientific)", 
                  choices = list(
                    `Vernacular Name` = sort(unique(poland_data$vernacularName)),
                    `Scientific Name` = sort(unique(poland_data$scientificName))
                  ),
                  options = pickerOptions(liveSearch = TRUE),
                  selected = sample(c(poland_data$vernacularName, poland_data$scientificName), 1, replace = TRUE)
      )
    )
  )
}