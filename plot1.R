library(lubridate)

options(warn = -1)

# Downloading the Dataset
filename <- "power_consumption.zip"

if (!file.exists(filename)) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile = filename, method = "curl")
}

if (!file.exists("household_power_consumption.txt")) {
  unzip(filename)
}

# Loading and Formatting the Dataset
household <- read.csv2("household_power_consumption.txt", sep = ";")
household$Time <- hms(household$Time)
household$Date <- dmy(household$Date)
household$Global_active_power <- as.numeric(household$Global_active_power)
household <- subset(household, Date == "2007-02-01" | Date == "2007-02-02")

# Opening Graphics Device
png(filename = "plot1.png", width = 480, height = 480)

# Plotting the plot
with(household, hist(Global_active_power, col = "red", main = "Global Active Power",
                     xlab = "Global Active Power (killowatts)"))

# Closing the device
dev.off()


