# Load Libraries
library(dplyr)
#
# Load original dataset downloaded from the Queensland Government Data site
# https://data.qld.gov.au/dataset/air-quality-monitoring-2012/resource/35aec14e-469c-4508-9b63-551100662959
# The code depends on the dataset(brisbanecbd-aq-2012.csv) being located in the data directory.
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
#
# Set names on the data
names(mydata) <- c("Date","Time","Wind.Direction","Wind.Speed","Wind.Sigma.Theta","Wind.Speed.Std.Dev",
                   "Air.Temperature","PM10","Visibility.reducing.particles")
# Remove columms that are not needed
mydata <- select(mydata,-Wind.Sigma.Theta,-Wind.Speed.Std.Dev,-PM10,-Visibility.reducing.particles,-Wind.Direction)
# Loop through Wind.Speed column. Test for a NA. If the value is NA, take average of previous value
# and next nine values. Replace the current value (NA) with the calculated mean. If the first value 
# of the column is NA, use the average of the next ten values to impute the missing value.
for(i in 1:nrow(mydata)){
        if(is.na(mydata$Wind.Speed[i])){
                if(i == 1){
                        tmp <- vector()
                        st <- i
                        fi <- i + 10
                        for(j in st:fi){tmp <- rbind(tmp,mydata$Wind.Speed[j])}
                        mydata$Wind.Speed[i] <- mean(tmp,na.rm = TRUE)
                }
                else{
                        tmp <- vector()
                        st <- i - 1
                        fi <- i + 9
                        for(j in st:fi){tmp <- rbind(tmp,mydata$Wind.Speed[j])}
                        mydata$Wind.Speed[i] <- mean(tmp,na.rm = TRUE)
                }
        }
}

# Loop through Wind.Speed column. Test for a NA. If the value is NA, take average of previous value
# and next nine values. Replace the current value (NA) with the calculated mean. If the first value 
# of the column is NA, use the average of the next ten values to impute the missing value.
for(i in 1:nrow(mydata)){
        if(is.na(mydata$Air.Temperature[i])){
                if(i == 1){
                        tmp <- vector()
                        st <- i
                        fi <- i + 10
                        for(j in st:fi){tmp <- rbind(tmp,mydata$Air.Temperature[j])}
                        mydata$Air.Temperature[i] <- mean(tmp,na.rm = TRUE,na.rm = TRUE)
                }
                else{
                        tmp <- vector()
                        st <- i - 1
                        fi <- i + 9
                        for(j in st:fi){tmp <- rbind(tmp,mydata$Air.Temperature[j])}
                        mydata$Air.Temperature[i] <- mean(tmp,na.rm = TRUE)
                }
        }
}
# Write data to csv file
write.csv(mydata,file = "data/bne-cbd-weather.csv",row.names = FALSE)
