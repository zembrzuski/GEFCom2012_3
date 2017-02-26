
get_hours_cols <- function() {
  hours_cols <- c('h1',  'h2',  'h3',  'h4',  'h5', 'h6',  'h7',  'h8', 
                  'h9',  'h10', 'h11', 'h12', 'h13', 'h14', 'h15', 'h16', 
                  'h17', 'h18', 'h19', 'h20', 'h21', 'h22', 'h23', 'h24')
  
  return(hours_cols)
}

read_data_with_commas <- function(file_path) {
  all_data <- read.table(file_path, dec = ".", sep = ",", header = TRUE)
  
  my_data <- as.data.frame(gsub(",", "", as.matrix(all_data)))
  indx <- sapply(my_data, is.factor)
  my_data[indx] <- lapply(my_data[indx], function(x) as.numeric(as.character(x)))

  return(my_data)
}

normalize_data <- function(my_data) {
  my_data_normalized <- t(apply(my_data[,get_hours_cols()], 1, function(x)(x-min(x))/(max(x)-min(x))))
  my_data_normalized <- cbind(my_data[,c('zone_id', 'year', 'month', 'day')], my_data_normalized)
  return(my_data_normalized)
}


compute_correlation_between_zones <- function(my_data) {
  # TODO it would be betther if this get_hours_cols() were a parameters, instead of a coupled function.
  correlations <- cor(t(my_data[,get_hours_cols()]), t(my_data[,get_hours_cols()]))
  correlations <- abs(correlations)
  colnames(correlations) <- 1:20
  rownames(correlations) <- 1:20
  lowerTriangle(correlations, diag=TRUE) <- NA
  
  indexed_correlations <- data.frame(
    row=c(row(correlations)), 
    col=c(col(correlations)), 
    value=mapply(function(x) x, correlations)
  )
  
  return(indexed_correlations)
}