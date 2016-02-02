# this code assumes you are the appropriate working directory and the file is unzipped
# note: my data is saved to a different directory than wd(), change paths if needed

# load the data if not already loaded
if (!"NEI" %in% ls()) {
  NEI <- readRDS("~/RProgClass/nei/summarySCC_PM25.rds"
}
if (!"SCC" %in% ls()) {
  SCC <- readRDS("~/RProgClass/nei/Source_Classification_Code.rds")
}

# we need the Baltimore City subset of the NEI data
balt.subset <- NEI[NEI$fips == "24510",]

# aggregate by year and apply sum
total.emissions2 <- aggregate(balt.subset$Emissions, list(balt.subset$year), FUN = "sum")

# open device
png("plot2.png", height = 480, width = 480, units = "px")

# plot 
plot(total.emissions2, type = "l", main = "Total PM2.5 Emissions by Year\n in Baltimore City, Maryland ", 
     xlab = "Years ('99-'08)", ylab = "Total Emissions (tons)", col = "red")
points(yearly.totals.md, pch = 23, col = "blue", bg = "blue")

# close device, saves to working directory
dev.off()
