#
#
# Calculando correlacoes entre as zonas.
# 
#

rm(list = ls())

require(stats)
require(gdata)

setwd('~/zenlabs/GEFCom2012_3/r-code')
#setwd('~/zenlabs/GEFCom2012/kaggle/r-code')
source('./utils/some_functions.R')

my_data <- read_data_with_commas("../datasets/Load_history.csv")

# filtering rows with available data.
my_data <- my_data[!is.na(my_data$h23),]
my_data <- normalize_data(my_data)

date_2004_01_01 <- subset(my_data, year==2004 & month==1 & day==1)
date_2005_01_01 <- subset(my_data, year==2005 & month==1 & day==1)
date_2006_01_01 <- subset(my_data, year==2006 & month==1 & day==1)
date_2007_01_01 <- subset(my_data, year==2007 & month==1 & day==1)

matrix_correlation <- prepare_correlation_matrix(date_2004_01_01)
matrix_correlation <- append_date_to_correlation_matrix(matrix_correlation, date_2004_01_01, '2004_01_01')
matrix_correlation <- append_date_to_correlation_matrix(matrix_correlation, date_2005_01_01, '2005_01_01')
matrix_correlation <- append_date_to_correlation_matrix(matrix_correlation, date_2006_01_01, '2006_01_01')
matrix_correlation <- append_date_to_correlation_matrix(matrix_correlation, date_2007_01_01, '2007_01_01')

# filtrando somente os disponiveis.
matrix_correlation <- matrix_correlation[!is.na(matrix_correlation[,3]),]

# ordenando
#matrix_correlation <- indexed_correlations[order(indexed_correlations[,3], decreasing = TRUE),]

View(matrix_correlation)
