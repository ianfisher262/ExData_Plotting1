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

png("plot4.png")

par(mfcol=c(2,2),mar=c(4, 4, 2, 1))

with(powerdata, {
##first plot
  ##initialise plot
  plot(newdt,Global_active_power,type="n",xlab="",ylab="Global Active Power (kilowatts)")
  
  ##draw the lines
  lines(newdt,Global_active_power)})

##second plot
with(powerdata, {  
  ##initialise plots
  plot(newdt,Sub_metering_1,type="n",xlab="",ylim=c(0,maxread),ylab="Energy sub metering")

  
  ##draw the lines
  lines(newdt,Sub_metering_1,col="black")
  lines(newdt,Sub_metering_2,col="red")
  lines(newdt,Sub_metering_3,col="blue")
  
  ##add legend
  legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))})

##third plot
with(powerdata, { 
  ##initialise plots
  plot(newdt,Voltage,type="n",xlab="datetime",ylab="Voltage")

  ##draw the lines
  lines(newdt,Voltage,col="black")})

##fourth plot
with(powerdata, { 
  ##initialise plots
  plot(newdt,Global_reactive_power,type="n",xlab="datetime",ylab="Global_reactive_power")
  
  ##draw the lines
  lines(newdt,Global_reactive_power,col="black")
}
)

dev.off()