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

#	PLOT 2
#
png(filename = "plot2.png", width = 480, height = 480)

with(powerdf, plot(Global_active_power,
				xlab = "", ylab = "Global Active Power (killowatts)",
				lty = 1, lwd = 1, type = "l", xaxt = "n"
				))
axis(side = 1, at = c(0, 1440, 2880), labels = c("Thur", "Fri", "Sat"))
dev.off()

