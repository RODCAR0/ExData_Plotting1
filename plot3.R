library(dplyr)
library(lubridate)

## English by default
Sys.setlocale("LC_ALL", "English")

data <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, na.strings="?")

#Convert date column from chr to Date class
data[, c(1)] <- as.Date(data[, c(1)], format="%d/%m/%Y")

##Select only two days in February
february <- filter(data, Date == "2007-02-01" | Date == "2007-02-02")
## complete data frame not needed anymore
rm(data)

## Create new variable with date time
february <- mutate(february, Datetime=paste(as.character(Date), Time))
february[, c(10)] <- ymd_hms(february$Datetime)

##change graphics device to png
png("plot3.png", width=480, height=480, units="px")

## Plot metering 1
with(february, plot(Datetime,Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
## Add lines dor metering 2 and 3 variables
lines(february$Datetime, february$Sub_metering_2, type="l", col="red")
lines(february$Datetime, february$Sub_metering_3, type="l", col="blue")
## legend to see which metering variables correspond to which lines
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), pch=c(NA, NA,NA))

##close graphics device
dev.off()
