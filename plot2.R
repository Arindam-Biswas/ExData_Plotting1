##set working directory
setwd('D:/Data/Arindam.Biswas/My Documents')

##read power data text file
power <- read.table('household_power_consumption.txt', header=TRUE, sep=";", na.strings="?")

##format date column to date format
power$Date <- as.Date(power$Date, format="%d/%m/%Y")

##only use data from the dates 2007-02-01 and 2007-02-02
power <- power[power$Date >= as.Date("2007-02-01") & power$Date<=as.Date("2007-02-02"),]

##convert Global_active_power data to numeric class
power$Global_active_power <- as.numeric(as.character(power$Global_active_power))

##combine and transform Date and Time column to unified timestamp value
power <- transform(power, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

##define output file format and dimensions
png(filename="plot2.png", width=480, height=480, units="px")

##construct the plot
plot(power$timestamp,power$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()