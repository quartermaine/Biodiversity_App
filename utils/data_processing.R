library(dplyr)
library(stringr)
library(leafpop)

# Function to process the Poland dataset
process_poland_data <- function(file_path) {
  poland <- read.csv(file_path, header = TRUE)
  
  # Drop unnecessary columns safely
  poland <- poland %>%
    select(-any_of(c(
      "stateProvince", 
      "recordedBy", 
      "previousIdentifications", 
      "habitat", 
      "eventID", 
      "behavior", 
      "associatedTaxa",
      "dataGeneralizations", 
      "samplingProtocol", 
      "id", 
      "catalogNumber", 
      "basisOfRecord", 
      "collectionCode", 
      "higherClassification",
      "geodeticDatum", 
      "continent", 
      "eventTime", 
      "rightsHolder", 
      "license", 
      "country", 
      "countryCode", 
      "taxonRank", 
      "locality",
      "modified"
    )))
  
  # Tidy the family column
  poland$family <- str_to_title(poland$family)
  poland$family <- gsub("_", " ", poland$family, fixed = TRUE)
  
  # Rename latitude and longitude columns
  poland <- poland %>%
    rename(latitude = latitudeDecimal, longitude = longitudeDecimal)
  
  return(poland)
}

# Function to create popup labels
create_popup_label <- function(data) {
  data$popup_label <- with(data, {
    paste(
      "<b>Scientific Name:</b>", scientificName, "<br>",
      "<b>Vernacular Name:</b>", vernacularName, "<br>",
      "<b>Family:</b>", family, "<br>",
      "<b>Kingdom:</b>", kingdom, "<br>",
      "<b>Life Stage:</b>", lifeStage, "<br>",
      "<b>Sex:</b>", sex, "<br>",
      "<b>Individual Count:</b>", individualCount, "<br>",
      "<b>Event Date:</b>", eventDate, "<br>",
      "<b>Coordinate Uncertainty (m):</b>", coordinateUncertaintyInMeters, "<br>",
      "<b>References:</b>", references
    )
  })
  return(data)
}

# usage
# poland <- process_poland_data("data/poland_data.csv")
# poland <- create_popup_label(poland)

