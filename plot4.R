# this code assumes you are the appropriate working directory and the file is unzipped
# note: my data is saved to a different directory than wd(), change paths if needed

# load the data if not already loaded
if (!"NEI" %in% ls()) {
  NEI <- readRDS("~/RProgClass/nei/summarySCC_PM25.rds"
}
if (!"SCC" %in% ls()) {
  SCC <- readRDS("~/RProgClass/nei/Source_Classification_Code.rds")
}

# we need only coal related emissions; search for coal in the code names
coal.only <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
coal.only <- SCC[coal.only,]
# match back to codes
coal.only <- NEI[NEI$SCC %in% coal.only$SCC,]

# aggregate by year, apply sum
coal.emissions <- aggregate(coal.only$Emissions, list(coal.only$year), FUN = "sum")


# open device
png("plot4.png", height = 480, width = 480, units = "px")

# plot
plot(coal.emissions, type = "l", xlab = "Year", 
     main = "Total Emissions From Coal Combustion-related\n Sources from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission (tons)"), col = "red")
points(coal.emissions, pch = 23, col = "blue", bg = "blue")

# close device
dev.off()
