# This is a ggmap test script
# by Jason You
# Last modifying date: Nov 24, 2016

# issues:
# ggmap throws some error when I first time try to use it:
# I didn't find the bug, but now it works after:
## 1. 

library(ggplot2)
library(ggmap)
library(plotly)
library(jsonlite)

# first plot
murder <- subset(crime, offense == "murder")
p1 <- qmplot(lon, lat, data = murder, colour = I('red'), size = I(3), darken = .3)

# second plot
uw <- "University of Washington, Seattle"
p2 <- qmap(uw, zoom = 13)

# third plot
p3 <- qmap(uw, zoom = 14, source = "osm")

# geocode sample
code <- geocode("the white house")

# Use google's api 'geocode' to get coordinates
# result is the same as that from geocode
base <- "https://maps.googleapis.com/maps/api/geocode/json?"
address <- "the+white+house"
apikey <- "AIzaSyAcVJX23OKa0c5wwTQdGLvlO5GaqrxZWao"
query <- paste0(base, "address=", address, "&key=", apikey)
coordinates <- flatten(fromJSON(query)$results)
lat <- coordinates$geometry.location.lat
lng <- coordinates$geometry.location.lng

# fourth plot
# `jitter()` add some noise
set.seed(500)
df <- round(data.frame(
  x = jitter(rep(-95.36, 50), amount = .3),
  y = jitter(rep( 29.76, 50), amount = .3)
), digits = 2)

map <- get_googlemap('houston', markers = df, path = df, scale = 2)

p4 <- ggmap(map, extent = 'device')

# difference styles for Stamen Maps and CloudMade Maps
# There're three available tile sets: terrain, watercolor, and toner
p5 <- qmap(uw, zoom = 14, source = "stamen", maptype = "watercolor")
p6 <- qmap(uw, zoom = 14, source = "stamen", maptype = "toner")

# fifth plot
paris <- get_map(location = "paris")
str(paris)

p7 <- qmap(uw, zoom = 14, maptype = 53428, api_key = apikey, source = "cloudmade")
p8 <- qmap("houston", zoom = 10, maptype = 58916, api_key = apikey, source = "cloudmade")
p9 <- ggmap(paris, extent = "normal")

## crime example
str(crime)
# only violent crimes
violent_crimes <- subset(crime,
                         offense != "auto theft" & offense != "theft" &
                           offense != "burglary")
violent_crimes$offense <- factor(violent_crimes$offense,
                                 levels = c("robbery", "aggravated assault", "rape", "murder"))

# restrict to downtown
violent_crimes <- subset(violent_crimes, -95.39681 <= lon & lon <= -95.34188 &
                           29.73631 <= lat & lat <= 29.78400)

theme_set(theme_bw(16))
HoustonMap <- qmap("houston", zoom = 14, color = "bw", legend = "topleft")

ex1 <- HoustonMap + geom_point(aes(lon, lat, colour = offense, size = offense),
                        data = violent_crimes)

ex2 <- HoustonMap + stat_bin2d(
  aes(lon, lat, color = offense, fill = offense),
  size = 0.5, bins = 30, alpha = 1/2,
  data = violent_crimes
)

## crime example 2

houston <- get_map("houston", zoom = 14)
HoustonMap <- ggmap("houston", extent = "device", legend = "topleft")

ex3 <- HoustonMap + 
  stat_density2d(
    aes(x = lon, y = lat, fill = ..level.., alpha = ..level..),
    size = 2, bins = 4, data = violent_crimes,
    geom = "polygon"
  )

