#
#
# Load Libraries
library(shiny)
library(dplyr)
library(stringr)
library(ggplot2)
library(scales)

shinyServer(function(input, output) {
        # Create reactive temperature message
        output$tempOut <- renderText({
                # Get the input date in the right format
                indate <-format(as.character(as.Date(input$date), "%e/%m/%Y"))
                # Subset the data on the input date
                sdata <- filter(mydata, Date == str_trim(indate))
                # Get the minimum temperature for the day
                mintemp <- min(sdata$Air.Temperature)
                # Get the maximum temperature for the day
                maxtemp <- max(sdata$Air.Temperature)
                # Format the date to be displayed in the temperature message
                plotdate <- format(as.character(as.Date(input$date), "%A %e %B %Y"))
                # Create the temperature message
                tempOut <-
                        paste0(
                                "On ",
                                plotdate,
                                " the minimum temperature in the Brisbane Central Business District (CBD) was ",
                                mintemp,
                                " degrees Celcius. ",
                                "The maximum temperature was ",
                                maxtemp,
                                " degrees Celcius."
                        )
                # Display the temperature message
                tempOut
        })
        
        # Create reactive temperature plot
        output$tempPlot <- renderPlot({
                # Get the input date in the right format
                indate <- format(as.character(as.Date(input$date), "%e/%m/%Y"))
                # Format the date to be displayed in the temperature plot
                plotdate <- format(as.character(as.Date(input$date), "%A %e %B %Y"))
                # Subset the data on the input date
                sdata <- filter(mydata, Date == str_trim(indate))
                # Create a combined datetime field
                sdata$datetime <- strptime(paste(sdata$Date, sdata$Time), format = "%d/%m/%Y %H:%M")
                # Plot the temperature chart
                ggplot(sdata, aes(as.POSIXct(datetime), Air.Temperature,colour = "Temperature")) + geom_line() +
                        # Set up x and y axis scales
                        scale_x_datetime(
                                breaks = date_breaks("2 hours"),
                                labels = date_format("%H:%M", tz = "Australia/Brisbane"),
                                limits = c(min(as.POSIXct(sdata$datetime)
                                ), max(as.POSIXct(sdata$datetime)
                                ))
                        ) +
                        scale_y_continuous(breaks = seq(round(min(sdata$Air.Temperature)
                        ), round(max(sdata$Air.Temperature)
                        ), 1)) +
                        # Set up x and y axis label
                        xlab("Time") + ylab("Temperature(Celcius)") +
                        # Set up chart title
                        ggtitle(
                                paste(
                                        "Brisbane Central Business District, Queensland, Australia \n  Temperature Chart for",
                                        plotdate
                                )
                        ) +
                        # Set up axis theme
                        theme(
                                axis.title.x = element_text(
                                        face = "bold",
                                        colour = "#990000",
                                        size = 20
                                ),
                                axis.title.y = element_text(
                                        face = "bold",
                                        colour = "#990000",
                                        size = 20
                                ),
                                axis.text.x  = element_text(
                                        angle = 45,
                                        vjust = 0.5,
                                        size = 15
                                ),
                                axis.text.y  = element_text(size = 15),
                                plot.title  = element_text(size = 20)
                        ) +
                        # Create minimum and maximum wind speed lines
                        geom_hline(aes(
                                yintercept = min(sdata$Air.Temperature), 
                                colour = "Minimum")) +
                        geom_hline(aes(
                                yintercept = max(sdata$Air.Temperature), 
                                colour = "Maximum")) +
                        # Create legend
                        scale_colour_manual(
                                name = "Legend", 
                                values=c(Maximum="red", 
                                         Temperature="green", 
                                         Minimum="blue"))
                        
        })
        
        # Create reactive wind speed message
        output$windOut <- renderText({
                # Get the input date in the right format
                indate <- format(as.character(as.Date(input$date), "%e/%m/%Y"))
                # Subset the data on the input date
                sdata <- filter(mydata, Date == str_trim(indate))
                # Calculate the minimum Wind Speed for the day
                minwind <- (min(sdata$Wind.Speed) * 3.6)
                # Calculate the maximum Wind Speed for the day
                maxwind <- (max(sdata$Wind.Speed) * 3.6)
                # Format the date to be displayed in the wind speed message
                plotdate <- format(as.character(as.Date(input$date), "%A %e %B %Y"))
                # Create the wind speed message
                windOut <-
                        paste0(
                                "On ",
                                plotdate,
                                " the minimum wind speed in the Brisbane Central Business District (CBD) was ",
                                minwind,
                                " kilometres per hour(kph). ",
                                "The maximum wind speed was ",
                                maxwind,
                                " kilometres per hour (kph)."
                        )
                # Display the wind speed message
                windOut
        })
        
        # Create reactive wind speed plot
        output$windPlot <- renderPlot({
                # Get the input date in the right format
                indate <- format(as.character(as.Date(input$date), "%e/%m/%Y"))
                # Format the date to be displayed in the wind speed plot
                plotdate <- format(as.character(as.Date(input$date), "%A %e %B %Y"))
                # Subset the data on the input date
                sdata <- filter(mydata, Date == str_trim(indate))
                # Create a combined datetime field
                sdata$datetime <- strptime(paste(sdata$Date, sdata$Time), format = "%d/%m/%Y %H:%M")
                # Calculate wind speed in kilometres per hour
                sdata$Wind.Speed.kph <- sdata$Wind.Speed * 3.6
                # Plot the wind speed chart
                ggplot(sdata, aes(as.POSIXct(datetime), Wind.Speed.kph,color = "WindSpeed")) + 
                        geom_line() +
                        # Set up x and y axis scales
                        scale_x_datetime(
                                breaks = date_breaks("2 hours"),
                                labels = date_format("%H:%M", tz = "Australia/Brisbane"),
                                limits = c(min(as.POSIXct(sdata$datetime)
                                ), max(as.POSIXct(sdata$datetime)
                                ))
                        ) +
                        scale_y_continuous(breaks = seq(round(min(sdata$Wind.Speed.kph)
                        ), round(max(sdata$Wind.Speed.kph)
                        ), 1)) +
                        # Set up x and y axis label
                        xlab("Time") + ylab("Wind Speed(kph)") +
                        # Set up chart title
                        ggtitle(
                                paste(
                                        "Brisbane Central Business District, Queensland, Australia \n  Wind Speed Chart for",
                                        plotdate
                                )
                        ) +
                        # Set up axis theme
                        theme(
                                axis.title.x = element_text(
                                        face = "bold",
                                        colour = "#990000",
                                        size = 20
                                ),
                                axis.title.y = element_text(
                                        face = "bold",
                                        colour = "#990000",
                                        size = 20
                                ),
                                axis.text.x  = element_text(
                                        angle = 45,
                                        vjust = 0.5,
                                        size = 15
                                ),
                                axis.text.y  = element_text(size = 15),
                                plot.title  = element_text(size = 20)
                        ) +
                        # Create minimum and maximum wind speed lines
                        geom_hline(aes(
                                yintercept = min(sdata$Wind.Speed.kph), 
                                colour = "Minimum")) +
                        geom_hline(aes(
                                yintercept = max(sdata$Wind.Speed.kph), 
                                colour = "Maximum")) +
                        # Create legend
                        scale_colour_manual(
                                name = "Legend", 
                                values=c(Maximum="red", 
                                         WindSpeed="green", 
                                         Minimum="blue"))
        })
})
