## Read the data from the dates 2007-02-01 and 2007-02-02.
## Dataset is ordered by the tuple (Date, Time)

filename <- "household_power_consumption.txt"

colnames <- unlist(strsplit(readLines(filename, n=1), split = ";"))
first_date <- "^1/2/2007;"
last_date <- "^2/2/2007;"

first_row <- head(grep(first_date, readLines(filename)), n=1)
last_row <- tail(grep(last_date, readLines(filename)), n=1)
nrws <- last_row - first_row

DT <- read.table(filename, header = TRUE, sep = ";", na.strings = "?", 
                 skip = first_row - 1, nrows = nrws, col.names=colnames)
date <- strptime(paste(DT$Date, DT$Time, sep= " "), format= "%d/%m/%Y %H:%M:%S")
weekday <- weekdays(date, abbreviate=TRUE)
DT <- cbind(date, weekday, DT)

## Print time series of Sub_metering

par(ps = 12, cex = 1)

description <- "Energy sub metering"
var = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
col = c("black","red","blue")

plot(DT$date, DT[, c(var[1])] , type = "l", col = col[1], xlab = NA, ylab = description)
lines(DT$date, DT[, c(var[2])] , col = col[2])
lines(DT$date, DT[, c(var[3])] , col = col[3])
legend("topright", lwd=rep(2.5, n= length(var)), col = col, legend = var, cex=0.7)
