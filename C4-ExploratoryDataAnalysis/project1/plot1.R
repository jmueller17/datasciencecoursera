

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

#plot the png histogram
png("plot1.png", width=480, height=480)
hist(df$Global_active_power, 
     main="Global Active Power", 
     col="red", 
     xlab="Global Active Power (kilowatts)")
dev.off()

