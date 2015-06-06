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
# Create Plot 1
###############################################################################

png(filename = "plot1.png",
    width = 480,
    height = 480,
    units = "px")

hist(x$Global_active_power,
     col="red", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency",
     main = "Global Active Power")

dev.off()
