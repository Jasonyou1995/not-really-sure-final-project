# INFO 201, Autumn 2016, Secton AB
# Team name: Not Really Sure
# Comtributors: Jason You
#
# Build 4 plots that will be integrated in the legends in the world map

# Plot 1: Choropleth Map (Integrated into the world map)
library(plotly)

getChoroplethMap <- function(my_year) {
  
  count_data <- read.csv("data/newData/timesData_count.csv",
                         stringsAsFactors = FALSE) %>% 
    filter(year == my_year)
  
  # specify map projection/options
  l <- list(color = toRGB("grey"), width = 0.5)
  
  g <- list(
    showframe = FALSE,
    showcoastlines = FALSE,
    projection = list(type = 'Mercator')
  )
  
  # use count to fill the colors, and it's 'colors' with 's'
  choro_map <- plot_geo(count_data) %>%
    add_trace(
      z = ~count, color = ~count, colors = 'Set3', locations = ~code,
      marker = list(line = l), showscale=FALSE, 
      text = ~country
    ) %>%
    layout(
      title = paste0(my_year, ' University count in each country', 
                     '<br>Source:<a href="https://www.kaggle.com/', 
                     'mylesoneill/world-university-rankings">', 
                     'World University Rankings</a>'),
      geo = g
    )
  
  return(choro_map)
}


# Plot 2: histogram that shows the the distribution of number of bars for
#         each University
getHistogram <- function() {
  bar_data <- read.csv("data/newData/barData/timesData_bar_count_2016_top200.csv",
                       stringsAsFactors = FALSE)
  my_histogram <- plot_ly(x = bar_data$bar_count, 
                          type = "histogram",
                          color = "red") %>% 
    layout(xaxis = list(title = "Number of bars"),
           yaxis = list(title = "Count of Universities"))
  return(my_histogram)
}

# Plot 3: for local plot bar
getBarPlot <- function(my_university = "University of Washington Seattle") {
  bar_data <- read.csv("data/newData/barData/timesData_bar_count_2016_top200.csv",
                       stringsAsFactors = FALSE)
  
  my_barplot <- plot_ly(
    x = c("Research (%)", "Teaching (%)", "International (%)", 
          "Total score (%)", "Bar count"),
    y = c(d$research, d$teaching, d$international, d$total_score, d$bar_count),
    showlegend = FALSE,
    type = "bar",
    mode = "markers"
  )
  
  return(my_barplot)
}

# Plot 4: 3d scatter plot_ly for scores of "research", "teaching", and
# "international"
get3dPlot <- function(my_year = 2015) {
  world_data <- read.csv("data/newData/timesData_lonlat.csv",
                         stringsAsFactors = FALSE) %>% 
    filter(year == my_year)
  
  # Create lists for axis properties
  f1 <- list(
    family = "Arial, sans-serif",
    size = 18,
    color = "lightgrey")
  
  f2 <- list(
    family = "Old Standard TT, serif",
    size = 14,
    color = "#ff9999")
  
  axis <- list(
    titlefont = f1,
    tickfont = f2,
    showgrid = F
  )
  
  scene <- list(
    xaxis = axis,
    yaxis = axis,
    zaxis = axis,
    camera = list(eye = list(x = -1.25, y = 1.25, z = 1.25)))
  
  my_3dplot <- plot_ly(
    data = world_data,
    x = ~teaching,
    y = ~international, 
    z = ~research, 
    size = I(3.6),
    color = ~country,
    showlegend = FALSE,  # hide the legend
    type = "scatter3d",
    hoverinfo = "text",  # use this to choose what to show in tooltip
    text = paste0("<b>", world_data$university_name, "</b><br>",
                  "Teaching: ", world_data$teaching, "<br>",
                  "International: ", world_data$international, "<br>",
                  "Research: ", world_data$research, "<br>",
                  world_data$country), 
    mode = "markers") %>% 
    layout(title = "University scoring", scene = scene)
  
  return(my_3dplot)
}

