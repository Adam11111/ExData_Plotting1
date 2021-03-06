###################################################################################################
#
# plot1.R - Histogram
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


# Create plot1.png file with Historgram
png("./plot1.png", width = 480, height = 480, bg = "transparent")
par(mfrow = c(1,1))
hist(powerCons$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power",
     col = "red"
)
dev.off()
