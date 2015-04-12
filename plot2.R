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
png("plot2.png", width=480, height=480, units="px")

## Plot type line
with(february, plot(Datetime,Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

##Close device graphic
dev.off()

