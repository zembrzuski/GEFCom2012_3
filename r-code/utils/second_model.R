# In this model, I'll predict the last day 

backtesting_dates_1 <- c('2005/2/22', '2005/2/23', '2005/2/24', '2005/2/25', '2005/2/26', '2005/2/27')
backtesting_dates_2 <- c('2005/6/8','2005/6/9','2005/6/10','2005/6/11','2005/6/12','2005/6/13')
backtesting_dates_3 <- c('2005/8/29','2005/8/30','2005/8/31','2005/9/1','2005/9/2','2005/9/3')
backtesting_dates_4 <- c('2005/12/13','2005/12/14','2005/12/15','2005/12/16','2005/12/17','2005/12/18')
backtesting_dates_5 <- c('2006/2/1','2006/2/2','2006/2/3','2006/2/4','2006/2/5','2006/2/6')
backtesting_dates_6 <- c('2006/5/13','2006/5/14','2006/5/15','2006/5/16','2006/5/17','2006/5/18')
backtesting_dates_7 <- c('2006/8/21','2006/8/22','2006/8/23','2006/8/24','2006/8/25','2006/8/26')
backtesting_dates_8 <- c('2006/11/10','2006/11/11','2006/11/12','2006/11/13','2006/11/14','2006/11/15')

forecasting_dates <- c('2008/6/19', '2008/6/20', '2008/6/21', '2008/6/22', '2008/6/23', '2008/6/24')



do_prediction <- function(base_date, dates_to_predict) {
  # nesse caso, o base date é o dia anterior.
  base_data <- subset(zone_training_set, date_as_str == base_date)[,c(get_hours_cols(), 'zone_id')]
  return(merge(cbind(dates_to_predict), base_data, all=TRUE))
}

zones_backtesting_predictions_1 <- do_prediction('2005/2/21', backtesting_dates_1)
zones_backtesting_predictions_2 <- do_prediction('2005/6/7', backtesting_dates_2)
zones_backtesting_predictions_3 <- do_prediction('2005/8/28', backtesting_dates_3)
zones_backtesting_predictions_4 <- do_prediction('2005/12/12', backtesting_dates_4)
zones_backtesting_predictions_5 <- do_prediction('2006/1/31', backtesting_dates_5)
zones_backtesting_predictions_6 <- do_prediction('2006/5/12', backtesting_dates_6)
zones_backtesting_predictions_7 <- do_prediction('2006/8/20', backtesting_dates_7)
zones_backtesting_predictions_8 <- do_prediction('2006/11/9', backtesting_dates_8)

system_backtesting_predictions_1 <- aggregate(. ~ dates_to_predict, zones_backtesting_predictions_1[,c(get_hours_cols(), 'dates_to_predict')], sum)
system_backtesting_predictions_2 <- aggregate(. ~ dates_to_predict, zones_backtesting_predictions_2[,c(get_hours_cols(), 'dates_to_predict')], sum)
system_backtesting_predictions_3 <- aggregate(. ~ dates_to_predict, zones_backtesting_predictions_3[,c(get_hours_cols(), 'dates_to_predict')], sum)
system_backtesting_predictions_4 <- aggregate(. ~ dates_to_predict, zones_backtesting_predictions_4[,c(get_hours_cols(), 'dates_to_predict')], sum)
system_backtesting_predictions_5 <- aggregate(. ~ dates_to_predict, zones_backtesting_predictions_5[,c(get_hours_cols(), 'dates_to_predict')], sum)
system_backtesting_predictions_6 <- aggregate(. ~ dates_to_predict, zones_backtesting_predictions_6[,c(get_hours_cols(), 'dates_to_predict')], sum)
system_backtesting_predictions_7 <- aggregate(. ~ dates_to_predict, zones_backtesting_predictions_7[,c(get_hours_cols(), 'dates_to_predict')], sum)
system_backtesting_predictions_8 <- aggregate(. ~ dates_to_predict, zones_backtesting_predictions_8[,c(get_hours_cols(), 'dates_to_predict')], sum)

zones_forecasting_predictions <- do_prediction('2008/6/18', forecasting_dates)
system_forecasting_predictions <- aggregate(. ~ dates_to_predict, zones_forecasting_predictions[,c(get_hours_cols(), 'dates_to_predict')], sum)

zones_backtesting_predictions <- 
  rbind(zones_backtesting_predictions_1, zones_backtesting_predictions_2, 
        zones_backtesting_predictions_3, zones_backtesting_predictions_4,
        zones_backtesting_predictions_5, zones_backtesting_predictions_6,
        zones_backtesting_predictions_7, zones_backtesting_predictions_8)

system_backtesting_predictions <-
  rbind(system_backtesting_predictions_1, system_backtesting_predictions_2,
        system_backtesting_predictions_3, system_backtesting_predictions_4,
        system_backtesting_predictions_5, system_backtesting_predictions_6,
        system_backtesting_predictions_7, system_backtesting_predictions_8)

