# this code assumes you are the appropriate working directory and the file is unzipped
# note: my data is saved to a different directory than wd(), change paths if needed

# load the data if not already loaded
if (!"NEI" %in% ls()) {
  NEI <- readRDS("~/RProgClass/nei/summarySCC_PM25.rds"
}
if (!"SCC" %in% ls()) {
  SCC <- readRDS("~/RProgClass/nei/Source_Classification_Code.rds")
}

# need to compare subsets, create Los Angeles subset
angeles.subset <- NEI[NEI$fips == "06037",]

# concerned with motor vehicle emissions, search code names
motors.only.la <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
motors.only.la <- SCC[motors.only.la,]
# match back to codes (LA)
motors.only.la <- angeles.subset[angeles.subset$SCC %in% motors.only$SCC,]
# match back to codes (Baltimore City)
motors.only <- balt.subset[balt.subset$SCC %in% motors.only$SCC,]


# aggregate LA data by year, apply sum
motor.emissions.la <- aggregate(motors.only.la$Emissions, list(motors.only.la$year), FUN = "sum")

# open device
png("plot6.png", height = 480, width = 480, units = "px")

# plot LA
plot(motor.emissions.la, type = "l", xlab = "Year", 
     main = "Total Emissions From Combustion Motor\n Sources from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"), col = "red", ylim = c(0,90))
# add baltimore city
lines(motor.emissions, lty="solid", col = "blue")
# clean up with point markers
points(motor.emissions.la, pch = 23, col = "blue", bg = "blue")
points(motor.emissions, pch = 23, col = "red", bg = "red")
# finally, add the legend
legend("right", title = "City", legend = c("LA", "Baltimore City"), fill = c("red", "blue"))

# close device
dev.off()
