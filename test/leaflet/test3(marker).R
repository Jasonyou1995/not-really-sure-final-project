library(leaflet)

# Demo 1
data(quakes)
# Show first 20 rows from the `quakes` dataset
leaflet(data = quakes[1:20,]) %>% addTiles() %>% 
  addMarkers(~long, ~lat, popup = ~as.character(mag))

# Demo 2
greenLeafIcon <- makeIcon(
  iconUrl = "https://cdn3.iconfinder.com/data/icons/beach-and-vacation-icons/512/Cocktail-512.png",
  iconWidth = 38, iconHeight = 36,
  iconAnchorX = 22, iconAnchorY = 94
)

leaflet(data = quakes[1:4,]) %>% addTiles() %>%
  addMarkers(~long, ~lat, icon = greenLeafIcon)

# Demo 3
# Make a list of icons. We'll index into it based on name.
oceanIcons <- iconList(
  ship = makeIcon("abc", "https://cdn2.iconfinder.com/data/icons/travel-set-2/512/5-512.png", 18, 18),
  pirate = makeIcon("danger-24.png", "http://cliparts.co/cliparts/Bcg/rpj/Bcgrpjd9i.jpg", 24, 24)
)

# Some fake data
df <- sp::SpatialPointsDataFrame(
  cbind(
    (runif(20) - .5) * 10 - 90.620130,  # lng
    (runif(20) - .5) * 3.8 + 25.638077  # lat
  ),
  data.frame(type = factor(
    ifelse(runif(20) > 0.75, "pirate", "ship"),
    c("ship", "pirate")
  ))
)

leaflet(df) %>% addTiles() %>%
  # Select from oceanIcons based on df$type
  addMarkers(icon = ~oceanIcons[type])

# Demo 4
leaflet(quakes) %>% addTiles() %>% addMarkers(
  clusterOptions = markerClusterOptions())  # find lon/lng/long/longitude and
                                           # lat/latitude automatically

# Demo 5
leaflet(df) %>% addTiles() %>% addCircleMarkers()

# Demo 6
# Create a palette that maps factor levels to colors
pal <- colorFactor(c("navy", "red"), domain = c("ship", "pirate"))

leaflet(df) %>% addTiles() %>% 
  addCircleMarkers(
    radius = ~ifelse(type == "ship", 6, 10),
    color = ~pal(type),
    stroke = FALSE,  # the boundary
    fillOpacity = 0.5
  )
