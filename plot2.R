#Set working directory

dataset <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                      colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
                      na.strings = "?")

dataset <- transform(dataset, DateTime = paste(dataset[,1], dataset[,2]))
dataset[,10] <- as.POSIXct(dataset[,10], format = "%d/%m/%Y %H:%M:%S")
dataset[,1] <- as.Date(dataset[,1], "%d/%m/%Y")

twodaysdata <- subset(dataset, dataset$Date == "2007-02-01"| dataset$Date == "2007-02-02")

png(filename = "plot2.png", width = 480, height = 480)
with(twodaysdata, plot(DateTime,Global_active_power, 
                       type = "l",
                       xlab = ""))

dev.off()

