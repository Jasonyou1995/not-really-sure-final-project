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
  final <- data %>% 
    select_('university_name', 'country', 'year', in.value) %>% 
    filter(!is.na(income))
  
  p <- plot_ly(final, x = ~university_name, y = ~in.value, text = ~university_name, 
               type = 'scatter', mode = 'markers', color = ~in.value, colors = 'Reds'
              # marker = list(size = ~in.value, opacity = 0.5)
               ) %>%
    layout(title = paste(in.value, "in", in.year, "in", in.country),
           xaxis = list(showgrid = FALSE),
           yaxis = list(showgrid = FALSE))
  return(p)
  
}

CreatePlot(2011, 'Canada', 'income') 


# Usable code end
##############################################################################




# For Testing Purposes Only
##############################################################################
test <- data %>% 
  filter(year %in% 2011)
test <- test %>% 
  filter(country %in% 'United States of America')
test <- test %>% 
  select_('university_name', 'income') %>% 
  filter(!is.na(income))
test[, 2] <- as.numeric(as.character( test[, 2] ))

university <- c('Washingotn', 'Oregon', 'Colorado')
rank <- c(10, 30, 25)

test2 <- data.frame(university, rank)

p <- plot_ly(test2, x = ~university, y = ~rank, 
             type = 'scatter', mode = 'markers', color = ~rank, colors = 'Reds',
             marker = list(opacity = 0.5)) %>%
  layout(title = '',
         xaxis = list(showgrid = FALSE),
         yaxis = list(showgrid = FALSE))
p
##############################################################################

