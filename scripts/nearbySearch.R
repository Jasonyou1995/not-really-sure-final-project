# INFO 201, Autumn 2016, Secton AB
# Team name: Not Really Sure
# Comtributors: Jason You (please add your name in here, if you contributed)
#
# Bulid a "tree" (list) structure for the reference of the bars around
# each University. (bar_coordinate$one_university_name with return a dataframe
# of lon and lat for the bars)
# Also build a bar count table for the give dataset
#
# Note: please keep using the "data/newData/timesData_lonlat.csv" dataset
#       with the functions in this script to prevent errors (university names
#       may vary between different datasets)

source("scripts/installPackage.R")
source("scripts/factorToCharOrNum.R")
installPackage(c("jsonlite", "dplyr"))

# Input : dataset with column "university_name", "lon", "lat" (case sensitive)
#         required, and also require the my_type argument
# Output: return a dataset with the original dataset combined with three new
#         columns: longitude, latitude, and count of the interested sites
#         near the given location (within 5000 meters)
nearbySearch <- function(dataset, my_type) {
  if (!all(c('university_name', 'lon', 'lat') %in% names(dataset))) {
    stop(paste0("Error: \"university_name\" or \"lon\" or \"lat\" column ", 
                "not found, check you spelling"))
  }
  
  # in case the university_name is a factor type, so convert it to character
  dataset$university_name <- factorToCharOrNum(dataset$university_name)
  # get rid of redundency names
  unique_data <- dataset %>% distinct(university_name, .keep_all = TRUE) %>% 
    select(university_name, lon, lat)
  unique_name <- unique_data$university_name  # store all the unique names
  queries <- getQuery(unique_data, my_type)  # build queries for all
  total <- length(queries)  # total number of search
  count <- c()  # store count of location
  bar_coordinate <- list()  # store the bar_coordinate (include lon and lat for each name)
  
  # (can be used for debug)
  # print(queries)
  
  # store the count of sites nearby (nrow), and the coordinates of the sites
  for (i in 1:total) {
    print(paste(i, "/", total, ">>", round(i * 100 / total), "%"))  # process
    json <- fromJSON(queries[i])
    if (json$status == "OK") {
      bar_coordinate[[unique_name[i]]] <- 
        data.frame(lon = json$results$geometry$location$lng,
                   lat = json$results$geometry$location$lat)
      count <- append(count, nrow(json$results))
    } else {
      print(paste0(i, "-th queries not found: ", queries[i]))
      bar_coordinate[[unique_name[i]]] <- NA
      count <- append(count, NA)
    }
  }
  
  unique_data <- cbind(unique_data, bar_count = count)
  
  # backup bar_coordinate
  write.csv(unique_data, file = paste0("data/temp/", "unique_data_",
                                        date(), ".csv"), row.names = FALSE)
  
  # In case the lon and lat already exist
  # (If the lon and lat were removed accidentally, you can find the original
  # dataset in the "data/temp/old" repository)
  dataset$bar_count <- NULL
  
  dataset <- left_join(dataset, unique_data,
                       by = c("university_name", "lon", "lat"))
  
  # save and return the dataset
  write.csv(dataset, file = paste0("data/newData/barData/timesData",
                                   "_bar_count.csv"), row.names = FALSE)
  # save the locations of bars near each University in list format
  save(bar_coordinate, file = "data/newData/barData/bar_coordinates.Rda")
  return(dataset)
}

# build and return queries by the given dataset, and type or search
getQuery <- function(dataset, my_type) {
  base <- "https://maps.googleapis.com/maps/api/place/radarsearch/json?"
  apikey <- "key=AIzaSyCBmaTaH3g2XQKs34kNKt5wf8ZKx5h8-gc"  # Google Map key
  location <- paste0("location=", dataset$lat, ",", dataset$lon)
  radius <- 5000    # 5,000 meters search radius
  type <- gsub(" ", "+", trimws(my_type))
  queries <- paste0(base, apikey, "&", location, "&radius=", radius,
                  "&type=", type)
  return(queries)
}
