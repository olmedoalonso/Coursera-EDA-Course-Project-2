# Plot 2
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

# Get the sum of the Emissions per Year in Baltimore
Total_PM25_Baltimore <- NEI %>% filter(fips == "24510") %>% group_by(year) %>% summarize(Emissions = sum(Emissions))

#Plot 2 as PNG
png("./EDAWeek4/Plot2.png", width = 480, height = 480)
plot(Total_PM25_Baltimore, main = "TOTAL PM25 in BALTIMORE", ylab = "TONS", xlab = "YEARS", type = "o", col = "Blue", pch = 16)
dev.off()