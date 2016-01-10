#
#	get_data()
#		Reads in the full datafile, extracts the relevant subset,
#		create a new datetime column, and caches the saved small dataset.
#
#	The function checks for the existance of the smaller dataset, and
#		uses that if it is available. Otherwise , it creates it.
#		So, the large dataset needs to only be processed once.
#
get_data <- function() {
	input_file <- "household_power_consumption.txt"
	small_file <- "power.csv"

	if (!file.exists(small_file)) {
		colclasses <- c("character", "character",
				"numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
		df <- read.csv(input_file, sep = ";",
				colClasses = colclasses, na.strings = "?")
		#	Extract relevant subset of the data
		smalldf <- subset(df, df$Date == "2/1/2007" | df$Date == "2/2/2007")
		#	Create datetime and add to the dataframe
		datetime <- paste(smalldf$Date, smalldf$Time, sep = " ")
		smalldf <- cbind(datetime, smalldf)
		#	Cache the new (and much smaller) dataframe
		write.csv(smalldf, small_file, row.names = FALSE)
	}
	smalldf <- read.csv(small_file)
	return(smalldf)
}


powerdf <- get_data()
powerdf$datetime <- strptime(powerdf$datetime, "%m/%d/%Y %H:%M:%S")


#	PLOT 4
#
png(filename = "plot4.png", width = 480, height = 480)

par(mfcol = c(2, 2))

with(powerdf, plot(Global_active_power,
				xlab = "", ylab = "Global Active Power (killowatts)",
				lty = 1, lwd = 1, type = "l", xaxt = "n"
				))
axis(side = 1, at = c(0, 1440, 2880), labels = c("Thur", "Fri", "Sat"))

#####

with(powerdf, plot(datetime, Sub_metering_3,
				xlab = "", ylab = "Energy sub metering",
				col = "blue", lty = 1, lwd = 1, type = "l",
				ylim = c(0, 35)
				))
with(powerdf, points(datetime, Sub_metering_1, col = "black", lty = 1, lwd = 1, type = "l"))
with(powerdf, points(datetime, Sub_metering_2, col = "red", lty = 1, lwd = 1, type = "l"))
legend("topright", lwd = 1, inset = .025, bty = "n",
		legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue")) 

#####

with(powerdf, plot(datetime, Voltage,
				xlab = "datetime", ylab = "Voltage",
				lty = 1, lwd = 1, type = "l",
				))

#####

with(powerdf, plot(datetime, Global_reactive_power,
				xlab = "datetime", ylab = "Global Reactive Power",
				lty = 1, lwd = 1, type = "l"
				))
dev.off()

