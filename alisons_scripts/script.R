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
# World Rank
data$world_rank <- as.numeric(data$world_rank)
# University Name
data$university_name <- as.character(data$university_name)
# Country
data$country <- as.character(data$country)
# Teaching Score
data$teaching <- as.numeric(data$teaching)
# Research 
data$research <- as.numeric(data$research)
# Income
data$income <- as.numeric(data$income)
# Total Score
data$total_score <- as.numeric(data$total_score)
# Number of Students
data$num_students <- gsub(",", "", data$num_students)
data$num_students <- as.numeric(data$num_students)
# Student to Staff Ratio
data$student_staff_ratio <- as.numeric(data$student_staff_ratio)
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
    select_('university_name', 'country', 'year', value = in.value) %>% 
    filter(!is.na(in.value))
  
  plot <- plot_ly(final.data, x = ~university_name, y = ~value, 
                  type = 'scatter', mode = 'markers',
                  marker = list(size = 10, opacity = 0.5, color = ~value, colors = "Reds"),
                  hoverinfo = 'text',
                  text = ~paste("School:", final.data$university_name, "<br>Country:", final.data$country, "<br>", value)
                  ) %>%
    layout(title = paste(in.value, "in the year: ", in.year, "in the country: ", in.country),
           xaxis = list(showgrid = FALSE),
           yaxis = list(showgrid = FALSE))
  return(plot)
}

CreatePlot(2011, "Canada", 'num_students')

# Usable code end
##############################################################################




