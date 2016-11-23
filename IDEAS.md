# PUSH IDEAS HERE

## Jason:

1. Find the **corelation coefficients** of interesting variable pairs, and then visualize (compare) the differences between these variables.
2. Get the longitude and latitude from Google Map API, and then visualize it on the world map (grouped and colored scatter plot):
	3. Use the count to color different countries;
	4. Lable each dot with the name, rank, and some other useful information
	5. _If using Shiny App_: use widgets that allow users to choose from different ranks
	6. _Consider to use the school_and_country_table_
6. Visualize the regression lines (can be non-linear) and confidence interval for the scatter plot (by scatterD3 or ggplot2 + plotly) with x = universities, y = some_variables_from_dataset.
7. _ShanghaiData_: group by year, and Visualize the trent for the choosed University (by showing the regression line and ranking changes)
8. Sorting the data by different variables and then visualize all of theses rankings (can be grouped by one Shiny app)
9. Using Google Knowledge Graph to get information about each university

## Alison: 

My idea was to have three pages, one being a wordly map, another being a scatter plot (with many factors) and lastly an overall rating.
1. I agree with Jason about the mapping, using lon and lat found from the Google Map API would definitely be cool. Another (possibly easier) suggestion would be to do a chlorpleth map. Using the Educational attainment data we could map by country. Using these as factors:
 a. Number of schools in each country.
 b. Average attainment score.
 c. Any other ideas?

2. Using scoring data, we should have some sort of grpah that takes an input of some factor and outputs the graph for that factor. This would be the overall score for each factor, in some cases we might have to average based on year or duplicates from different sources.
We would do this using a plotly bubble graph with shiny widgets (for the input and output). Factors would include:
 a. Number of Students
 b. Staff to Student Ratio
 c. Teaching score 
 d. Percentage International Students
 e. Female to male ratio
 f. Total Score
 g. Alumni score 
 h. Research Score
 
(Another thought would be to specify a school and then that school could be highlighted a different color, in order to see how one specific school compares to all others based on each factor.)

3. There are two seperate types of data, one being a ranking another being a score. Above I was speaking about different scores, we could also do a bar graph with ratings specified by year. We would take just the overall rank (averaged over each data set) and the user would specify year and country. It would return a bar graph of ratings of all of the schools within that country and in that year. 


