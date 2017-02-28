# All zeros.

create_zeros_predictions_zones <- function(real_answer_matrix) {
  zeros_predictions <- real_answer_matrix[,c('date_as_str', 'zone_id')]
  
  new_data_frame <- data.frame(matrix(0, ncol=24, nrow=dim(real_answer_matrix)[1]))
  colnames(new_data_frame) <- get_hours_cols()
  
  return(cbind(zeros_predictions, new_data_frame))
}

create_zeros_predictions_system <- function(real_answer_matrix) {
  zeros_predictions <- real_answer_matrix[,'date_as_str']
  
  new_data_frame <- data.frame(matrix(0, ncol=24, nrow=dim(real_answer_matrix)[1]))
  colnames(new_data_frame) <- get_hours_cols()
  
  return(cbind(zeros_predictions, new_data_frame))
}

zone_validation_set_backtesting_predictions <- create_zeros_predictions_zones(zone_validation_set_backtesting)
system_validation_set_backtesting_predictions <- create_zeros_predictions_system(system_validation_set_backtesting)
zone_validation_set_forecasting_predictions <- create_zeros_predictions_zones(zone_validation_set_forecasting)
system_validation_set_forecasting_predictions <- create_zeros_predictions_system(system_validation_set_forecasting)

a <- cost_function(zone_validation_set_backtesting_predictions, zone_validation_set_backtesting, 1)
b <- cost_function(system_validation_set_backtesting_predictions, system_validation_set_backtesting, 20)
c <- cost_function(zone_validation_set_forecasting_predictions, zone_validation_set_forecasting, 8)
d <- cost_function(system_validation_set_forecasting_predictions, system_validation_set_forecasting, 160)

result_for_my_first_model <- a + b + c + d

paste0('result for my first model is: ', result_for_my_first_model)
