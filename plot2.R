## ----------
## Author:      Sternophant
## Date:        2015-08-04
## Description: Creates 2nd plot of Project 2 
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

## Create plot2.png
## ---------
curr_locale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME","en_US.UTF-8")    # to ensure English values on x-axis

png(file="plot2.png")
plot(input$Global_active_power ~ input$Date_and_Time,
     type = "l",
     main = "",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()

Sys.setlocale("LC_TIME",curr_locale)
rm(curr_locale)
## ---------