setwd("~/GitHub/ExData_Plotting1")

library("dplyr")
## Load "Household Power Consumption" data
## Filter records for the two dates 2007-02-01 & 2007-02-02
## Remove the raw file to release the memory
RawData <- tbl_df(read.table(file = "./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "NA"))
RawData$DateFormatted <- as.Date(RawData$Date, "%d/%m/%Y")
RawData.F <- filter(RawData, DateFormatted == as.Date("2007-02-01", "%Y-%m-%d") | DateFormatted == as.Date("2007-02-02", "%Y-%m-%d"))
rm(RawData)

RawData.F$DateTime <- strptime(paste(as.character(RawData.F$Date), as.character(RawData.F$Time)), "%d/%m/%Y %H:%M:%S")
RawData.F$Global_active_power <- as.numeric(as.character(RawData.F$Global_active_power))
RawData.F$Global_reactive_power <- as.numeric(as.character(RawData.F$Global_reactive_power))
RawData.F$Voltage <- as.numeric(as.character(RawData.F$Voltage))
RawData.F$Global_intensity<- as.numeric(as.character(RawData.F$Global_intensity))
RawData.F$Sub_metering_1 <- as.numeric(as.character(RawData.F$Sub_metering_1))
RawData.F$Sub_metering_2 <- as.numeric(as.character(RawData.F$Sub_metering_2))

## Plot3
png("plot3.png", width = 480, height = 480)
plot(RawData.F$DateTime, RawData.F$Sub_metering_1, "l", xlab = "Weekday", ylab = "Energy Sub Metering", col = "black")
lines(RawData.F$DateTime, RawData.F$Sub_metering_2, col = "red")
lines(RawData.F$DateTime, RawData.F$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, lty=c(1,1,1), pch = c(NA, NA, NA), col = c("black", "red", "blue"))
dev.off()

## Remove data
rm(RawData.F)
