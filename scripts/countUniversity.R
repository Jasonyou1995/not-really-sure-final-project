# INFO 201, Autumn 2016, Secton AB
# Team name: Not Really Sure
# Comtributors: Jason You (please add your name in here, if you contributed)
#
# Count the number of Universities in each country
# (hint: You can use this dataset in world map plot with Plotly, color = count)

source("scripts/installPackage.R")
source("scripts/factorToCharOrNum.R")
installPackage(c("dplyr", "countrycode", "plotly"))

# Input : require "university_name", "country", and "year" columns
#         (case sensitive)
# Output: return a data frame with the "country", "university_count", and
#         "year"
countUniversity <- function(dataset, output_name = "output") {
  try(if (!all(c("university_name", "country", "year") %in% names(dataset))) {
    stop(paste("Error: \"university_name\", \"contry\", and \"year\" columns",
               "required, please check you spelling."))
  })
  dataset$university_name <- factorToCharOrNum(dataset$university_name)
  dataset$country <- factorToCharOrNum(dataset$country)
  dataset$year <- factorToChar(dataset$year, type = "numeric")
  
  # group by year and country, add country code, arrange by year and dec(count)
  result <- dataset %>% 
    group_by(year, country) %>% 
    summarise(count = n()) %>% 
    mutate(code = countrycode(country, "country.name", "iso3c")) %>% 
    arrange(year, -count)
  
  # store data with given output_name, and return the result
  write.csv(result, file = paste0("data/newData/", output_name, "_count.csv"))
  return(result)
}


# This is a sample dot plot with ggplot2 and ggplotly, and please don't use
# this plot in the final project directly without refine it. 
simplePlot <- function(plot_data) {
  p <- ggplot(plot_data, aes(country, count, 
                             size = count, color = country, frame = year)) + 
      geom_point() +
      # suppress all the legends and x axis marks
      theme(axis.title.x=element_blank(), axis.text.x=element_blank(),
            axis.ticks.x=element_blank(), legend.position = "none") + 
      facet_wrap(~year, scale="free")
  # show ggplot with plotly
  ggplotly(p)
}
