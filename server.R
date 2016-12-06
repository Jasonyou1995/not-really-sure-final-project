# General Information:
##################################################
# INFO 201, Autumn 2016, Secton AB
# Team name: Not Really Sure
# Comtributors: Jason You, Alison McGuire, 

# Shiny app server
##################################################

#Script Sources and Modules: 
##################################################
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
##################################################

# Jason
source("scripts/buildLocalMap.R")
source("scripts/buildWorldMap.R")
##################################################


# Main Function: 
##################################################

# see example: https://shiny.rstudio.com/gallery/navbar-example.html
# for more information on how to structure your portion of this function

function(input, output, session) {
  # Alison's Plot
  output$Ratings <- renderPlotly({
    CreatePlot(input$year, input$country, input$variable)
  })
  
  # Jason's Plot: World Map and Local Map
  output$local_map <- renderLeaflet({
    localMap(my_university = input$university)
  })
  
  output$world_map <- renderLeaflet({
    worldMap(my_year = input$select_year)
  })
  
  # Put your graph here
}
##################################################

