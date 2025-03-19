library(testthat)
library(shiny)
library(dplyr)       # For `mutate`
library(leaflet)     # For `renderLeaflet`
library(highcharter) # For `hchart`
library(here)        # For robust path handling

# Anchor the project root using `here::i_am()`
here::i_am("tests/testthat/test_app.R")

# Source custom scripts
if (!file.exists(here("utils", "data_processing.R"))) {
  stop("File 'utils/data_processing.R' not found. Please check the file path.")
}
source(here("utils", "data_processing.R"), local = TRUE)

# Context: Data Processing
context("Data Processing")

# Test 1: process_poland_data returns a valid dataset
test_that("process_poland_data returns a valid dataset", {
  # Create minimal sample data
  raw_data <- data.frame(
    scientificName = c("Species A"),
    vernacularName = c("Example Species"),
    latitudeDecimal = c(52.0),
    longitudeDecimal = c(20.0),
    eventDate = c("2020-01-01"),
    family = c("example_family")
  )
  
  # Write the data to a temporary file
  temp_file <- tempfile(fileext = ".csv")
  write.csv(raw_data, temp_file, row.names = FALSE)
  
  # Process the data
  processed_data <- process_poland_data(temp_file)
  
  # Check if the output is a data frame
  expect_s3_class(processed_data, "data.frame")
  
  # Check if required columns exist
  expect_true(all(c("scientificName", "vernacularName", "latitude", "longitude", "eventDate") %in% colnames(processed_data)))
  
  # Check if the data is not empty
  expect_true(nrow(processed_data) > 0)
  
  # Clean up the temporary file
  unlink(temp_file)
})