#
#
# Calculando correlacoes entre as zonas.
# 
#

rm(list = ls())

require(stats)
require(gdata)

#setwd('~/zenlabs/GEFCom2012_3/r-code')
setwd('~/zenlabs/GEFCom2012/kaggle/r-code')
source('./utils/some_functions.R')

my_data <- read_data_with_commas("../datasets/Load_history.csv")

# filtering rows with available data.
my_data <- my_data[!is.na(my_data$h23),]
my_data <- normalize_data(my_data)

date_2004_01_01 <- subset(my_data, year==2004 & month==1 & day==1)
date_2005_01_01 <- subset(my_data, year==2005 & month==1 & day==1)

correlations_2004_01_01 <- compute_correlation_between_zones(date_2004_01_01, '2004_01_01')
correlations_2005_01_01 <- compute_correlation_between_zones(date_2005_01_01, '2005_01_01')

View(correlations_2004_01_01)
View(correlations_2005_01_01)

# because I know both data frames are with the sames orders, I know I can just 'append' the correlations
# from the first data frame to the second. If I wasn't sure about this, I should make a more sophisticated
# join tables using zone-A and zone-B ids.

correlations_with_two_days <- cbind(correlations_2004_01_01, '2005_01_01'=correlations_2005_01_01[,'2005_01_01'])

# filtrando somente os disponiveis.
indexed_correlations <- correlations_with_two_days[!is.na(correlations_with_two_days[,3]),]

# ordenando
indexed_correlations <- indexed_correlations[order(indexed_correlations[,3], decreasing = TRUE),]

View(indexed_correlations)



#
# What should I do now.
#
# I could make a more abstract function, with a data frame and an array of dates to
# comppute the correlation for the given days. With this function, I can see if a high
# or low correlation in a given day imply a high or low correlation in other day.
# 
# After doing this, I think a good approach is the following: start to implement a model
# to see how well it would perform in a competittion.
# 
