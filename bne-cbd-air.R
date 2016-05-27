library(dplyr)
#setwd("bne-airquality")
mydata<- read.csv("data/brisbanecbd-aq-2012.csv", comment.char="#",sep = ",",skip = 1,stringsAsFactors = FALSE)
# Date
# Time
# Wind Direction degTN - degrees from true north
# Wind Speed m/s - metres per second
# Wind Sigma Theta deg - degrees
# Wind Speed Std Dev m/s - metres per second
# Air Temperature degC - Degrees Celcius
# PM10 µg/m3 - micrograms per cubic metre
# Visibility-reducing particles - Mm-1 - Nano Metre

names(mydata) <- c("Date","Time","Wind.Direction","Wind.Speed","Wind.Sigma.Theta","Wind.Speed.Std.Dev",
                   "Air.Temperature","PM10","Visibility.reducing.particles")

mydata <- select(mydata,-Wind.Sigma.Theta,-Wind.Speed.Std.Dev,-PM10,-Visibility.reducing.particles)

summary(mydata)
mydata <- transform(mydata, Wind.Direction = ifelse(is.na(Wind.Direction), mean(Wind.Direction, na.rm=TRUE), Wind.Direction))
mydata <- transform(mydata, Wind.Speed = ifelse(is.na(Wind.Speed), mean(Wind.Speed, na.rm=TRUE), Wind.Speed))
mydata <- transform(mydata, Air.Temperature = ifelse(is.na(Air.Temperature), mean(Air.Temperature, na.rm=TRUE), Air.Temperature))
#mydata <- transform(mydata, PM10 = ifelse(is.na(PM10), mean(PM10, na.rm=TRUE), PM10))

write.csv(mydata,file = "data/bne-cbd-weather.csv",row.names = FALSE)

degree2cartesian <- function(num){
    position <- as.integer((num/22.5)+.5) +1
    if(position > 16){position = 1}
    cartdir <- c("N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW")
    return(cartdir[position])
}
mydata$Compass <- lapply(mydata$Wind.Direction,degree2cartesian)
mydata$Wind.Speed.kph <- mydata$Wind.Speed * 3.6
mydata$Wind.Speed.knots <- mydata$Wind.Speed * 1.9438

mydata <- select(mydata,Date,Time,Compass,Wind.Speed.kph,Air.Temperature)
write.csv(mydata,file = "data/bne-cbd-weather.csv",row.names = FALSE)
