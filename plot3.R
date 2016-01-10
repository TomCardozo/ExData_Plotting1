get_data <- function() {
	input_file <- "household_power_consumption.txt"
	small_file <- "power.csv"

	if (!file.exists(small_file)) {
		colclasses <- c("character", "character",
				"numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
		df <- read.csv(input_file, sep = ";",
				colClasses = colclasses, na.strings = "?")
		smalldf <- subset(df, df$Date == "2/1/2007" | df$Date == "2/2/2007")
		write.csv(smalldf, small_file, row.names = FALSE)
	}
	smalldf <- read.csv(small_file)
	return(smalldf)
}


powerdf <- get_data()

#	PLOT 3
#
png(filename = "plot3.png", width = 480, height = 480)

with(powerdf, plot(Sub_metering_3,
				xlab = "", ylab = "Energy sub metering",
				col = "blue", lty = 1, lwd = 1, type = "l",
				xaxt = "n", ylim = c(0, 25)
				))
with(powerdf, points(Sub_metering_1, col = "black", lty = 1, lwd = 1, type = "l"))
with(powerdf, points(Sub_metering_2, col = "red", lty = 1, lwd = 1, type = "l"))
axis(side = 1, at = c(0, 1440, 2880), labels = c("Thur", "Fri", "Sat"))
legend("topright", lwd = 1, inset = .025,
		legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue")) 
dev.off()

