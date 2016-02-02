# this code assumes you are the appropriate working directory and the file is unzipped
# note: my data is saved to a different directory than wd(), change paths if needed

# load the data if not already loaded
if (!"NEI" %in% ls()) {
  NEI <- readRDS("~/RProgClass/nei/summarySCC_PM25.rds"
}
if (!"SCC" %in% ls()) {
  SCC <- readRDS("~/RProgClass/nei/Source_Classification_Code.rds")
}

# we need to determine how much emissions motor vehicles produce, search for motor in codes
motors.only <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
motors.only <- SCC[motors.only,]
# match back to codes (baltimore city subset only per request)
motors.only <- balt.subset[balt.subset$SCC %in% motors.only$SCC,]

# aggregate by year, apply sum
motor.emissions <- aggregate(motors.only$Emissions, list(motors.only$year), FUN = "sum")

# open device
png("plot5.png", height = 480, width = 480, units = "px")

# plot 
plot(motor.emissions, type = "l", xlab = "Year", 
     main = "Total Emissions From Combustion Motor\n Sources from 1999 to 2008 in Baltimore City", 
     ylab = expression('Total PM'[2.5]*" Emission (tons)"), col = "red")
points(motor.emissions, pch = 23, col = "blue", bg = "blue")

# close device
dev.off()
