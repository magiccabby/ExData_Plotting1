## plot2

# define file name and other information
filename <- "household_power_consumption.txt"
n <- 2075259
col_names <- c("Date", "Time","Global_active_power","Global_reactive_power",
               "Voltage","Global_intensity","Sub_metering_1",
               "Sub_metering_2","Sub_metering_3")
col_classes <- c("character", "character", "numeric", "numeric", "numeric", 
                 "numeric", "numeric", "numeric", "numeric")

# read data into memory
my_data <- read.table(filename, head = TRUE, sep = ";", col.names = col_names,
                      na.strings = "?", colClasses = col_classes, nrows = n)

# filter data
tmp <- as.Date(my_data$Date, "%d/%m/%Y")
ind <- tmp >= as.Date("2007-02-01") & tmp <= as.Date("2007-02-02")
my_data <- my_data[ind,]

# change formate for date and time
my_data$Date_Time <- paste(my_data$Date, my_data$Time, sep = ",")
my_data$Date_Time <- strptime(my_data$Date_Time, "%d/%m/%Y,%H:%M:%S")
my_data$Date <- NULL
my_data$Time <- NULL


# make plot
png("plot2.png", width = 480, height = 480)

with(my_data, plot(my_data$Date_Time, Global_active_power, type = "l", 
                   xlab = "", ylab = "Global Active Power(kilowatts)"))

dev.off()
