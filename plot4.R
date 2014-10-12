###############################IMPORTANT#######################################
#
# You need to download the data and unzip it first. Set your working directory
# to the folder where you downloaded the data. You can get the data here:
#
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# This code DOES NOT download and unzip the data needed, because it IS NOT PART
# OF THE ASSIGNMENT as you can read here in the original task:
#
# https://github.com/rdpeng/ExData_Plotting1/blob/master/README.md
#
# However, reading the data is part of the assignment and part of this code, 
# therefore you need to get the data first to make this code work.
#
###############################################################################

# Reading the data
data <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?",
                 colClasses = c("character", "character", "numeric", "numeric", 
                                "numeric", "numeric", "numeric", "numeric", 
                                "numeric"))
#converting the dates
data$DateTime = paste(data$Date, data$Time)
data$DateTime = as.POSIXlt(data$DateTime,format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y")

#subset the data to the Days 2007-02-01 and 2007-02-02
subdata <- data[data$Date %in% as.Date(c("2007-02-01", "2007-02-02"), format="%Y-%m-%d"),]

################################        
#Plot 4

#open a png device
png(file="plot4.png")

#create a 2x2 plot, row-wise
par(mfrow = c(2,2))

#adding the first plot
plot(subdata$DateTime,subdata$Global_active_power, type = "l", xlab = "", 
     ylab ="Global Active Power (kilowatts)")
par(mar=c(4,4,2,2))

#adding the second plot
plot(subdata$DateTime,subdata$Voltage, type = "l", xlab = "datetime", 
     ylab ="Voltage")
par(mar=c(4,4,2,2))

#adding the third plot
plot(subdata$DateTime,subdata$Sub_metering_1, xlab = "", 
     ylab ="Energy sub metering", type = "n")
lines(subdata$DateTime,subdata$Sub_metering_1)
lines(subdata$DateTime,subdata$Sub_metering_2, col = "red")
lines(subdata$DateTime,subdata$Sub_metering_3, col = "blue")
par(mar=c(4,4,2,2))

#adding the legend
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lwd=1, bty = "n", col=c("black","red","blue"))

#adding the fourth plot
plot(subdata$DateTime,subdata$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab ="Global_reactive_power")
par(mar=c(4,4,2,2))

#specify heigth and width
width= 480
height= 480

#close PNG device
dev.off()