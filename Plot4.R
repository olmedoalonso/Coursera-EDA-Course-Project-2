# Plot 4
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

# Get the word "Coal" from the EI.Sector column and obtain the SCC number.
SCC_coal <- SCC[grep("[Coal]", SCC$EI.Sector), "SCC"]

# Get the sum of the Emissions per Year from the SCC #´s with the word "Coal".
NEI_Coal <- NEI %>% filter(SCC %in% SCC_coal) %>% group_by(year) %>% summarise(Emissions = sum(Emissions))

#Plot 4 as PNG
png("./EDAWeek4/Plot4.png", width = 480, height = 480)
USA_coal <- qplot(year, Emissions/1000, data = NEI_Coal)+ geom_line() + ggtitle("COAL RELATED EMISSIONS IN USA") + xlab("YEARS") + ylab("KILOTONS OF PM25") + theme(plot.title = element_text(hjust = 0.5))
print(USA_coal)
dev.off()