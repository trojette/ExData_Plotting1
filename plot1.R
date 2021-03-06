######################
## Course Project 1 ##
######################

## 1. Set global settings
# UK locale
Sys.setlocale("LC_TIME", "en_GB")

# Working directory and dataset file name
DIR <- "/Users/adn/Documents/Perso/MOOCs/Coursera/Data Specialisation/4. Exploratory Data Analysis/CourseProject1/ExData_Plotting1"
setwd(DIR)
fileName = "household_power_consumption.txt"

## 2. Identify dataset's characteristics (colnames in particular)
initialHpc = initial <- read.csv2(fileName, nrows = 100)
colNames <- colnames(initialHpc)

## 3. Identify which rows we really need
## After testing, we need rows in the 66637:69516 range

## 4. Read the data file - only rows of interest
hpc <- read.csv2(fileName,
                 na.strings = "?",
                 comment.char = "",
                 skip = 66636,
                 nrows = 2880,
                 colClasses = rep("character", 9),
                 col.names = colNames
)

## 5. Convert first and second columns to Date format
tempDates <- paste(hpc$Date, hpc$Time)
Dates <- as.POSIXct(strptime(tempDates, "%d/%m/%Y %H:%M:%S"))

## 6. Remove bad date-formatted columns and assume numeric
##    columns as.numeric
hpc$Date <- Dates
for(i in 3:9) hpc[,i] <- as.numeric(hpc[,i])
hpc <- hpc[, c(1, 3:9)]

## 7. Prepare export to PNG device
png(filename = "plot1.png",
    bg = "transparent",
    width = 480,
    height = 480,
    units = "px")

## 8. Draw Plot 1
## Set layout
par(mfrow = c(1, 1))

## Draw Plot
hist(hpc$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = "red",
     main = "Global Active Power"
)

## 9. Release PNG device.
dev.off()
