

# For Testing Purposes Only
##############################################################################

data <- read.csv('data/timesData.csv')

data <- data %>% 
  filter(year %in% 2011)
data <- data %>% 
  filter(country %in% "Canada")
data <- data %>% 
  select_('university_name', 'country', 'year', "income") %>% 
  filter(!is.na(income))

plot <- plot_ly(data, x = ~university_name, y = ~income, text = ~university_name, 
                type = 'scatter', mode = 'markers',
                marker = list(opacity = 0.5, color = 'rgb(255, 65, 54)')) %>%
  layout((title = "Title"),
         xaxis = list(showgrid = FALSE),
         yaxis = list(showgrid = FALSE))
plot

##############################################################################