rm(list = ls())
setwd('~/zenlabs/GEFCom2012_3/r-code')

all_data <- read.csv2("../datasets/Load_history.csv", dec = ".", sep = ",", header = TRUE)


all_data_transformed <- lapply(all_data,
       function(x){
          as.numeric(gsub(",", "", x))
      }
)


dim(all_data_transformed)

hours_cols <- 5:28

date_filtered <- subset(all_data, year==2004 & month==1 & day==1)
y <- date_filtered[,hours_cols]

gsub(",", "", y[1,])

plot(1:24, y[1,], type="n", ylim = c(min(y), max(y)))

for (i in 1:20) {
  lines(1:24, y[i,], type="l", col=i)
}

