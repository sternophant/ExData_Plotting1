## ----------
## Author:      Sternophant
## Date:        2015-08-04
## Description: Creates 4th plot of Project 1
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

## Create plot4.png
## ---------
curr_locale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME","en_US.UTF-8")    # to ensure English values on x-axis


png(file="plot4.png")

  par(mfrow= c(2,2))
  
  ## 4.1
  plot(input$Global_active_power ~ input$Date_and_Time,
       type = "l",
       main = "",
       xlab = "",
       ylab = "Global Active Power (kilowatts)")
  
  
  ## 4.2
  plot(input$Voltage ~ input$Date_and_Time,
       type = "l",
       main = "",
       xlab = "datetime",
       ylab = "Voltage")

  ## 4.3 
  plot(input$Sub_metering_1 ~ input$Date_and_Time,
       type = "l",
       col  = c("black"),
       main = "",
       xlab = "",
       ylab = "Energy sub metering")
  
      lines(input$Sub_metering_2 ~ input$Date_and_Time, col ="red")
      lines(input$Sub_metering_3 ~ input$Date_and_Time, col ="blue")
      
      legend("topright", 
            c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
            lty = c(1, 1, 1),
            col = c("black", "red", "blue"),
            bty = "n")

  ## 4.4
  plot(input$Global_reactive_power ~ input$Date_and_Time,
       type = "l",
       main = "",
       xlab = "datetime",
       ylab = "Global_reactive_power")

dev.off()

Sys.setlocale("LC_TIME",curr_locale)
rm(curr_locale)
## ---------