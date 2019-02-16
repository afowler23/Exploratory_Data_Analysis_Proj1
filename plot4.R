# Purpose
# This assignment uses data from the UC Irvine Machine Learning Repository, 
# a popular repository for machine learning datasets. In particular, we will
# be using the “Individual household electric power consumption Data Set” 
# The overall goal is to examine how household energy usage varies over a 2-day period
# in February, 2007


# Loading required packages
library("data.table")

# Download the dataset
data <- read.table("household_power_consumption.txt",skip=1,sep=";")

# Get column names
names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
"Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")


# Subset the data to between dates 2007-02-01 and 2007-02-02
dataSub <- subset(data,data$Date=="1/2/2007" | data$Date =="2/2/2007")



# Transforming the Date and Time vars from char into obj 
dataSub $Date <- as.Date(dataSub $Date, format="%d/%m/%Y")
dataSub $Time <- strptime(dataSub $Time, format="%H:%M:%S")
dataSub [1:1440,"Time"] <- format(dataSub [1:1440,"Time"],"2007-02-01 %H:%M:%S")
dataSub [1441:2880,"Time"] <- format(dataSub [1441:2880,"Time"],"2007-02-02 %H:%M:%S")

# Initiating a composite plot with 4 graphs
par(mfrow=c(2,2))

# Plot 4
with(dataSub,{
  plot(dataSub$Time,as.numeric(as.character(dataSub$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(dataSub$Time,as.numeric(as.character(dataSub$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(dataSub$Time,dataSub$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(dataSub,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(dataSub,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(dataSub,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(dataSub$Time,as.numeric(as.character(dataSub$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})

# plot of PNG file with a width of 480 pixels and a height of 480 pixels
png("plot2.png", width=480, height=480)

