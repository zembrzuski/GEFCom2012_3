rm(list = ls())
setwd('~/zenlabs/GEFCom2012_3/r-code')

mydata = read.csv("../datasets/Load_history.csv")  # read csv file 

zone_1 = subset(mydata, zone_id==1)

typeof(mydata)
x <- "hellow"
print(x)
