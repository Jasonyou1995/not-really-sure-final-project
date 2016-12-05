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
  
  # Times data with longitudes and latitudes of each University
  timesData <- read.csv("data/newData/timesData_lonlat.csv",
                        stringsAsFactors = FALSE)
  selected_data <- timesData %>% filter(year == my_year)
  
  # contents show in popup
  content <- paste(sep = "<br/>",
                   paste0("<b style=\"color:LightSeaGreen;\">", 
                          selected_data$university_name,
                          " <span style=\"color:Wheat;\">(", 
                          my_year, ")</span>", "</b>"),
                   paste0("Country/Region: ", 
                          "<i style=\"color:DeepPink;\">", 
                          selected_data$country, "</i>"),
                   paste0("World Rank: ", 
                          "<i style=\"color:DeepPink;\">", 
                          selected_data$world_rank, "</i>"),
                   paste0("Female/Male Ratio: ", 
                          "<i style=\"color:DeepPink;\">",
                          selected_data$female_male_ratio, "</i>"),
                   paste0("International Students: ", 
                          "<i style=\"color:DeepPink;\">", 
                          selected_data$international_students, "</i>"),
                   paste0("Number of Students: ", 
                          "<i style=\"color:DeepPink;\">", 
                          selected_data$num_students, "</i>"),
                   paste0("Student/Staff Ratio: ", 
                          "<i style=\"color:DeepPink;\">",
                          selected_data$student_staff_ratio, "</i>"))
  
  # make university icon
  university_icon <- makeIcon(
    iconUrl = "img/university_icon.png",
    iconWidth = 20, iconHeight = 20
  )
  
  world_map <- leaflet(selected_data) %>% 
    addTiles() %>%
    addMarkers(clusterOptions = markerClusterOptions(), 
               lng = ~lon,
               lat = ~lat,
               popup = ~content,
               icon = university_icon)
  
  return(world_map)  # show the map
}
