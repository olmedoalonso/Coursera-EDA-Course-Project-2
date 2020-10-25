# Plot 5
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

# Get the sum of the Motor Vehicles Emissions per Year in Baltimore
NEI_Vehicles_Baltimore <- NEI %>% filter(fips == "24510") %>% filter(SCC %in% SCC_Vehicles) %>% group_by(year) %>% summarise(Emissions = sum(Emissions))

#Plot 5 as PNG
png("./EDAWeek4/Plot5.png", width = 480, height = 480)
Vehicles_Baltimore <- qplot(year, Emissions, data = NEI_Vehicles_Baltimore)+ geom_line() + ggtitle("MOTOR VEHICLES EMISSION IN BALTIMORE") + xlab("YEARS") + ylab("TONS OF PM25") + theme(plot.title = element_text(hjust = 0.5))
print(Vehicles_Baltimore)
dev.off()