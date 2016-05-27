#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram

# Define UI
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Brisbane CBD Weather 2012"),
  
  sidebarLayout(
    
    # Sidebar with a slider input
    sidebarPanel(
      dateInput("date", "Enter Date:",value = mindate, format = "yyyy-mm-dd",min = mindate,max = maxdate, width = '200px'),
      h5(helpText("This page displays weather information for the Brisbane Central Business District for 2012. The city of Brisbane is 
               the capital city of the state of Queensland in Australia." )),
      h5(helpText("To start, click on the text box above and select a date to display. 
                  The date is format used is yyyy-mm-dd")),
      h5(helpText("Note: Valid dates for this application are from the 1st January 2012 (2012-01-01) 
                  until the 31st December 2012 (2012-12-31). If dates outside this range or an invalid 
                  date is entered, an error will be displayed on the page. Refresh the page to start again.")),
      width = 3),
    
    # Show a plot of the generated distribution
    mainPanel(
      
      tabsetPanel(type = "pills", 
                  tabPanel("Weather Details", 
                           h4(textOutput("tempOut")),
                           h4(textOutput("windOut"))),
                                             
                  tabPanel("Temperature Plot", plotOutput("tempPlot"),value = "tempPlot"), 
                  tabPanel("Wind Speed Plot", plotOutput("windPlot"),value = "windPlot"),
                  tabPanel("Help", includeHTML("help.html")),
                  tabPanel("Project Description", includeHTML("project-description.html"))
                  
      )
    )
  )
))









