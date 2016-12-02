# General Informaiton: 
##################################################
# INFO 201, Autumn 2016, Secton AB
# Team name: Not Really Sure
# Comtributors: Jason You (please add your name in here, if you contributed)

# Shiny app ui
##################################################

#Script Sources and Modules: 
##################################################
library(shiny)
library(markdown)

# Jason
source("scripts/installPackage.R")
installPackage(c(...))

# Alison
source('alisons_scripts/script.R')
##################################################

# Main: 
##################################################

# see example: https://shiny.rstudio.com/gallery/navbar-example.html
# for more information on how to structure your portion of this function

# Creates Navigation bar
navbarPage("World Wide Universities",
           # Alison's Tab
           ######################################
           tabPanel("Rankings Plot",
                    sidebarLayout(
                      sidebarPanel(
                        radioButtons("plotType", "Plot type",
                                     c("Scatter"="p", "Line"="l"))
                      ), 
                      mainPanel(plotOutput("Ratings"))
                    )
           ),
           ######################################
           
           # Summary Tab
           ######################################
           tabPanel("Summary",
                    includeMarkdown("IDEAS.md")
           )
           ######################################
)
#####################################################

