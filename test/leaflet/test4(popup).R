library(leaflet)

# Demo 1
content <- paste(sep = "<br/>",
                 "<b><a href='http://www.samurainoodle.com'>Samurai Noodle</a></b>",
                 "606 5th Ave. S",
                 "Seattle, WA 98138"
)

leaflet() %>% addTiles() %>% 
  addPopups(-122.327298, 47.597131, popup = content,
            options = popupOptions(closeButton = FALSE)
  )

# Demo 2
library(htmltools)

df <- read.csv(textConnection(
  "Name,Lat,Long
  Samurai Noodle,47.597131,-122.327298
  Kukai Ramen,47.6154,-122.327157
  Tsukushinbo,47.59987,-122.326726"
))

leaflet(df) %>% addTiles() %>%
  addMarkers(~Long, ~Lat, popup = ~htmlEscape(Name))
