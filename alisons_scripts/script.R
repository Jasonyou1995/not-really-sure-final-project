# Author: Alison McGuire
#
# Purpose: Makes function CreatePlot
#
# Description: CreatePlot takes in a year, country and a value and creates a Plotly scatter plot
# 
#####################################################################################
# Usable code Start

library(dplyr)
library(plotly)

# Gathering the data:
########################
data <- read.csv('data/timesData.csv')

# Fixing data
# Number of Students
data$num_students <- gsub(",", "", data$num_students)
data$num_students <- as.numeric(data$num_students)
# Percent International Students
data$international_students <- gsub("%", "", data$international_students)
data$international_students <- as.numeric(data$international_students)
data$international_students <- (data$international_students / 100)
# Female to male ratio
data$female_male_ratio <- as.numeric(data$female_male_ratio)
data$female_male_ratio <- (data$female_male_ratio / 100)

# Creating Plot:
#########################

CreatePlot <- function(in.year, in.country, in.value){
  if (in.year != 'All'){
    data <- data %>% 
      filter(year %in% in.year)
  }
  if (in.country != 'All'){
    data <- data %>% 
      filter(country %in% in.country)
  }
  final.data <- data %>% 
    select_('university_name', 'country', 'year', in.value) %>% 
    filter(!is.na(in.value))
  
  plot <- plot_ly(final.data, x = ~university_name, y = ~in.value, text = ~university_name, 
                  type = 'scatter', mode = 'markers',
                  marker = list(size = 2, opacity = 0.5, color = 'rgb(255, 65, 54)')) %>%
    layout(title = paste(in.value, "in the year: ", in.year, "in the country: ", in.country),
           xaxis = list(showgrid = FALSE),
           yaxis = list(showgrid = FALSE))
  return(plot)
}



# Usable code end
##############################################################################




