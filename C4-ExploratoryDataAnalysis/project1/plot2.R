library(zoo)


#prompt for the file 
filePath <- file.choose();

#read only the rows for the given dates 1/2/2007 and 2/2/2007
df <- read.csv(filePath, 
               sep=";", 
               skip=66636, 
               nrows=2880,
               col.names=colnames(read.csv(filePath, sep=";", header=T, nrow=1)))

#convert to numeric
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))

#combine Date and time columns into date time string
df$DateTime <- paste(as.character(df$Date), as.character(df$Time))

#convert to datetime object
df$DateTime <- strptime(df$DateTime, "%d/%m/%Y %H:%M:%S")

#create time-series object
ts <- zoo(df$Global_active_power, df$DateTime)


png("plot2.png", width=480, height=480)
plot(ts, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()
