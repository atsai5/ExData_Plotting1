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

# convert Sub Metering data from factor to numeric class
sub$Sub_metering_1 <- as.numeric(as.character(sub$Sub_metering_1))
sub$Sub_metering_2 <- as.numeric(as.character(sub$Sub_metering_2))
sub$Sub_metering_3 <- as.numeric(as.character(sub$Sub_metering_3))

# open PNG graphic device, set width/height, generate frame, add 3 lines of different colors, add legend, close graphic device
png("plot3.png", width = 480, height = 480)
with(sub, plot(datetime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(sub, lines(datetime, Sub_metering_1, col = "black"))
with(sub, lines(datetime, Sub_metering_2, col = "red"))
with(sub, lines(datetime, Sub_metering_3, col ="blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), lty = 1)
dev.off()
