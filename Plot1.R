# Plot 1
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

# Get the sum of the Emissions per Year
Total_PM25_emissions <- aggregate(Emissions ~ year, NEI, FUN = sum)

#Plot 1 as PNG
png("./EDAWeek4/plot1.png", width = 480, height = 480)
plot(Total_PM25_emissions/1000, main = "TOTAL PM25 EMISSIONS IN USA", ylab = "KILOTONS", xlab = "Years", type = "o", col = "Blue", pch = 16)
dev.off()