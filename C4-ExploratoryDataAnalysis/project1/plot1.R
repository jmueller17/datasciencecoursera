

#prompt for the file 
filePath <- file.choose();

#read only the rows for the given dates 1/2/2007 and 2/2/2007
df <- read.csv(filePath, 
               sep=";", 
               skip=66636, 
               nrows=2880,
               col.names=colnames(read.csv(filePath, sep=";", header=T, nrow=1)))

#subset to selected dates
#df.sub <- subset(df, (Date=="1/2/2007" | Date == "2/2/2007") )

#convert level to numeric
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))

#plot the png histogram
png("plot1.png", width=480, height=480)
hist(df$Global_active_power, 
     main="Global Active Power", 
     col="red", 
     xlab="Global Active Power (kilowatts)")
dev.off()

