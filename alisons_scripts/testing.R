

# For Testing Purposes Only
##############################################################################

data <- read.csv('data/timesData.csv')
data$num_students <- gsub(",", "", data$num_students)
data$num_students <- as.numeric(data$num_students)
data$university_name <- as.character(data$university_name)

year.data <- data %>% 
  filter(year %in% 2011)
country.data <- year.data %>% 
  filter(country %in% "Canada")
final.data <- country.data %>% 
  select_('university_name', 'country', 'year', "num_students") %>% 
  filter(!is.na(num_students))

university_name <- c("College1", "COlleage2", "Collage3")
num_students <- c(52, 24,  45)
final <- data.frame(university_name, num_students)

plot <- plot_ly(final.data, x = ~university_name, y = ~in.value, text = ~university_name, 
                type = 'scatter', mode = 'markers',
                marker = list(size = 10, opacity = 0.5, color = 'rgb(255, 65, 54)')) %>%
  layout(title = paste(in.value, "in the year: ", in.year, "in the country: ", in.country),
         xaxis = list(showgrid = FALSE),
         yaxis = list(showgrid = FALSE))
return(plot)

##############################################################################