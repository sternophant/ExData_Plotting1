## ----------
## Author:      Sternophant
## Date:        2015-08-04
## Description: Creates 1st plot of Project 1 
## ----------

## Load input data
## ----------
input <- read.table("household_power_consumption.txt",
                    header     = T,
                    sep        = ";",
                    dec        = ".",
                    colClasses = "character",
                    nrow       = (100)*24*60)
## ----------

## Wrangle loaded data
## ---------
Date_and_Time <- as.POSIXct(paste(input[ ,1], " ", input[ , 2]), 
                            format = "%d/%m/%Y %H:%M:%S")
input <- cbind(Date_and_Time, input)


input[ , 2] <- as.Date(input[ ,2], format = "%d/%m/%Y")

period_start <- as.Date("2007-02-01", format = "%Y-%m-%d")
period_end   <- as.Date("2007-02-02", format = "%Y-%m-%d")
input        <- subset(input, Date >= period_start & Date <= period_end)

for(i in 4:10) {
  input[ , i] <- as.numeric(input[ , i])
}

rm(Date_and_Time)
rm(period_start)
rm(period_end)
rm(i)
## ----------

## Create plot1.png
## ---------
png(file="plot1.png")
  hist(input$Global_active_power,
       main = "Global Active Power",
       xlab = "Global Active Power (kilowatts)",
       ylab = "Frequency",
       col  = "red")
dev.off()
## ---------