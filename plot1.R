# this code assumes you are the appropriate working directory and the file is unzipped
# note: my data is saved to a different directory than wd(), change paths if needed

# load the data if not already loaded
if (!"NEI" %in% ls()) {
  NEI <- readRDS("~/RProgClass/nei/summarySCC_PM25.rds"
}
if (!"SCC" %in% ls()) {
  SCC <- readRDS("~/RProgClass/nei/Source_Classification_Code.rds")
}

# need total emmissions per year, aggregate by year and apply sum function
total.emissions <- aggregate(NEI$Emissions, list(NEI$year), FUN = "sum")

# open device
png("plot1.png", height = 480, width = 480, units = "px")

# plot total emissions
plot(total.emissions, type = "l", main = expression('Total PM'[2.5]*" Emission"), 
     xlab = "Years ('99-'08)", ylab = expression('Total PM'[2.5]*" Emission (tons)"), col = "red")
points(total.emissions, pch = 23, col = "blue", bg = "blue")

# close device, saves to working directory
dev.off()
