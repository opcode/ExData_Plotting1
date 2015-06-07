rm(list=ls())
setwd("~/Personal/Coursera/ExploratoryDataAnalysis/Projects/project1")
getwd()

library(dplyr)
library(ggplot2)

# printf util
printf <- function(...) { cat(sprintf(...)) }

# wider lines if not interactive
if (!interactive()) {
    options("width" = 120)
}

# data file:
# Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
# 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000
# 16/12/2006;17:25:00;5.360;0.436;233.630;23.000;0.000;1.000;16.000
classes <- c(rep("character", 2), rep("numeric", 7))

# Read in data or two days: 2/1/2007 and 2/2/2007
# Data begin after 66,636 lines of data and each day has 24 * 60 observations
df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",
                 colClasses=classes, skip=66636, nrows=24*60*2, stringsAsFactors=FALSE)

# rename the columns
colnames(df) <- c("date", "time", "global_active_power", "global_reactive_power", "voltage", "global_intensity",
                  "sub_metering_1", "sub_metering_2", "sub_metering_3")

# convert first two columns a Date object
df$datetime <- strptime(paste(df$date, df$time), format="%e/%m/%Y %H:%M:%S")

# rename and rearrange the columns
df$date <- NULL
df$time <- NULL

# generate plot #1
png("plot1.png", width=480, height=480, units="px")
hist(df$global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()

