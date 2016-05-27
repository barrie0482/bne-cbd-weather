#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(stringr)
library(ggplot2)
library(scales)

shinyServer(
  function(input, output) {
    
    # output$textOut <- renderText({
    #         indate <- format(as.character(as.Date(input$date), "%e/%m/%Y"))
    #         sdata <- filter(mydata,Date == str_trim(indate))
    #         mintemp <- min(sdata$Air.Temperature)
    #         maxtemp <- max(sdata$Air.Temperature)
    #         minwind <- (min(sdata$Wind.Speed)*3.6)
    #         maxwind <- (max(sdata$Wind.Speed)*3.6)
    #         plotdate <- format(as.character(as.Date(input$date), "%A %e %B %Y"))
    #         textOut <- paste0("On ",plotdate," the minimum temperature in the Brisbane Central Business District (CBD) was ",
    #                         mintemp," degrees Celcius. ","The maximum temperature was ",maxtemp," degrees Celcius.")
    #         textOut <- paste0(textOut,"\n The minimum wind speed in the Brisbane Central Business District (CBD) was ",
    #                                  minwind," kilometres per hour(kph). ","The maximum wind speed was ",maxwind," kilometres per hour (kph).")
    #         textOut
    # })

    
    output$tempOut <- renderText({
      indate <- format(as.character(as.Date(input$date), "%e/%m/%Y"))
      sdata <- filter(mydata,Date == str_trim(indate))
      mintemp <- min(sdata$Air.Temperature)
      maxtemp <- max(sdata$Air.Temperature)
      plotdate <- format(as.character(as.Date(input$date), "%A %e %B %Y"))
      tempOut <- paste0("On ",plotdate," the minimum temperature in the Brisbane Central Business District (CBD) was ",
                        mintemp," degrees Celcius. ","The maximum temperature was ",maxtemp," degrees Celcius.")
      
      tempOut
    })    
    
    output$tempPlot <- renderPlot({
      
      # inputDate <- "2012-12-25"
      indate <- format(as.character(as.Date(input$date), "%e/%m/%Y"))
      plotdate <- format(as.character(as.Date(input$date), "%A %e %B %Y"))
      sdata <- filter(mydata,Date == str_trim(indate))
      sdata$datetime <- strptime(paste(sdata$Date,sdata$Time), format = "%d/%m/%Y %H:%M")
      ggplot(sdata, aes(as.POSIXct(datetime), Air.Temperature)) + geom_line(color="green")+
        scale_x_datetime(breaks = date_breaks("2 hours"),labels = date_format("%H:%M",tz = "Australia/Brisbane"),
                         limits = c(min(as.POSIXct(sdata$datetime)),max(as.POSIXct(sdata$datetime)))) +
        scale_y_continuous(breaks=seq(round(min(sdata$Air.Temperature)),round(max(sdata$Air.Temperature)),1)) +
        xlab("Time") + ylab("Temperature(Celcius)") + 
        ggtitle(paste("Brisbane Central Business District, Queensland, Australia \n  Temperature Chart for",plotdate)) + 
        theme(axis.title.x = element_text(face="bold",colour="#990000", size=20),
              axis.title.y = element_text(face="bold",colour="#990000", size=20),
              axis.text.x  = element_text(angle=45, vjust=0.5, size=15),
              axis.text.y  = element_text(size=15),
              plot.title  = element_text(size=20)) +
        geom_line(aes(x=,y=min(sdata$Air.Temperature)), color="blue") +
        geom_line(aes(x=,y=max(sdata$Air.Temperature)), color="red")
    })
    
    
    output$windOut <- renderText({
      indate <- format(as.character(as.Date(input$date), "%e/%m/%Y"))
      sdata <- filter(mydata,Date == str_trim(indate))
      minwind <- (min(sdata$Wind.Speed)*3.6)
      maxwind <- (max(sdata$Wind.Speed)*3.6)
      plotdate <- format(as.character(as.Date(input$date), "%A %e %B %Y"))
      windOut <- paste0("The minimum wind speed in the Brisbane Central Business District (CBD) was ",
                            minwind," kilometres per hour(kph). ","The maximum wind speed was ",maxwind," kilometres per hour (kph).")
      windOut
    })
    
    
    output$windPlot <- renderPlot({

      # inputDate <- "2012-12-25"
      indate <- format(as.character(as.Date(input$date), "%e/%m/%Y"))
      plotdate <- format(as.character(as.Date(input$date), "%A %e %B %Y"))
      sdata <- filter(mydata,Date == str_trim(indate))
      sdata$datetime <- strptime(paste(sdata$Date,sdata$Time), format = "%d/%m/%Y %H:%M")
      sdata$Wind.Speed.kph <- sdata$Wind.Speed * 3.6
      ggplot(sdata, aes(as.POSIXct(datetime), Wind.Speed.kph)) + geom_line(color="green")+
        scale_x_datetime(breaks = date_breaks("2 hours"),labels = date_format("%H:%M",tz = "Australia/Brisbane"),
                         limits = c(min(as.POSIXct(sdata$datetime)),max(as.POSIXct(sdata$datetime)))) +
        scale_y_continuous(breaks=seq(round(min(sdata$Wind.Speed.kph)),round(max(sdata$Wind.Speed.kph)),1)) +
        xlab("Time") + ylab("Wind Speed(kph)") +
        ggtitle(paste("Brisbane Central Business District, Queensland, Australia \n  Wind Speed Chart for",plotdate)) +
        theme(axis.title.x = element_text(face="bold",colour="#990000", size=20),
              axis.title.y = element_text(face="bold",colour="#990000", size=20),
              axis.text.x  = element_text(angle=45, vjust=0.5, size=15),
              axis.text.y  = element_text(size=15),
              plot.title  = element_text(size=20)) +
        geom_line(aes(x=,y=min(sdata$Wind.Speed.kph)), color="blue") +
        geom_line(aes(x=,y=max(sdata$Wind.Speed.kph)), color="red")

    })
  }
)
