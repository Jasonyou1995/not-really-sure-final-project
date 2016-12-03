require(leaflet)

# Demo 1
m <- leaflet() %>% 
  addTiles() %>% # Add default OpenStreetMap map tiles
  addMarkers(lng = 174.768, lat = -36.852, popup = "The birthplace of R")
m   # Print the map

# Demo 2
DF <- data.frame(Lat = 1:10, Long = rnorm(10))
leaflet(DF) %>% addCircles()

# Demo 3
leaflet(DF) %>% addCircles(lng = ~Long, lat = ~Lat)

# Demo 4
leaflet() %>% addCircles(data = DF)
# the same
leaflet() %>% addCircles(data = DF, lat = ~ Lat, lng = ~ Long)

# Demo 5
library(maps)
mapStates <- map("state", fill = TRUE, plot = FALSE)
leaflet(data = mapStates) %>% addTiles() %>% 
  addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)

# Demo 6
m <- leaflet() %>% addTiles()
DF <- data.frame(
  lat = rnorm(100),
  lng = rnorm(100),
  size = runif(100, 5, 20),
  color = sample(colors(), 100)
)
m <- leaflet(DF) %>% addTiles()
m %>% addCircleMarkers(radius = ~size, color = ~color, fill = FALSE)
m %>% addCircleMarkers(radius = runif(100, 4, 10), color = c('red'))
