setwd("C:/Prosenjit data/Cousera/Exploratory Graphs")
# Download the data
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "data.zip")
unzip("data.zip")

#creating tidy data set
h<-readLines("household_power_consumption.txt")[1]
e<-grep("2/2/2007",readLines("household_power_consumption.txt"))
d<-grep("1/2/2007",readLines("household_power_consumption.txt"))
c<-readLines("household_power_consumption.txt")[c(d,e)]
writeLines(c,"test.csv")
d<-read.csv("test.csv", header=F, sep=";")
writeLines(h,"he.csv")
hd<-read.csv("he.csv",header = F,sep = ";")
colnames(d)<-as.character(unlist(hd[1,]))
d<-d[!(d$Date=="11/2/2007"),]
d<-d[!(d$Date=="12/2/2007"),]
d<-d[!(d$Date=="21/2/2007"),]
d<-d[!(d$Date=="22/2/2007"),]
remove(hd)
remove(c,e,h)
d$Date<-as.Date(d$Date, format = "%d/%m/%Y")
d$datetime<-paste(d$Date,d$Time)
d$datetime<-strptime(d$datetime, "%Y-%m-%d %H:%M:%S")


# Creating Plot 4
png("plot4.png",width = 480,height = 480)
par(mfrow=c(2,2))
plot(d$datetime,d$Global_active_power,type="l",xlab = "",ylab = "Global Active Power (kilowatts)")
d$Voltage<-as.numeric(d$Voltage)
plot(d$datetime,d$Voltage,type="l",xlab = "datetime",ylab = "Voltage")

plot(d$datetime,d$Sub_metering_1,type="l",xlab="",ylab = "Energy sub metering")
lines(d$datetime,d$Sub_metering_2,col="red")
lines(d$datetime,d$Sub_metering_3,col="blue")
d$Global_reactive_power<-as.numeric(d$Global_reactive_power)
plot(d$datetime,d$Global_reactive_power,xlab="datetime",ylab = "Global_reactive_power",type = "l")
dev.off()
