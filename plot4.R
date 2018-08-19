#Set working directory

dataset <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                      colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
                      na.strings = "?")

dataset <- transform(dataset, DateTime = paste(dataset[,1], dataset[,2]))
dataset[,10] <- as.POSIXct(dataset[,10], format = "%d/%m/%Y %H:%M:%S")
dataset[,1] <- as.Date(dataset[,1], "%d/%m/%Y")

twodaysdata <- subset(dataset, dataset$Date == "2007-02-01"| dataset$Date == "2007-02-02")

png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

with(twodaysdata, plot(DateTime,Global_active_power, 
                       type = "l",
                       xlab = ""))

with(twodaysdata, plot(DateTime,Voltage, 
                       type = "l"))

with(twodaysdata, plot(DateTime,Sub_metering_1,
                       type = "n",
                       xlab = "",
                       ylab = "Energy sub metering"))

lines(twodaysdata$DateTime,twodaysdata$Sub_metering_1,
      col = "black")
lines(twodaysdata$DateTime,twodaysdata$Sub_metering_2,
      col = "red")
lines(twodaysdata$DateTime,twodaysdata$Sub_metering_3,
      col = "blue")
labels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
cols <- c("black", "red", "blue")
legend("topright", legend = labels, lty = 1, box.lty = 0,
       col = cols, bg = "transparent")


with(twodaysdata, plot(DateTime,Global_reactive_power, 
                       type = "l",
                       ylim = c(0,0.5)))

dev.off()
