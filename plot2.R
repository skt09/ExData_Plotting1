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
household <- subset(household, Date == "2007-02-01" | Date == "2007-02-02")

# Opening Graphics Device
png(filename = "plot2.png", width = 480, height = 480)

# Plotting the Plot
with(household, plot(dt, as.numeric(Global_active_power), type = "l", xlab = "",
                     ylab = "Global Active Power (killowatts)"))

# Closing the Graphics Device
dev.off()


