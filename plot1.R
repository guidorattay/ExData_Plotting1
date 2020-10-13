#Exploratory Data Analysis - Week 1 peer reviewed assingment

#read only the february data from the large file

data<-read.table("household_power_consumption.txt",header=TRUE, sep = ";", dec = ".", nrows=69517)

#Dates, Times and missing values
for(i in 3:9){ #replace ? with NAs.
    data[,i]<-gsub(data[,i],pattern="[?]",replacement=NA)
}

data$Date<-as.Date(data$Date,format='%d/%m/%Y')
data$date_and_time = paste(data$Date,data$Time)

data$date_and_time<-strptime(data$date_and_time,format="%Y-%m-%d %H:%M:%S")

#only the requested days
library(dplyr)
data_feb2<-filter(data,data$Date >= as.Date("2007-02-01 00:00:00") & data$Date <= as.Date("2007-02-02 23:59:00"))

#plot 1

data_feb2$Global_active_power<-as.numeric(data_feb2$Global_active_power)

png(file="plot1.png", width=480, height=480)

par(mfcol=c(1,1),mar=c(5,4,3,2),oma=c(0,0,1,0))
hist(data_feb2$Global_active_power,col="red",
     xlab="Global Active Power (kilowatts)",main="Global Active Power",yaxt="n")
axis(2, at=seq(0,1200,200), labels=seq(0,1200,200))

dev.off()