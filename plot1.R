library(dplyr)
data <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, na.strings="?")

#Convert date column from chr to Date class
data[, c(1)] <- as.Date(data[, c(1)], format="%d/%m/%Y")

##Select only two days in February
february <- filter(data, Date == "2007-02-01" | Date == "2007-02-02")

## complete data frame not needed anymore
rm(data)

##change graphics device to png
png("plot1.png", width=480, height=480, units="px")

##Histogram for column Global_active_power
hist(february$Global_active_power, main="Global Active Power", xlab="Global Active Power (Kilowatts)", col="red")
##Close device graphic
dev.off()
