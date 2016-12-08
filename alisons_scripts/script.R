##################################################################################
# Author: Alison McGuire
#
# Purpose: Makes function CreatePlot
#
# Description: CreatePlot takes in a year, country and a value and creates a Plotly scatter plot
#
#####################################################################################

######################
#packages

library(dplyr)
library(plotly)
########################

#########################
# Gathering the data:
data <- read.csv('data/timesData.csv')

# Fixing data
# World Rank
data$world_rank <- as.numeric(data$world_rank) #sets world rank as a numeric
# University Name
data$university_name <- as.character(data$university_name) #sets the university name as a character
# Country
data$country <- as.character(data$country) #sets country as a character
# Teaching Score
data$teaching <- as.numeric(data$teaching) #sets teaching score as a numeric
# Research 
data$research <- as.numeric(data$research) #sets research score as a numeric
# Income
data$income <- as.numeric(data$income) #sets income score as a numeric
# Total Score
data$total_score <- as.numeric(data$total_score) #sets total score as a numeric
# Number of Students
data$num_students <- gsub(",", "", data$num_students) #gets rid of the comma in the number of students
data$num_students <- as.numeric(data$num_students) #sets number of students as a numeric
# Student to Staff Ratio
data$student_staff_ratio <- as.numeric(data$student_staff_ratio) #sets the student to staff ratio as a numeric
# Percent International Students
data$international_students <- gsub("%", "", data$international_students) #gets rid of the percent sign 
data$international_students <- as.numeric(data$international_students) #sets % international students as a numeric
data$international_students <- (data$international_students / 100) #divides it by 100 to create a decimal number
# Female to male ratio
data$female_male_ratio <- as.numeric(data$female_male_ratio) #sets the female to male ratio as a numeric
data$female_male_ratio <- (data$female_male_ratio / 100) #divides it by 100 to create a decimal number
###########################

################################################

# Creating Plot:
CreatePlot <- function(in.year, in.country, in.value){
  # if the year is not all, then only use the data that is in the year specified
  if (in.year != 'All'){ #checks to see if the input was not All
    data <- data %>%  #if a year was specified then filter the data by that year
      filter(year %in% in.year)
  }
  # if the country is not all, then only use the data that is in the country specified
  if (in.country != 'All'){ #checks to see if the input was not All
    data <- data %>% #if a country was specified then filter the data by that country
      filter(country %in% in.country)
  }
  # selects only the data that is specified in the variable inputted
  final.data <- data %>%  
    select_('university_name', 'country', 'year', value = in.value) %>% 
    filter(!is.na(in.value)) #gets rid of the NA values
  
  #creates the plotly scatter plot
  plot <- plot_ly(final.data, x = ~university_name, y = ~value, 
                  type = 'scatter', mode = 'markers',
                  #markers specifications
                  marker = list(size = 10, opacity = 0.5, color = ~value, colors = "Reds"),
                  hoverinfo = 'text',
                  #sets the hover text
                  text = ~paste("School:", final.data$university_name, "<br>Country:", final.data$country, "<br>", value)
                  ) %>%
    layout(title = "",
           xaxis = list(title = "", showgrid = FALSE,
                        showticklabels = FALSE),
           yaxis = list(title = "Value", showgrid = FALSE))
  #function will return a plot
  return(plot)
}


##############################################################################




