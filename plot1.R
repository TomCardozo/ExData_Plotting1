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

#	PLOT 1
#
png(filename = "plot1.png", width = 480, height = 480)

hist(powerdf$Global_active_power,
		main = "Global Active Power",
		xlab = "Global Active Power (killowatts)",
		col = "red", xlim = c(0, 6), ylim = c(0, 1200)
		)
dev.off()

