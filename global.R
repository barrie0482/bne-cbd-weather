# Load the dataset
mydata<- read.csv("data/bne-cbd-weather.csv", comment.char="#",sep = ",",stringsAsFactors = FALSE)
# Create global variables, able to be used in ui.R and server.R. 
# This enables both ui.R and server.R access to the variables on startup.
# The Date Input widget requires these first and last dates of the dataset 
# for initial configuration.
mindate = as.character(min(as.Date(mydata$Date, "%d/%m/%Y")))
maxdate = as.character(max(as.Date(mydata$Date, "%d/%m/%Y")))