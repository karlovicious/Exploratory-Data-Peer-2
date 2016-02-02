# this code assumes you are the appropriate working directory and the file is unzipped
# note: my data is saved to a different directory than wd(), change paths if needed

# load the data if not already loaded
if (!"NEI" %in% ls()) {
  NEI <- readRDS("~/RProgClass/nei/summarySCC_PM25.rds"
}
if (!"SCC" %in% ls()) {
  SCC <- readRDS("~/RProgClass/nei/Source_Classification_Code.rds")
}

# we need to discern the amount of emissions by type for Baltimore City; plyr makes
# this very easy: subset to correct location, then apply summarise
blt.city <- ddply(NEI[NEI$fips == "24510", ],
                  .(type,year), summarise,
                  total.emissions = sum(Emissions))

# open device
png("plot3.png", height = 480, width = 480, units = "px")

# plot with ggplot as requested
ggplot(blt.city, aes(year, total.emissions, color = type)) +
  geom_line() + geom_point() + labs(title = "Total Emission by Type in Baltimore City",
                                    x = "Year", y = "Total Emissions (tons)")

# close device, saves to working directory
dev.off()
