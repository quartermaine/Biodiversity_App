library(bread)

# Define the path to your large CSV file
file_path <- "data/occurence.csv"

# Define the pattern and corresponding column to filter
pattern <- "PL"
column_to_filter <- "countryCode"

# Apply bfilter to read only rows where countryCode is 'PL'

poland_data <- bfilter(file = file_path, 
                       patterns = pattern, 
                       filtered_columns = column_to_filter
                       )

head(poland_data)

output_file <- "data/poland_data.csv"

write.csv(poland_data, file = output_file, row.names = FALSE)

# Note: The original `occurence.csv` file is NOT included in the repository due to its large size (~19.5GB).
# Users must manually obtain this file and place it in the `data/` directory before running this script.
