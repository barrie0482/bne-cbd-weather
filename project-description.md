---
output: html_document
---
#### **Project Background**

This assignment is the course project for the **Developing Data Products** subject of the Data Science Specialization run by Coursera and Johns Hopkins University. 

The project requires a Shiny application to be created and deployed on Rstudio's servers.

The application must include the following:

1. Some form of input (widget: textbox, radio button, checkbox, ...)
2. Some operation on the ui input in sever.R
3. Some reactive output displayed as a result of server calculations
4. You must also include enough documentation so that a novice user could use your application.
5. The documentation should be at the Shiny website itself. Do not post to an external link.

#### **Project Description**
This application uses [Brisbane CBD (Brisbane) 2012 hourly air quality and meteorological data](Brisbane_Central_Business_District_-_Air_Quality_Monitoring_-_2012.html) sourced from the [Queensland Govenment Data website](https://data.qld.gov.au/). Data metric definitions and data collection details can be found in this [document](Brisbane_Central_Business_District_-_Air_Quality_Monitoring_-_2012.html).

The application displays weather information for the Brisbane Central Business District for the year 2012. The [City of Brisbane](https://www.google.com.au/maps/place/Brisbane+QLD/@-27.4748262,153.0054462,14z/data=!4m5!3m4!1s0x6b91579aac93d233:0x402a35af3deaf40!8m2!3d-27.4710107!4d153.0234489) is the capital city of the state of Queensland in Australia.

#### **Data Exploration and Cleansing**
The initial data was loaded and reviewed. The fields required (Date,Time,Wind.Direction, Wind.Speed and Air.Temperature) for this project were extracted and saved to a new data set. Missing data for Wind.Speed and Air.Temperature, was imputed using the mean value of the previous value to the missing value and the next 9 values.

The final fields selected for this project were **Date,Time, Wind.Speed and Air.Temperature**.

This script takes the [downloaded data](http://ehp.qld.gov.au/data-sets/brisbanecbd-aq-2012.csv), cleans it and creates a data file ready to use by the application.  

* [bne-cbd-air.R](https://github.com/barrie0482/bne-cbd-weather/blob/master/bne-cbd-air.R)

#### **Application**

##### **_Objective 1. Some form of input (widget: textbox, radio button, checkbox, ...)_**
The application uses the **Date input** widget to get input from the application user. The data used is restricted to the year 2012. When the application starts, the first and last date available in the dataset is calculated from the loaded dataset. 

The calculated first date (minumum) and the last date (maximum) is passed to the **Date input** widget to set the min and max dates as well as the default date for when the application starts.

##### **_Objective 2. Some operation on the ui input in sever.R_**

When the user selects a date using the **Date input** widget, the server selects and prepares the data for that date. The wind speed supplied by the dataset is in metres per second. The server performs a calculation to convert the wind speed in metres per second to kilometres per hour.

##### **_Objective 3. Some reactive output displayed as a result of server calculations_**

The server reacts to the user input and updates the **Weather Details** tab with the selected date as well as calculates the minimum and maximum temperature in celcius and the minimum and maximum wind speed in kilometres per hour.  The wind speed supplied by the dataset is in metres per second. The server performs a **calculation** to convert the wind speed in metres per second to kilometres per hour.

The **Temperature Plot** and the **Wind Speed Plot** show the range of temperature and windspeed for the day selected by the user. These plots change and react to the date selected by the user.The server performs a **calculation** to convert the wind speed in metres per second to kilometres per hour.

##### **_Objective 4. You must also include enough documentation so that a novice user could use your application._**

Instructions to use the application are provided in the sidebar below the **Date Input** widget. This documentation is also provided in the **Help** tab.

##### **_Objective 5. The documentation should be at the Shiny website itself. Do not post to an external link._**

The user documentation on the sidebar is provided in the **ui.R** file. The documentation **Project Description** and the **Help** tab documentation are hosted as html files on the Shiny server.


#### **Project Files at Github**

A copy of the Project files is located on Github at [https://github.com/barrie0482/bne-cbd-weather](https://github.com/barrie0482/bne-cbd-weather)

##### Some important files
* [server.R](https://github.com/barrie0482/bne-cbd-weather/blob/master/server.R) - Processes the users request from ui.R.
* [ui.R](https://github.com/barrie0482/bne-cbd-weather/blob/master/ui.R) - Provides the User Interface for the application
* [global.R](https://github.com/barrie0482/bne-cbd-weather/blob/master/global.R) - Loads the data and provides global variables to both server.R and ui.R.
* [bne-cbd-air.R](https://github.com/barrie0482/bne-cbd-weather/blob/master/bne-cbd-air.R) - Processes the raw data and makes it ready for the application. This script is run once as part of the application development. The resultant file is loaded as data for the application.
