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

# removing unavailable data.
my_data <- my_data[!is.na(my_data[,9]),]
View(my_data)


TEST-SET

backtesting
2005/2/28
2005/3/1
2005/3/2
2005/3/3
2005/3/4
2005/3/5
2005/6/14
2005/6/15
2005/6/16
2005/6/17
2005/6/18
2005/6/19
2005/9/4
2005/9/5
2005/9/6
2005/9/7
2005/9/8
2005/9/9
2005/12/19
2005/12/20
2005/12/21
2005/12/22
2005/12/23
2005/12/24
2006/2/7
2006/2/8
2006/2/9
2006/2/10
2006/2/11
2006/2/12
2006/5/19
2006/5/20
2006/5/21
2006/5/22
2006/5/23
2006/5/24
2006/8/27
2006/8/28
2006/8/29
2006/8/30
2006/7/31
2006/8/1
2006/11/16
2006/11/17
2006/11/18
2006/11/19
2006/11/20
2006/11/21


forecasting

2008/6/25
2008/6/26
2008/6/27
2008/6/28
2008/6/29
2008/6/30




test_set <- ?
validation_set <- ?
training_set <- ?

