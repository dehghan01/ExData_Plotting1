library(dplyr)

createPlot1 = function(filename = "household_power_consumption.txt"){
    .createPlot1(.readData(filename))
}

#read data from current wd
.readData = function(filename){
    #read data and subset accordingly
    data_df <-read.table(filename, sep=";", header=TRUE,na.strings="?")
    data_df$Date <- as.Date(data_df$Date, format = "%d/%m/%Y")
    data <- data_df %>% subset(Date == "2007-02-01" | Date == "2007-02-02")
    
    data
} 

.createPlot1 = function(df){
    png("Plot1.png")
    hist(df$Global_active_power, col ="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
    dev.off()
}
