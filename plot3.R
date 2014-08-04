# Plot 3 - Line with annotations

# First, read the data
# We limit to the first 71,000 columns, as we are confident that the data is 
# going to be there (to avoid loading too much info) 

data <- read.table("household_power_consumption.txt",header=TRUE,nrows=71000, 
                   na.strings="?", sep = ";")


# And transform the Time and Date columns into an appropriate format

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")


data$Time <- strptime(paste(data$Date, data$Time, sep = " "), 
                      format= "%Y-%m-%d %H:%M:%S", tz = "")

# Now the subset we want
data <- data[data$Date <= as.Date("2007-02-02") ,]
data <- data[data$Date >= as.Date("2007-02-01") ,] 

# I here add a line to be sure that the days are going to be in English

Sys.setlocale(category = "LC_TIME", locale = "English_UK")

# And the line plot

par(mfrow = c(1,1))

plot(data$Time,data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "",  xaxt = "n")
lines(data$Time,data$Sub_metering_2, col="red")
lines(data$Time,data$Sub_metering_3, col="blue")
axis.POSIXct(1, x = data$Time, format = "%a")
legend("topright",lwd = 1,  col = c("black","red","blue"), cex = 0.9, 
       legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# We then export the plot to a png format

dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()