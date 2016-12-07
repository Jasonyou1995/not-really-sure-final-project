# not-really-sure-final-project
Final project for INFO201-a16 (Team: "Not Really Sure")

Product: 

##Basic Infomation

**Team:**

* Alison McGuire
* Matthew Tran
* Mitchell Deamon
* Shengwei You

**Data source**: 

* https://www.kaggle.com/mylesoneill/world-university-rankings
* Google MAP API

## Project Structure:

* Tools (packages):
	* Shiny App
	* Plotly
	* ggplot2
	* ggmap (`ggmap::geocode()`, `ggmap::qmplot()`)
	* Google Place API
	* Google Geomap API

	
## Product Building Plan:

* **Platform: Shiny App**
	* Tab 1:
		* Plot 1:
			* World Choropleth Maps with **plotly**:
				* coordinates: Universities
				* color: count of Universities
				* size of point: ...
				* type of point: ... (group by some variable?)
			* **Shiny** Widgets:
				* 1. Radio Buttons (Select different years)
				* 2. Slider (e.g, only show ranks from 1 to 50)
				* 3. Select Box (See below, Plot 2)
		* Plot 2:
			* Country bubble map plot with **plotly**:
				* Display each selected country (by select box in Shiny) in a plot
				* Plot the Universities with longitude and latitude
				* Assign **meaningful** and **interesitng** variables
			* **Shiny** Widgets:
				* Anything interesting ...
	* Tab 2:
		* Plot 3:
			* Google map nearby interesting features for each University
				* Use ggmap package to plot the backgroup map
				* mark the bar/library/restaurant etc on the map
		* Plot 4:
			* Use plotly (ggplotly) to analysis and show the relationship between the searched result (count, ave rate) and rankings (choose one dataset)
		* Option widget:
			* Add Shiny Text Input Widget to allow user to search nearby.


<hr/>

###Jason:
* **Works:**
	1. Found longitudes and latitudes for all the Universities from Google Geocode and Google Place apis.
		
			only one University can't be found: Chonnam National University, South Korean, lon = NA, lat = NA

	2. Contributed dataset:
	
			coord_reference.csv
			cwurData_count.csv
			wurData_lonlat.csv
			school_and_country_table_lonlat.csv
			shanghaiData_lonlat.csv
			timesData_count.csv
			timesData_lonlat.csv
		
	3. Contributed scripts/function:

		* **factorToCharOrNum.R** *(func)*
		* **buildLocalMap_ggplot2.R** *(with ggmap & plotly)*
		* **findCoordinates.R** *(main script for finding coordinas)*
		* **installPackage.R** *(func)*
		* **countUniversity.R**	*(count universities by country and year)*
		* **nearbySearch.R** *(locat some interesting things around campus from Google Place api)*

* Total Hour spent: _26 hours_
	* Including:
		* Learning (ggmap, Google apis, etc.): 9 hours
		* Get work done: 9 + 4.5 +3 hours = 16.5 hours (most of time was spent on debugging **findCoordinates.R**)
			* Also found the bar data (count and coordinates) around 5000 meter radius for each university
			* Visualized all the bars for each university
			* Visualized the relationship between the number of bar nearby and the ranking of the University
		* Planning time (plan the structure of our product): 0.5 hour

<hr/>