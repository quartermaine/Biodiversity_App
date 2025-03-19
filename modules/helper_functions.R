# File: modules/helper_functions.R

# Bar chart for yearly observations
hchart_year_observations <- function(hchart_data) {
  # Add a 'color' column based on observation count
  hchart_data <- hchart_data %>%
    mutate(
      color = case_when(
        occurences_per_year > 100 ~ "#FF5733",  # Red for high counts (>100)
        occurences_per_year > 50 & occurences_per_year <= 100 ~ "#FFC300",  # Yellow for medium counts (50–100)
        TRUE ~ "#33FF57"  # Green for low counts (<=50)
      )
    )

  # Create the Highcharts bar chart
  hchart(hchart_data, "bar", hcaes(x = year, y = occurences_per_year, color = color)) %>%
    hc_title(text = paste("Reported Observations per Year")) %>%
    hc_xAxis(title = list(text = ""), gridLineWidth = 0, minorGridLineWidth = 0) %>%
    hc_yAxis(title = list(text = "Species Observation Count"), gridLineWidth = 0, minorGridLineWidth = 0) %>%
    hc_legend(enabled = FALSE) %>%
    hc_tooltip(
      pointFormat = "<b>{point.category}</b>: {point.y} observations<br>", # Enhanced tooltip
      shared = TRUE
    ) %>%
    hc_plotOptions(
      series = list(
        dataLabels = list(enabled = TRUE, format = "{point.y}"), # Data labels
        animation = list(duration = 1000) # Animation
      )
    ) %>%
    hc_add_theme(hc_theme_smpl()) %>%
    hc_chart(backgroundColor = "transparent")
}

# hchart_year_observations <- function(hchart_data) {
#   # Add a 'color' column based on observation count
#   hchart_data <- hchart_data %>%
#     mutate(
#       color = case_when(
#         occurences_per_year > 100 ~ "#FF5733",  # Red for high counts (>100)
#         occurences_per_year > 50 & occurences_per_year <= 100 ~ "#FFC300",  # Yellow for medium counts (50–100)
#         TRUE ~ "#33FF57"  # Green for low counts (<=50)
#       )
#     )
#   
#   # Create the Highcharts radar chart
#   hchart(hchart_data, "line", hcaes(x = year, y = occurences_per_year, color = color)) %>% 
#     hc_title(text = paste("Reported Observations per Year")) %>% 
#     hc_xAxis(
#       categories = hchart_data$year, # Use years as categories
#       tickmarkPlacement = "on",
#       lineWidth = 0,
#       gridLineWidth = 1,
#       labels = list(style = list(fontSize = "12px")),
#       title = list(text = "")
#     ) %>% 
#     hc_yAxis(
#       gridLineInterpolation = "polygon", # Enable polar grid lines
#       lineWidth = 0,
#       min = 0,
#       title = list(text = "Species Observation Count")
#     ) %>% 
#     hc_legend(enabled = FALSE) %>% 
#     hc_tooltip(
#       pointFormat = "<b>{point.category}</b>: {point.y} observations<br>", # Enhanced tooltip
#       shared = TRUE
#     ) %>% 
#     hc_plotOptions(
#       series = list(
#         dataLabels = list(enabled = TRUE, format = "{point.y}"), # Data labels
#         animation = list(duration = 1000), # Animation
#         marker = list(enabled = TRUE, symbol = "circle", radius = 4) # Marker style
#       )
#     ) %>% 
#     hc_add_theme(hc_theme_smpl()) %>% 
#     hc_chart(
#       polar = TRUE, # Enable polar coordinates for radar chart
#       backgroundColor = "transparent"
#     )
# }

# Welcome message function
show_welcome_message <- function() {
  shinyalert(
    title = "Poland Biodiversity map", 
    text = "<p style='font-size: 12px;'>On this shiny app, you can explore different species that exist in Poland.</p>
                 <p style='font-size: 12px;'><b>App info - How to use</b></p>
                 <p style='font-size: 12px;'>The app allows the user to type or select a species by their name (either scientific or vernacular) and displays:</p>
                 <ul style='font-size: 12px;'>
                   <li>All of the reported observations with their location on the map</li>
                   <li>A bar chart with the total yearly observations of the selected species</li>
                   <li>A timeline graph of the number of recorded observations for each day they occurred, with the exact date of the observations</li>
                   <li>Extended information regarding each observation with a popup label window when the user selects one of the pinned observations on the map</li>
                 </ul>
                 <p style='font-size: 12px;'><em>We have selected a random species for you to get you started.</em></p>
                 <p style='font-size: 12px;'><b>Select the species you want to explore by using the filter on the left side of your screen</b></p>",
    type = "",
    closeOnClickOutside = FALSE,
    showConfirmButton = TRUE,
    confirmButtonText = "Close",
    confirmButtonCol = "#4CAF50",
    timer = 0,
    html = TRUE,
    size = "s",
    animation = TRUE,
    imageUrl = 'https://upload.wikimedia.org/wikipedia/commons/1/1e/GBIF-2015-full-stacked.png'
  )
  
  tags$head(
    tags$style(HTML("
      .sweet-alert {
        width: 700px !important;
        min-width: 300px !important;
        max-height: 400px !important;
        overflow-y: auto !important;
      }
      .sweet-alert p, .sweet-alert ul {
        font-size: 12px !important;
      }
    "))
  )
}