##set working directory
setwd('D:/Data/Arindam.Biswas/My Documents')

##read power data text file
power <- read.table('household_power_consumption.txt', header=TRUE, sep=";", na.strings="?")

##format date column to date format
power$Date <- as.Date(power$Date, format="%d/%m/%Y")

##only use data from the dates 2007-02-01 and 2007-02-02
power <- power[power$Date >= as.Date("2007-02-01") & power$Date<=as.Date("2007-02-02"),]

##convert Sub Metering 1, 2 and 3 columns to numeric class
power$Sub_metering_1 <- as.numeric(as.character(power$Sub_metering_1))
power$Sub_metering_2 <- as.numeric(as.character(power$Sub_metering_2))
power$Sub_metering_3 <- as.numeric(as.character(power$Sub_metering_3))

##combine and transform Date and Time column to unified timestamp value
power <- transform(power, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

##define output file format and dimensions
png(filename="plot3.png", width=480, height=480, units="px")

##construct the plot
plot(power$timestamp,power$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(power$timestamp,power$Sub_metering_2,col="red")
lines(power$timestamp,power$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
dev.off()