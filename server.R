# General Information:
##################################################
# INFO 201, Autumn 2016, Secton AB
# Team name: Not Really Sure
# Comtributors: Jason You, Alison McGuire, 

# Shiny app server
##################################################

# Scripts and Modules: 
##################################################
# Jason
#source("scripts/installPackage.R")
#installPackage(c(...))

# Alison
source('alisons_scripts/script.R')
##################################################

# Main Function: 
##################################################

# see example: https://shiny.rstudio.com/gallery/navbar-example.html
# for more information on how to structure your portion of this function

function(input, output, session) {
  # Alison's Plot
  output$Ratings <- renderPlot({
    CreatePlot(input$year, input$country, input$variable)
  })
  
  # Put your graph here
}
##################################################

