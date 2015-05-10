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

hist(powerdata$Global_active_power,
     main="Global Active Power",
     col="red",
     xlim=c(0,6),
     xlab="Global Active Power (kilowatts)",
     ylim=c(0,1200)
     )

##copy to png
dev.copy(png,file="plot1.png")
dev.off()