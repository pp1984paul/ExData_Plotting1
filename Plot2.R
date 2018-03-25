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


# Creating Plot 2
png("plot2.png",width = 480,height = 480)
plot(d$datetime,d$Global_active_power,type="l",xlab = "",ylab = "Global Active Power (kilowatts)")

dev.off()

