# Load the libraries
library(shiny)

# Define UI
shinyUI(fluidPage(style = "background-color: #fff2e6",
  # Application title
  titlePanel("Brisbane CBD Weather 2012"),
 # Create the sidebar layour 
  sidebarLayout(
    # Sidebar with a Date input
    sidebarPanel(
     # Create the Date input widget    
      dateInput("date", "Enter Date:",value = mindate, format = "yyyy-mm-dd",min = mindate,max = maxdate, width = '200px'),
      # Create Help text
      p(helpText("To start, click on the text box above and select a date to display. 
                  The date is format used is yyyy-mm-dd. ")),
      p(helpText("Select a tab to display the information you need.")),
      p(helpText("Weather Details: This tab displays the minimum and maximum Temperature and Windspeed 
                 for the selected date.")),
      p(helpText("Temperature Plot: This tab displays a plot of the temperature in for the selected date. The maximum temperature
                 is marked with a red line and minimum temperature with a blue line.")),
      p(helpText("Wind Speed Plot: This tab displays a plot of the wind speed for the selected date. The maximum speed
                 is marked with a red line and minimum speed with a blue line.")),
      p(helpText("Note: Valid dates for this application are from the 1st January 2012 (2012-01-01) 
                  until the 31st December 2012 (2012-12-31). If dates outside this range or an invalid 
                  date is entered, an error will be displayed on the page. Refresh the page to start again.")),
      width = 4),
    
    # Create a pills tabset panel
    mainPanel(
      tabsetPanel(type = "pills",
                  # Create Tab Panels
                  tabPanel("Weather Details", 
                           br(),
                           p("This page displays weather information for the Brisbane Central Business District for 2012. The city of Brisbane is 
                              the capital city of the state of Queensland in Australia." ),
                           h4("Temperature",style = "color:green"),
                           p(textOutput("tempOut")),
                           h4("Windspeed",style = "color:green"),
                           p(textOutput("windOut"))),
                                             
                  tabPanel("Temperature Plot", plotOutput("tempPlot"),value = "tempPlot"), 
                  tabPanel("Wind Speed Plot", plotOutput("windPlot"),value = "windPlot"),
                  tabPanel("Help", includeHTML("help.html")),
                  tabPanel("Project Description", includeHTML("project-description.html"))
                  
      )
    )
  )
))









