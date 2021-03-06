setwd("~/GitHub/ExData_Plotting1/")
## Download file, create folder if it does not exists then down load the file and unzip
if (!file.exists("data")) {
  dir.create("data")
}

setwd("~/GitHub/ExData_Plotting1/data")
if (!file.exists("household_power_consumption.txt")) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, destfile = "household_power_consumption.zip", method = "curl")
  unzip("household_power_consumption.zip")  
}

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

## Plot1
png("plot1.png", width = 480, height = 480)
hist(RawData.F$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (Kilowatts)")
dev.off()

## Remove data
rm(RawData.F)
