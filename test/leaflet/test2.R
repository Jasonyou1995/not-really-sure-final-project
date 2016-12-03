library(leaflet)

# Demo 1
m <- leaflet() %>% setView(lng = -71.0589, lat = 42.3601, zoom = 12)
# m <- leaflet() %>% setView(lng = -71.0589, lat = 42.3601, zoom = 18)
# m <- leaflet() %>% setView(lng = -71.0589, lat = 42.3601, zoom = 3)

m %>% addTiles()

# Demo 2
m %>% addProviderTiles("Stamen.Toner")
m %>% addProviderTiles("CartoDB.Positron")

# Demo 3
leaflet() %>% addTiles() %>% setView(-93.65, 42.0285, zoom = 4) %>%
  addWMSTiles(
    "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi",
    layers = "nexrad-n0r-900913",
    options = WMSTileOptions(format = "image/png", transparent = TRUE),
    attribution = "Weather data © 2012 IEM Nexrad"
  )

# Demo 4
m %>% addProviderTiles("MtbMap") %>% 
  addProviderTiles("Stamen.TonerLines",
                   options = providerTileOptions(opacity = 0.35)
  ) %>% 
  addProviderTiles("Stamen.TonerLabels")
