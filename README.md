# Biodiversity_App


## Overview 

This Shiny app visualizes biodiversity data in Poland 🇵🇱 , allowing users to explore species observations over time, filter data by species or location, 
and generate interactive charts and maps. 
The app is designed for researchers and enthusiasts interested in analyzing biodiversity trends. 
The deployed app can be found [here](https://andch552.shinyapps.io/Biodiversity_App/)

## Project Structure 

The project is organized into the following directories and files: 

    .
    ├── app.R
    ├── data
    │   ├── occurence.csv
    │   └── poland_data.csv
    ├── LICENSE
    ├── modules
    │   ├── helper_functions.R
    │   ├── server_module.R
    │   └── ui_module.R
    ├── README.html
    ├── README.md
    ├── tests
    │   └── testthat
    │       └── test_app.R
    ├── utils
    │   ├── construct_data.R
    │   └── data_processing.R
    └── www

 
## How to Run the App 

### Prerequisites 

1. Install R and RStudio (or any R IDE of your choice).
2. Install the required R packages by running the following command in your R console:

    
    > install.packages(c("shiny", 
                        "shinyWidgets", 
                        "dplyr",
                        "highcharter",
                        "stringr",
                        "glue", 
                        "leaflet", 
                        "testthat",
                        "glue",
                        "xts",
                        "shinyalert")
                        )
     

### Running the App 

To launch the Shiny app, follow these steps: 

1. Open the app.R file in your R environment. 

2. Run the following command in the R console: 

     

     
    
    > shiny::runApp("path/to/Biodiversity-App")
     
     

    Replace "path/to/Biodiversity-Apps" with the actual path to your project directory. 

3. The app will open in your default web browser. Use the interface to explore the data and generate visualizations. 
     

## How to Run Tests 

The project includes a test suite to ensure the app's functionality works as expected. To run the tests: 

1.Open an R session in the root directory of the project. 

2. Run the following command to execute all tests: 
  
    
    > testthat::test_dir("tests/testthat")
 
 

3. Review the test results in the R console. If all tests pass, you should see a message like: 
 

     ✔ | F W  S  OK | Context
     ✔ |          3 | Data Processing                                                                                                                                         

     ══ Results ═════════════════════════
   
     [ FAIL 0 | WARN 0 | SKIP 0 | PASS 3 ]
     
     
     

If any tests fail, check the error messages and consult the relevant code in utils/data_processing.R or tests/testthat/test_app.R. 

## Key Features of the App 

    Data Processing : 
        The app processes raw biodiversity data using functions defined in utils/data_processing.R.
        Example: Removing unnecessary columns, handling missing values, and standardizing column names.
         

    Interactive Visualizations : 
        Generate bar chart, line chart, and map to visualize species observations.
        Use filters to refine the data displayed in the visualizations.
         

    Testing Framework : 
        Comprehensive unit tests ensure the app's helper functions and server logic work correctly.
        Tests are located in tests/testthat/test_app.R.
         


## License 

This project is licensed under the MIT License. See the LICENSE file for details. 
