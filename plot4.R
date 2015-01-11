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

## Print multiple time series graphs

par(ps = 8, cex = 1, mfrow = c(2,2), mar=c(4,4,2,1))

var_subm = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
col = c("black","red","blue")

with(DT, {
    plot(date, Global_active_power, type = "l", col = "black", xlab = NA, ylab = "Global Active Power")
    plot(date, Voltage,  type = "l", col = "black", xlab = "datetime", ylab = "Voltage")
    plot(date, DT[, c(var[1])] , type = "l", col = col[1], xlab = NA, ylab = "Energy sub metering")
    lines(date, DT[, c(var[2])] , col = col[2])
    lines(date, DT[, c(var[3])] , col = col[3])
    legend("topright", lwd=rep(2.5, n= length(var)), col = col, legend = var, bty = "n", cex=0.9)
    plot(date, Global_reactive_power, type = "l", col = "black", xlab = "datetime", ylab = "Global_reactive_power")
    })


