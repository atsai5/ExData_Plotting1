# save data URL
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# set working directory
setwd("~./MyProject/4 Exploratory Data Analysis/Project1")

# check to see if the directory exists - if not then download the zip file and extract to the working directory
if(!file.exists("household_power_consumption.txt")) {
    download.file(URL, "raw.zip")
    unzip("raw.zip")
}

# read in data table
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# manipulate date to filter out rows only associated with 2007-02-01 and 2007-02-02
data$datetime <- strptime(with(data, paste(Date, Time)), format = "%d/%m/%Y %H:%M:%S")
data$Date <- strptime(data$Date, format = "%d/%m/%Y")
sub <- data[data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"),]

# convert all data from factor to numeric class
sub$Global_active_power <- as.numeric(as.character(sub$Global_active_power))
sub$Global_reactive_power <- as.numeric(as.character(sub$Global_reactive_power))
sub$Voltage <- as.numeric(as.character(sub$Voltage))
sub$Sub_metering_1 <- as.numeric(as.character(sub$Sub_metering_1))
sub$Sub_metering_2 <- as.numeric(as.character(sub$Sub_metering_2))
sub$Sub_metering_3 <- as.numeric(as.character(sub$Sub_metering_3))

# open PNG graphic device, set width/height, generate four panel format
png("plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))

# generate top left plot
with(sub, plot(datetime, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)"))
with(sub, lines(datetime, Global_active_power))

# generate bottom left plot
with(sub, plot(datetime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(sub, lines(datetime, Sub_metering_1, col = "black"))
with(sub, lines(datetime, Sub_metering_2, col = "red"))
with(sub, lines(datetime, Sub_metering_3, col ="blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), lty = 1, bty = "n")

# generate top right plot
with(sub, plot(datetime, Voltage, xlab = "datetime", ylab = "Voltage", type = "n"))
with(sub, lines(datetime, Voltage))

# generate bottom right plot
with(sub, plot(datetime, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "n"))
with(sub, lines(datetime, Global_reactive_power))

# close graphic device
dev.off()