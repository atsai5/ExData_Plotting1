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
data$Date <- strptime(data$Date, format = "%d/%m/%Y")
sub <- data[data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"),]

# convert Global_active_power from factor to numeric class
sub$Global_active_power <- as.numeric(as.character(sub$Global_active_power))

# open PNG graphic device, set width/height, generate histogram, close graphic device
png("plot1.png", width = 480, height = 480)
hist(sub$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()
