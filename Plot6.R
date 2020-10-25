# Plot 6
#- Download the file and put it in the folder
if(!file.exists("./EDAWeek4")){dir.create(./EDAWeek4")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./EDAWeek4/CourseProject2.zip")

#- Unzip the file to the folder
unzip(zipfile = ".//EDAWeek4/CourseProject2.zip", exdir = "./EDAWeek4")

#- Unzip the files that are in the folder.  I created a function "pathway" and "pathway1" for the paths.
pathway <- file.path("./EDAWeek4", "summarySCC_PM25.rds")
pathway1 <- file.path("./EDAWeek4", "Source_Classification_Code.rds")

# - Read the file Source Classification Code and summary SCC PM25
NEI <- readRDS(pathway)
SCC <- readRDS(pathway1)

# Get the word "Vehicles" from the EI.Sector column and obtain the SCC number.
SCC_Vehicles <- SCC[grep("Vehicles", SCC$EI.Sector), "SCC"]

# Get the sum of the Motor Vehicles Emissions per Year in Baltimore City and Los Angeles County 
NEI_Vehicles_Baltimore <- NEI %>% filter(fips == "24510") %>% filter(SCC %in% SCC_Vehicles) %>% group_by(year) %>% summarise(Emissions = sum(Emissions))
NEI_Vehicles_LA_County <- NEI %>% filter(fips == "06037") %>% filter(SCC %in% SCC_Vehicles) %>% group_by(year) %>% summarise(Emissions = sum(Emissions))

#Plot 6 as PNG
png("./EDAWeek4/Plot6.png", width = 800, height = 400) 
par(mfrow = c(1, 2), mar = c(4, 4, 2, 1))
plot(NEI_Vehicles_Baltimore, ylab = "PM25 (TONS)", xlab = "Baltimore City", type = "o", col = "Blue", pch = 16, ylim = rng)
plot(NEI_Vehicles_LA_County, ylab = "PM25 (TONS)", xlab = "Los Angeles County", type = "o", col = "Red", pch = 16, ylim = rng)
title(main = "EMISSION COMPARISON AMONG TWO CITIES", outer = TRUE, cex = 1)
rng <- range(NEI_Vehicles_Baltimore$Emissions, NEI_Vehicles_LA_County$Emissions, na.rm = TRUE)
dev.off()