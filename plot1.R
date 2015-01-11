# Read the data from the dates 2007-02-01 and 2007-02-02.
# Dataset is ordered by the tuple (Date, Time)

filename <- "household_power_consumption.txt"

colnames <- unlist(strsplit(readLines(filename, n=1), split = ";"))
first_date <- "^1/2/2007;"
last_date <- "^2/2/2007;"

first_row <- head(grep(first_date, readLines(filename)), n=1)
last_row <- tail(grep(last_date, readLines(filename)), n=1)
nrws <- last_row - first_row + 1
    
DT <- read.table(filename, header = TRUE, sep = ";", na.strings = "?", 
                 skip = first_row, nrows = nrws, col.names=colnames)

date <- strptime(paste(DT$Date, DT$Time, sep= " "), format= "%d/%m/%Y %H:%M:%S")
DT <- cbind(date, DT)

# Print histogram of Global_active_power

par(ps = 12, cex = 1)

description <- "Global Active Power"
units <- "kilowatts"

with(DT, hist(Global_active_power, col="red", main=description, xlab= paste(description, "(",units,")", sep="")))



