# Download the data zip file, and name it as rawData.zip.
if (!file.exists("EPC.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "EPC.zip")
}

# Unzip the rawData.zip file in the work directory. 
unzip("EPC.zip", "household_power_consumption.txt")

# Read the extracted txt file
rawData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)

# Select the data on the date of 2007-02-01 and 2007-02-02, Feburaray 1st and 2nd.
DateData <- rawData[(as.Date(rawData$Date,"%d/%m/%Y") == "2007-02-01") | (as.Date(rawData$Date,"%d/%m/%Y") == "2007-02-02"),]

# Remove rawData to free some space in memory
rm(rawData)

# Remove all the rows which contain NAs or the "?"
Data <- replace(DateData, as.character(DateData) == "?", NA)
Data <- na.omit(Data)
rm(DateData)  # For freeing some space in memory

# Calculate the datetime from Data$Date and Data$Time

datetime <- strptime(paste(Data$Date,Data$Time,sep = " "), format = "%d/%m/%Y %H:%M:%S")

# Set the PNG graphic device
png(filename = "plot3.png", width = 480, height = 480, units = "px")

# Plot the time series of all Sum_meterings
plot(datetime,Data$Sub_metering_1,type = "l", xlab = "datetime", ylab = "Energy submetering")
lines(datetime,Data$Sub_metering_2,col = "red")
lines(datetime,Data$Sub_metering_3,col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1), lwd = c(2,2,2), col = c("black", "red", "blue"), box.lwd = 0.5)


dev.off()

