##the data required is from lines 66638 to 69517 and is separated by semi-colons

##assign filepath of data
datafilepath<-"u:/household_power_consumption.txt"

##read only the applicable lines of data
powerdata<-read.table(datafilepath,header=FALSE,sep=";",na.strings="?",
                      skip=66637,nrows=2880,                      
                      col.names=c("Date",
                                  "Time",
                                  "Global_active_power",
                                  "Global_reactive_power",
                                  "Voltage",
                                  "Global_intensity",
                                  "Sub_metering_1",
                                  "Sub_metering_2",
                                  "Sub_metering_3"))

##create new datetime variable
powerdata$newdt<-strptime(paste(powerdata$Date,powerdata$Time),format="%d/%m/%Y %H:%M:%S")

##extract weekday
powerdata$wday<-weekdays(powerdata$newdt)

##get max reading to get the range right
maxread<-max(powerdata$Sub_metering_1)

par(mfcol=c(1,1),mar=c(4, 4, 2, 1))

png("plot3.png",width=800,height=800)
##initialise plots
with(powerdata,plot(newdt,Sub_metering_1,type="n",xlab="",ylim=c(0,maxread),ylab="Energy sub metering"))

##draw the lines
lines(powerdata$newdt,powerdata$Sub_metering_1,col="black")
lines(powerdata$newdt,powerdata$Sub_metering_2,col="red")
lines(powerdata$newdt,powerdata$Sub_metering_3,col="blue")

##add legend
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()