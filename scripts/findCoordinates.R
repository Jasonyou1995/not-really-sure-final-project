# INFO 201, Autumn 2016, Secton AB
# Team name: Not Really Sure
# Comtributors: Jason You
#
# Find the coordinates for a given University dataset, then return a data
# frame and save this data frame in the data/newdata repository in csv format
# with the given output file name with no suffix
#
# Note that the Google Map api limits to 2500 queries a day (for free). Use
# geocodeQueryCheck("free") to determine how many queries remain.

source("scripts/installPackage.R")
source("scripts/factorToCharOrNum.R")
# import ggmap::geocode to find longitudes and latitudes
installPackage(c("ggmap", "dplyr", "jsonlite")) 


# Input : dataset must contain university_name column (case sensitive and no 
#         "s").
#         Remember to include 'stringsAsFactors = FALES' when read csv data.
# Output: returns a data frame with additional columns "lon" (longitudes) and
#         "lat" (latitudes) of each university.
findCoordinates <- function(dataset, output_name = "output") {
  if (!'university_name' %in% names(dataset)) {
    stop("Error: \"university_name\" column not found, check you spelling")
  }
  
  dataset$university_name <- factorToCharOrNum(dataset$university_name)
  unique_names <- unique(dataset$university_names) # get unique names 
  
  lon_lat <- geocode(unique_names)  # output lon and lat from Google Geocode
  lon_lat$university_name <- unique_names
  # store the original dataset
  write.csv(dataset, file = paste0("data/temp/old/", output_name, "_old_",
                                   date(), ".csv"), row.names = FALSE)
  # in case lose the data by error
  write.csv(lon_lat, file = paste0("data/temp/", "lon_lat_", output_name,
                                   "_", date(), ".csv"),
            row.names = FALSE)
  
  # In case the lon and lat already exist
  # (If the lon and lat were removed accidentally, you can find the original
  # dataset in the "data/temp/old" repository)
  dataset$lon <- NULL
  dataset$lat <- NULL
  
  # left_join the result by the "university_name" column
  dataset <- left_join(dataset, lon_lat, by = "university_name", copy = TRUE)
  
  # use a more general search to get coordinates (in case that geocode can't 
  # find all the universities)
  dataset <- replaceNA(dataset) 
  
  # save files as *.csv formats
  write.csv(dataset,
            file = paste0("data/newData/", output_name, "_lonlat.csv"),
            row.names = FALSE)
  return(dataset)
}


# Input : Requirements are the same as the findCoordinates function (above).
#         lon and lat columns may also required.
#         You can add two NA columns for lon and lat to use this function.
# Output: return dataset by replacing the NA coordinate with result from
#         Google Place API (a more general search method)
replaceNA <- function(dataset) {
  dataset.NA <- filter(dataset, is.na(lon) | is.na(lat))  # filter the NA rows
  
  # get the answers relate to lon, lat, and the analysis
  answer <- getAnswer(dataset.NA)
  unique_table <- answer$unique_table
  notFound <- answer$notFound
  college_NA <- answer$college_NA
  
  # in case lose the data by error
  write.csv(unique_table, file = paste0("data/temp/", "unique_table_",
                                        date(), ".csv"), row.names = FALSE)
  
  # remove the original NA lon and lat columns
  dataset.NA$lon <- NULL
  dataset.NA$lat <- NULL
  # retain all rows in table x, and all cols in table x and y
  dataset.NA <- left_join(dataset.NA, unique_table,
                          by = "university_name", copy = TRUE)
  # remve the NA rows in the original dataset
  dataset <- dataset[!(is.na(dataset$lon) | is.na(dataset$lat)), ]
  dataset <- rbind(dataset, dataset.NA)
  
  # report result and return dataset
  if (notFound || !is.null(college_NA)) {
    print(paste(notFound, "university not found:")) 
    print(college_NA)
  }
  return(dataset)
}


# Take an unique name vector and returns a list of answer with lon, lat, and
# some analysis about the searching results
getAnswer <- function(dataset.NA) {
  dataset.NA$university_name <- factorToCharOrNum(dataset.NA$university_name)
  # store unique names with whitespaces replaced by plus signs "+"
  university_name <- unique(getCleanName(dataset.NA))
  base <- "https://maps.googleapis.com/maps/api/place/textsearch/json?language=en&"
  apikey      <- "AIzaSyCBmaTaH3g2XQKs34kNKt5wf8ZKx5h8-gc"  # Google Map key
  lon <- c()  # store longitude
  lat <- c()  # store altitude
  notFound <- 0  # count NA
  college_NA <- c()  # record the index of zero result
  total <- length(university_name) # total NA
  
  for (i in 1:total) {
    print(paste(i, "/", total, ">>", round(i * 100 / total), "%"))  # process
    address <- university_name[i]
    query <- paste0(base, "query=", address, "&key=", apikey)
    json <- fromJSON(query)
    if (json$status == "OK") {
      result <- flatten(json$results)
      lon <- append(lon, result$geometry.location.lng[1])
      lat <- append(lat, result$geometry.location.lat[1])
    } else {  # handle the case with zero result
      print(paste(gsub("\\+", " ", university_name[i]), "not found."))
      notFound <- notFound + 1
      college_NA <- append(college_NA, university_name[i])
      lon <- append(lon, NA)
      lat <- append(lat, NA)
    }
  }
  # get ride of the plus signs "+", replace with spaces
  # (The escape sign are necessary in here, otherwise it will mach every gap)
  university_name <- gsub("\\+", " ", university_name)
  
  # combine the unique university_name, lon, and lat
  # (don't use cbind() in here, otherwise it will return a matrix)
  unique_table <- data.frame(university_name, lon, lat)
  
  # combine the answers and analysis
  answer <- list("unique_table" = unique_table, "notFound" = notFound, 
                 "college_NA" = college_NA)
  return(answer)
}


# Returns the University name with whitespace replaced by "+" plus sign, and
# trim the whitespaces in both heads and tails
getCleanName <- function(dataset) {
  university_name <- trimws(dataset$university_name) # trim the whitespaces
  university_name <- gsub("\\s", "+", university_name)  # Use RegEx to replace space with '+'
  return(university_name)
}
