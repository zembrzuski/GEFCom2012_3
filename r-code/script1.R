rm(list = ls())
setwd('~/zenlabs/GEFCom2012_3/r-code')

# reading all_data
all_data <- read.table(
  "../datasets/Load_history.csv", 
  dec = ".", 
  sep = ",", 
  header = TRUE
)

# transforming from characteres with comma to numeric.
my_data <- as.data.frame(gsub(",", "", as.matrix(all_data)))
indx <- sapply(my_data, is.factor)
my_data[indx] <- lapply(my_data[indx], function(x) as.numeric(as.character(x)))
rm(all_data)

# filtering rows with available data.
my_data <- my_data[!is.na(my_data$h23),]

hours_cols <- c('h1',  'h2',  'h3',  'h4',  'h5',  
                'h6',  'h7',  'h8', 'h9',  'h10', 
                'h11', 'h12', 'h13', 'h14', 'h15', 
                'h16', 'h17', 'h18', 'h19', 'h20', 
                'h21', 'h22', 'h23', 'h24')

#
# First plot.
# Ele pega o dia 1 de cada mês do ano de 2005.
# Para cada dia 1, ele plota um gráfico.
# Esse gráfico contém o consumo por hora de cada uma das zonas.
# Não serve para nada isso ainda. Mas pode ser estendido e melhorado.
#
my_date_filtered <- subset(my_data, year==2004 & month==1 & day==1)
min_y_plot <- min(my_date_filtered[,hours_cols])
max_y_plot <- max(my_date_filtered[,hours_cols])
plot(1:24, my_date_filtered[1,hours_cols], type="n", ylim = c(min_y_plot, max_y_plot))
for (i in 1:20) {
  lines(1:24, my_date_filtered[i,hours_cols], type="l", col=i, lwd=2)
}


#
# Second plot.
# Eu acho que vou pegar uma determinada zona.
# E então vou plotar um mês inteiro para cada zona.
# Daí, se der, vou repetir isso para cada mês.
#
my_date_filtered <- subset(my_data, year==2004 & month==1 & zone_id==1)
min_y_plot <- min(my_datadate_filtered[,hours_cols])
max_y_plot <- max(my_datadate_filtered[,hours_cols])
# TODO melhorar isso para que ele seja generino na quantidade de dias por mes. por ora, fica assim.
plot(1:31, my_date_filtered[1,hours_cols], type="n", ylim = c(min_y_plot, max_y_plot))

x <- my_date_filtered[,hours_cols]
as.data.frame(x, ro)
