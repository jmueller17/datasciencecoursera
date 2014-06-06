library(zoo)


#prompt for the file 
filePath <- file.choose();

#read only the rows for the given dates 1/2/2007 and 2/2/2007
df <- read.csv(filePath, 
               sep=";", 
               skip=66636, 
               nrows=2880,
               col.names=colnames(read.csv(filePath, sep=";", header=T, nrow=1)))



#conversion stuff
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))

#combine Date and time columns into date time string
df$DateTime <- paste(as.character(df$Date), as.character(df$Time))

#conert to datetime object
df$DateTime <- strptime(df$DateTime, "%d/%m/%Y %H:%M:%S")


png("plot4.png", width=480, height=480)

#2x2 canvas
par(mfrow=c(2,2))

#Global active power
ts <- zoo(df$Global_active_power, df$DateTime)
plot(ts, type="l", ylab="Global Active Power (kilowatts)", xlab="")

#voltage
ts <- zoo(df$Voltage, df$DateTime)
plot(ts, type="l", ylab="Voltage", xlab="Datetime")

#submetering
ts <- zoo(df[,c(7,8,9)], df$DateTime)
plot(ts,  type="l", 
     col=c("black", "red", "blue"),
     ylab="Energy sub metering", 
     xlab="", 
     screens=1, 
     ylim=range(df[,c(7,8,9)]))

legend("topright", names(df[,c(7,8,9)]), lty=1, cex=.5, border=NULL, col=c("black", "red", "blue"))

#Global reactive power
ts <- zoo(df$Global_reactive_power, df$DateTime)
plot(ts, type="l", ylab="Global Reactive Power", xlab="Datetime")

dev.off()
