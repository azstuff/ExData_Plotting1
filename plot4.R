###############################################################################
# Load and prepare source data for plotting
###############################################################################

# Load data from file
x <- read.table(file = "household_power_consumption.txt",
                header = TRUE, 
                sep = ";",
                nrows = 2075259,
                colClasses = c("character", "character", rep("numeric", 7)),
                na.strings = "?")
# Subset for 2007-02-01 and 2007-02-02
x <- x[x$Date == "1/2/2007" | x$Date == "2/2/2007",]

# Convert date to YYYY-MM-DD format
x$Date <- as.Date(x$Date, "%d/%m/%Y")
# Create combined Date and Time columns
x$DateTime <- paste(x$Date, x$Time)
# Convert Date/Time column to POSIXlt 
x$DateTime <- strptime(x$DateTime, "%Y-%m-%d %H:%M:%S")


###############################################################################
# Create Plot 4
###############################################################################

png(filename = "plot4.png",
    width = 480,
    height = 480,
    units = "px")

par(mfrow = c(2,2))

with(x, {
     
     #--------#
     # Plot 1 #
     #--------#
     
     plot(DateTime,
          Global_active_power,
          type = "l",
          xlab = "",
          ylab = "Global Active Power (kilowatts)")
     
     #--------#
     # Plot 2 #
     #--------#
     
     plot(DateTime,
          Voltage,
          type = "l",
          xlab = "datetime",
          ylab = "Voltage")
     
     #--------#
     # Plot 3 #
     #--------#
     
     plot(DateTime,
          Sub_metering_1,
          type = "n",
          xlab = "",
          ylab = "Energy sub metering")
     
     lines(DateTime,
           Sub_metering_1, 
           col = "black")
     
     lines(DateTime,
           Sub_metering_2, 
           col = "red")
     
     lines(DateTime,
           Sub_metering_3, 
           col = "blue")
     
     legend("topright",
            lty = c(1,1),
            lwd = c(2.5, 2.5),
            col = c("black", "red", "blue"),
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

     #--------#
     # Plot 4 #
     #--------#
     
     plot(DateTime,
          Global_reactive_power,
          type = "l",
          xlab = "datetime",
          ylab = "Global_reactive_power")

})

dev.off()
