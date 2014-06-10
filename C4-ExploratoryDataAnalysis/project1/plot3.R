#time series library
library(zoo)


#prompt for the file 
filePath <- file.choose();

#read only the rows for the given dates 1/2/2007 and 2/2/2007. 
#the nr. of rows to skip and read was read in a previous step. Avoids reading
#the whole data each time.
df <- read.csv(filePath, 
               sep=";", 
               skip=66636, 
               nrows=2880,
               col.names=colnames(read.csv(filePath, sep=";", header=T, nrow=1)))

#combine Date and time columns into date time string
df$DateTime <- paste(as.character(df$Date), as.character(df$Time))

#convert to datetime object
df$DateTime <- strptime(df$DateTime, "%d/%m/%Y %H:%M:%S")

#create time-series object
ts <- zoo(df[,c(7,8,9)], df$DateTime)

png("plot3.png", width=480, height=480)
plot(ts,  type="l", 
     col=c("black", "red", "blue"),
     ylab="Energy sub metering", 
     xlab="", 
     screens=1, 
     ylim=range(df[,c(7,8,9)]))

legend("topright", names(df[,c(7,8,9)]), lty=1, cex=.65, col=c("black", "red", "blue"))
dev.off()