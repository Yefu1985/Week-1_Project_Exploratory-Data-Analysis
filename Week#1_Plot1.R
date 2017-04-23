# Download the data zip file, and name it as rawData.zip.
if (!file.exists("EPC.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "EPC.zip")
}

# Unzip the rawData.zip file in the work directory. 
unzip("EPC.zip", "household_power_consumption.txt")

# Read the extracted txt file
rawData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)

# Select the data on the date of 2007-02-01 and 2007-02-02, Feburaray 1st and 2nd.
rawData$Date <- as.Date(rawData$Date, "%d/%m/%Y")
DateData <- rawData[(rawData$Date == "2007-02-01") | (rawData$Date == "2007-02-02"),]

# Remove rawData to free some space in memory
rm(rawData)

# Remove all the rows which contain NAs or the "?"
Data <- replace(DateData, as.character(DateData) == "?", NA)
Data <- na.omit(Data)
rm(DateData)  # For freeing some space in memory


# Set the PNG graphic device
png(filename = "plot1.png", width = 480, height = 480, units = "px")

# Plot the histogram of "Global Active Power"
hist(as.numeric(Data$Global_active_power), col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")

dev.off()
