
## reading the data into data frame format

setwd("D:/Mislav/Data Science spec/4_ExploratoryDataAnalysis/ExData_Plotting1")
library(data.table)
data <- fread("household_power_consumption.txt", header=TRUE, sep=";", 
              na.strings='?', data.table=FALSE)


##extracting specific dates, converting date into POSIXlt and data into numeric

data <- data[data$"Date" %in% c("1/2/2007","2/2/2007"), ]
data["Date"] <- paste(data$"Date", data$"Time", sep=" ")
data <- data[,c(1,3,4,5,6,7,8,9)]
data$"Date" <- strptime(data$"Date", format="%d/%m/%Y %H:%M:%S")
data[,2:8]<-sapply(data[,2:8],as.numeric)


##plotting

png("plot3.png")
with(data, plot(Date, Sub_metering_1, type="l", xlab=NA,
                ylab="Energy sub metering"))
lines(x=data$Date, y=data$Sub_metering_2, col="red")
lines(x=data$Date, y=data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = 1, col=c("black", "red", "blue"), y.intersp=1)
dev.off()