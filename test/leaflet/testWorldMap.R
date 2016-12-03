# INFO 201, Autumn 2016, Secton AB
# Team name: Not Really Sure
# Comtributors: Jason You (please add your name in here, if you contributed)
#
# Build a `map` to visualize all the Universities on the world map
# User can choose years from 2011 to 2016

source("scripts/installPackage.R")
source("scripts/factorToCharOrNum.R")
installPackage(c("leaflet", "dplyr"))

# Mark all the Universities on a leaflet world map
# User can select the year 
worldMap <- function(my_year = 2016) {
  # my_year must be in 2011-2016, otherwise throws an error
  if (!my_year %in% 2011:2016) {
    stop(paste("Got input:", my_year, 
               "\nExpected year range from 2011 to 2016."))
  }
  
  # Read in data and choose 2016 year data only
  #   # number of Universities in each country
  #   university_count <- read.csv("data/newData/timesData_count.csv",
  #                                stringsAsFactors = FALSE)
  #   selected_count <- university_count %>% filter(year == my_year)
  
  # Times data with longitudes and latitudes of each University
  timesData <- read.csv("data/newData/timesData_lonlat.csv",
                        stringsAsFactors = FALSE)
  selected_data <- timesData %>% filter(year == my_year)
  
  # contents shown in popup
  attach(selected_data)  # directly access all the variable names
  content <- paste(sep = "<br/>",
                   paste0("<b>", university_name, "</b>"),
                   paste0("Country/Region: ", "<i>", country, "</i>"),
                   paste0("World rank: ", "<i>", world_rank, "</i>"))
  detach(selected_data)
  
  world_map <- leaflet(selected_data) %>% 
    addTiles() %>%
    addMarkers(clusterOptions = markerClusterOptions(), 
               popup = ~content)
  
  return(world_map)  # show the map
}
