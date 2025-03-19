#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

# File: app.R

library(shiny)
library(shinyWidgets)
library(dplyr)
library(leaflet)
library(highcharter)
library(stringr)
library(glue)
library(xts)
library(shinyalert)
library(leaflet.extras)

source("utils/data_processing.R", local = TRUE)
source("modules/helper_functions.R")
source("modules/ui_module.R")
source("modules/server_module.R")

# Process Poland data
poland <- process_poland_data("data/poland_data.csv")
poland <- create_popup_label(poland)

# Define UI
ui <- bootstrapPage(
  species_mod_UI("filter", poland_data = poland) # Pass the 'poland' dataset here
)

# Define Server
server <- function(input, output, session) {
  callModule(species_mod_filter, "filter", poland_data = poland)
}

# Run the application
shinyApp(ui, server)

