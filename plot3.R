#Exploratory Data Analysis - Week 1 peer reviewed assingment

#read only the february data from the large file

data<-read.table("household_power_consumption.txt",header=TRUE, sep = ";", dec = ".", nrows=69517)

head(data)
tail(data)
names(data)

#Dates, Times and missing values
for(i in 3:9){ #replace ? with NAs.
    data[,i]<-gsub(data[,i],pattern="[?]",replacement=NA)
}

data$Date<-as.Date(data$Date,format='%d/%m/%Y')
data$date_and_time = paste(data$Date,data$Time)

head(data)
tail(data)

data$date_and_time<-strptime(data$date_and_time,format="%Y-%m-%d %H:%M:%S")

#only the requested days
library(dplyr)
data_feb2<-filter(data,data$Date >= as.Date("2007-02-01 00:00:00") & data$Date <= as.Date("2007-02-02 23:59:00"))

head(data_feb2)
tail(data_feb2)

#plot 3

png(file="plot3.png", width=480, height=480)

par(mfcol=c(1,1),mar=c(5,5,3,2),oma=c(0,0,1,0))
with(data_feb2,plot(data_feb2$date_and_time,Sub_metering_1,
                    type="l",ylab="Energy sub metering",xlab=""))
lines(data_feb2$date_and_time,data_feb2$Sub_metering_2,col="red")
lines(data_feb2$date_and_time,data_feb2$Sub_metering_3,col="blue")
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()
