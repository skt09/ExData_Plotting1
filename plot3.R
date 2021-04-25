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
household$dt <- dmy_hms(paste(household$Date, household$Time))
household$Time <- hms(household$Time)
household$Date <- dmy(household$Date)
household$Sub_metering_1 <- as.numeric(household$Sub_metering_1)
household$Sub_metering_2 <- as.numeric(household$Sub_metering_2)
household$Sub_metering_3 <- as.numeric(household$Sub_metering_3)
household <- subset(household, Date == "2007-02-01" | Date == "2007-02-02")

# Opening Graphics Device
png(filename = "plot3.png", width = 480, height = 480)

# Plotting the Plot
with(household, plot(dt, Sub_metering_1, type = "n", xlab = "",
                     ylab = "Energy sub metering"))
with(household, lines(dt, Sub_metering_1))
with(household, lines(dt, Sub_metering_2, col = "red"))
with(household, lines(dt, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Closing the Graphics Device
dev.off()


