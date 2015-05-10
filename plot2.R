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

##initialise plot
plot(powerdata$newdt,powerdata$Global_active_power,type="n",xlab="",ylab="Global Active Power (kilowatts)")

##draw the lines
lines(powerdata$newdt,powerdata$Global_active_power)

##copy to png
dev.copy(png,file="plot2.png")
dev.off()
