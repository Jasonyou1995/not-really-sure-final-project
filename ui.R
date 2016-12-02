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
#source("scripts/installPackage.R")
#installPackage(c(...))

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
                        # Gets year input
                        selectInput("year", label = h3("Select Year"), 
                                    choices = list("All Years" = 'All', "2011" = 2011, "2012" = 2012, "2013" = 2013, 
                                                   "2014" = 2014, "2015" = 2015, "2016" = 2016), selected = 'All'),
                        # Gets country input
                        textInput("country", label = h3("Enter Name of Country"), value = "All"),
                        # Gets variable input
                        radioButtons("variable", label = h3("Type of Variable"),
                                     choices = list("Total Score" = 'total_score', "Teaching Score" = 'teaching', 
                                                    "Research Score" = 'research', "Income Score" = 'income', 
                                                    "Number of Students" = 'num_students', 
                                                    "Student to Staff Ratio" = 'student_staff_ratio',
                                                    "Percentage of International Students" = 'international_students',
                                                    "Female to Male Ratio" = 'female_male_ratio'), selected = 'total_score')
                       
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

