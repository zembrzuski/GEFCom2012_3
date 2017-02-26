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
date_2004_01_01_correlations <- compute_correlation_between_zones(date_2004_01_01)

# filtrando somente os disponiveis.
indexed_correlations <- date_2004_01_01_correlations[!is.na(date_2004_01_01_correlations[,3]),]

# ordenando
indexed_correlations <- indexed_correlations[order(indexed_correlations[,3], decreasing = TRUE),]

View(indexed_correlations)

