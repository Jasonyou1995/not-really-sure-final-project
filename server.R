# General Information:
##################################################
# INFO 201, Autumn 2016, Secton AB
# Team name: Not Really Sure
# Contributors: Jason You, Alison McGuire, Matthew Tran
#
# Shiny app server
##################################################

#Script Sources and Modules: 
##################################################

source("scripts/installPackage.R")
installPackage(c("shinythemes", "shiny", "leaflet", "markdown"))
# Data for the universities of the world
world_university_rankings <- read.csv("data/cwurData.csv", stringsAsFactors = FALSE)

# source("scripts/installPackage.R")
# installPackage(c("shinythemes", "shiny", "leaflet", "markdown"))  # deprecated
# install.packages(c("shinythemes", "shiny", "leaflet", "markdown"))
require(shinythemes)
require(shiny)
require(leaflet)
require(markdown)
require(plotly)

# Alison
source('alisons_scripts/script.R')

# Jason
source("scripts/buildLocalMap.R")
source("scripts/buildWorldMap.R")
source("scripts/small_plots.R")
##################################################


# Main Function: 
##################################################

# see example: https://shiny.rstudio.com/gallery/navbar-example.html
# for more information on how to structure your portion of this function

shinyServer(function(input, output, session) {
  ####################################
  # Alison's Plot
  output$Ratings <- renderPlotly({
    return(CreatePlot(input$get.year, input$get.country, input$variable))
  })
  ####################################
  ####################################
  # Jason's Plot: World Map and Local Map
  
  output$local_map <- renderLeaflet({
    localMap(my_university = input$university)
  })
  
  output$world_map <- renderLeaflet({
    worldMap(my_year = input$select_year)
  })
  
  output$getChoroplethMap <- renderPlotly({
    getChoroplethMap(input$select_year)
  })
  
  output$getBarPlot <- renderPlotly({
    getBarPlot(input$university)
  })
  ####################################
  ####################################
  # Matthew's Plot: University rankings by score
  output$ranking <- renderPlotly({
    filtered <- filter(world_university_rankings, country == input$country)
    return(plot_ly(data = filtered, x = ~filtered$institution, y = ~filtered$score, type = 'bar') %>% 
             layout(xaxis = list(title = "University", showticklabels = FALSE),
                    yaxis = list(title = "Score")))
  })
  #####################################
})
