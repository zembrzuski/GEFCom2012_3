# creating all data sets

rm(list = ls())

require(plyr)
require(stats)
require(gdata)

#setwd('~/zenlabs/GEFCom2012_3/r-code')
setwd('~/zenlabs/GEFCom2012/kaggle/r-code')
source('./utils/some_functions.R')

my_data <- read_data_with_commas("../datasets/Load_history.csv")
my_data <- my_data[!is.na(my_data[,9]),]

my_data <- cbind(my_data, apply(my_data, 1, function(x) paste0(paste0(paste0(paste0(x['year'], '/'), x['month']), '/'), x['day'])))
colnames(my_data)[dim(my_data)[2]] <- 'date_as_str'

### VALIDATION-SET
zone_validation_set_backtesting <- merge(cbind('date_as_str'=c('2005/2/22', '2005/2/23', '2005/2/24', '2005/2/25', '2005/2/26', '2005/2/27', '2005/6/8', '2005/6/9', '2005/6/10', '2005/6/11', '2005/6/12', '2005/6/13', '2005/8/29', '2005/8/30', '2005/8/31', '2005/9/1', '2005/9/2', '2005/9/3', '2005/12/13', '2005/12/14', '2005/12/15', '2005/12/16', '2005/12/17', '2005/12/18', '2006/2/1', '2006/2/2', '2006/2/3', '2006/2/4', '2006/2/5', '2006/2/6', '2006/5/13', '2006/5/14', '2006/5/15', '2006/5/16', '2006/5/17', '2006/5/18', '2006/8/21', '2006/8/22', '2006/8/23', '2006/8/24', '2006/8/25', '2006/8/26', '2006/11/10', '2006/11/11', '2006/11/12', '2006/11/13', '2006/11/14', '2006/11/15')), my_data)
zone_validation_set_forecasting <- merge(cbind('date_as_str'=c('2008/6/19', '2008/6/20', '2008/6/21', '2008/6/22', '2008/6/23', '2008/6/24')), my_data)
system_validation_set_backtesting <- aggregate(. ~ date_as_str, zone_validation_set_backtesting[,c(get_hours_cols(), 'date_as_str')], sum)
system_validation_set_forecasting <- aggregate(. ~ date_as_str, zone_validation_set_forecasting[,c(get_hours_cols(), 'date_as_str')], sum)

### TEST-SET
zone_test_set_backtesting <- merge(cbind('date_as_str'=c('2005/2/28', '2005/3/1', '2005/3/2', '2005/3/3', '2005/3/4', '2005/3/5', '2005/6/14', '2005/6/15', '2005/6/16', '2005/6/17', '2005/6/18', '2005/6/19', '2005/9/4', '2005/9/5', '2005/9/6', '2005/9/7', '2005/9/8', '2005/9/9', '2005/12/19', '2005/12/20', '2005/12/21', '2005/12/22', '2005/12/23', '2005/12/24', '2006/2/7', '2006/2/8', '2006/2/9', '2006/2/10', '2006/2/11', '2006/2/12', '2006/5/19', '2006/5/20', '2006/5/21', '2006/5/22', '2006/5/23', '2006/5/24', '2006/8/27', '2006/8/28', '2006/8/29', '2006/8/30', '2006/7/31', '2006/8/1', '2006/11/16', '2006/11/17', '2006/11/18', '2006/11/19', '2006/11/20', '2006/11/21')), my_data)
system_test_set_backtesting <- aggregate(. ~ date_as_str, zone_test_set_backtesting[,c(get_hours_cols(), 'date_as_str')], sum)
zone_test_set_forecasting <- merge(cbind('date_as_str'=c('2008/6/25', '2008/6/26', '2008/6/27', '2008/6/28', '2008/6/29', '2008/6/30')), my_data)
system_test_set_forecasting <- aggregate(. ~ date_as_str, zone_test_set_forecasting[,c(get_hours_cols(), 'date_as_str')], sum)

my_data <- my_data[!my_data[,'date_as_str'] %in% zone_validation_set_backtesting[,'date_as_str'],]
my_data <- my_data[!my_data[,'date_as_str'] %in% zone_validation_set_forecasting[,'date_as_str'],]
my_data <- my_data[!my_data[,'date_as_str'] %in% zone_test_set_backtesting[,'date_as_str'],]
my_data <- my_data[!my_data[,'date_as_str'] %in% zone_test_set_forecasting[,'date_as_str'],]


### TRAINING-SET
zone_training_set <- my_data
system_training_set <- aggregate(. ~ date_as_str, zone_training_set[,c(get_hours_cols(), 'date_as_str')], sum)
