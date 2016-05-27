library(dplyr)
mydata<- read.csv("data/bne-cbd-weather.csv", comment.char="#",sep = ",",stringsAsFactors = FALSE)
# Define server logic required to draw a histogram
mindate = as.character(min(as.Date(mydata$Date, "%d/%m/%Y")))
maxdate = as.character(max(as.Date(mydata$Date, "%d/%m/%Y")))

degree2cartesian <- function(num){
  position <- as.integer((num/22.5)+.5) +1
  if(position > 16){position = 1}
  cartdir <- c("N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW")
  return(cartdir[position])
}