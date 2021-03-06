###################################################################################################
#
# plot4.R - 4 Panel Plot
# Exploratory Data Analysis
# Week 1 Project
#
# This program produces a plot from data in the Electric Power Consumption dataset
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# Copy the file "household_power_consumption.txt" into your working directory and run the script
# below if you would like to reproduce the plots. It is assumed your OS has already unzipped the
# file (mine did).
#
###################################################################################################


# Install necessary packages
install.packages("data.table")
library(data.table)


# Read in file
filePath <- "./household_power_consumption.txt"
powerConsNames <- fread(filePath, nrows = 1)
powerCons <- fread(filePath, nrows = 2880, na.strings = "?", skip = "1/2/2007")
colnames(powerCons) <- colnames(powerConsNames)
powerCons <- as.data.frame(powerCons)


# Format dates and times
datetime <- paste(powerCons$Date, powerCons$Time)
datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")
powerCons <- cbind(powerCons, datetime)


# Create plot4.png file with 4 Panel Plot
png("./plot4.png", width = 480, height = 480, bg = "transparent")
par(mfcol = c(2,2))
with(powerCons,{
    plot(datetime,
         Global_active_power,
         type = "n",
         xlab = "",
         ylab = "Global Active Power"
    )
    lines(datetime, Global_active_power)
    
    plot(datetime,
         Sub_metering_1,
         type = "n",
         xlab = "",
         ylab = "Energy sub metering"
    )
    lines(datetime, Sub_metering_1, col = "black")
    lines(datetime, Sub_metering_2, col = "red")
    lines(datetime, Sub_metering_3, col = "blue")
    legend("topright",
           legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           col = c("black","red","blue"),
           lwd = 1,
           bty="n"
    )
    
    plot(datetime, Voltage, type = "n")
    lines(datetime, Voltage)
    
    plot(datetime, Global_reactive_power, type = "n")
    lines(datetime, Global_reactive_power)
})
dev.off()
