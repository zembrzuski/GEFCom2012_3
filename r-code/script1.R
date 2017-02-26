#
#
# Visualizing data.
#
#

rm(list = ls())

#setwd('~/zenlabs/GEFCom2012_3/r-code')
setwd('~/zenlabs/GEFCom2012/kaggle/r-code')

all_data <- read.table("../datasets/Load_history.csv", dec = ".", sep = ",", header = TRUE)

# transforming from characteres with comma to numeric.
my_data <- as.data.frame(gsub(",", "", as.matrix(all_data)))
indx <- sapply(my_data, is.factor)
my_data[indx] <- lapply(my_data[indx], function(x) as.numeric(as.character(x)))
rm(all_data)

# filtering rows with available data.
my_data <- my_data[!is.na(my_data$h23),]

hours_cols <- c('h1',  'h2',  'h3',  'h4',  'h5', 'h6',  'h7',  'h8', 'h9',  'h10', 'h11', 'h12', 'h13', 'h14', 'h15', 'h16', 'h17', 'h18', 'h19', 'h20', 'h21', 'h22', 'h23', 'h24')


my_data_normalized <- t(apply(my_data[,hours_cols], 1, function(x)(x-min(x))/(max(x)-min(x))))
my_data_normalized <- cbind(my_data[,c('zone_id', 'year', 'month', 'day')], my_data_normalized)
my_data <- my_data_normalized
rm(my_data_normalized)

#
# First plot.
# Ele pega o dia 1 de cada mês do ano de 2005.
# Para cada dia 1, ele plota um gráfico.
# Esse gráfico contém o consumo por hora de cada uma das zonas.
# Não serve para nada isso ainda. Mas pode ser estendido e melhorado.
#
par(mfrow = c(1, 1))
my_date_filtered <- subset(my_data, year==2004 & month==1 & day==1)
min_y_plot <- min(my_date_filtered[,hours_cols])
max_y_plot <- max(my_date_filtered[,hours_cols])
plot(1:24, my_date_filtered[1,hours_cols], type="n", ylim = c(min_y_plot, max_y_plot))
for (i in 20:1) {
  lines(1:24, my_date_filtered[i,hours_cols], type="l", col=i, lwd=1)
}







# verificando correlacao visualmente entre cada par de zonas.
par(mfrow = c(1, 1))
my_date_filtered <- subset(my_data, year==2004 & month==7 & day==1)
min_y_plot <- min(my_date_filtered[,hours_cols])
max_y_plot <- max(my_date_filtered[,hours_cols])

for(i in 20:1) {
  for(j in 20:i) {
    if(i != j) {
      plot(1:24, my_date_filtered[1,hours_cols], type="n", ylim = c(min_y_plot, max_y_plot))
      lines(1:24, my_date_filtered[i,hours_cols], type="l", col=i, lwd=1)
      lines(1:24, my_date_filtered[j,hours_cols], type="l", col=j, lwd=1)
      legend("topright", legend = c(i, j), fill = c(i, j), horiz = FALSE, inset = -.02, cex=.8, pt.cex = 1, bg = "transparent", bty = "n")
    }
  }
}









my_data_normalized <- t(apply(my_data[,hours_cols], 1, function(x)(x-min(x))/(max(x)-min(x))))
my_data_normalized <- cbind(my_data[,c('zone_id', 'year', 'month', 'day')], my_data_normalized)
View(my_data_normalized)
my_data[,c('zone_id', 'year', 'month', 'day')]#
# Second plot.
# Eu acho que vou pegar uma determinada zona.
# E então vou plotar um mês inteiro para cada zona.
# Daí, se der, vou repetir isso para cada mês.
#
my_date_filtered <- subset(my_data, year==2004 & month==1 & zone_id==1)
month_series <- matrix(unlist(t(my_date_filtered[,hours_cols])), byrow=T, nrow=1)[1,]
plot(1:length(month_series), month_series, type="n", ylim = c(min(month_series), max(month_series)))
lines(1:length(month_series), month_series, type="l", ylim = c(min(month_series), max(month_series)))


# Third plot.
# Para que vai servir esse cara?
# Assim, vou pegar uma determinada zona.
# Com essa zona, vou pegar cada um dos meses.
# Para cada mes, vou calcular media, mediana, quartis, etc.
# Aí, para cada mês, vou plotar um boxplot para ele.

#my_date_filtered <- t(subset(my_data, year==2004 & month==1 & zone_id==9)[,c('day', hours_cols)])
my_date_filtered <- t(subset(my_data, year==2004 & month==1 & zone_id==1)[,c(hours_cols)])
boxplot(my_date_filtered)




# NAO ESQUECER: NORMALIZAR OS DADOS DEPOIS

# What am I going to do in this file?
#
# It is very simple. Given a day and and two zones, I'll plot
# a graphic with two subplots.

par(mfrow = c(3, 1))

my_date_filtered <- subset(my_data, year==2004 & month==1 & day==1 & zone_id==1)
min_y_plot <- min(my_date_filtered[,hours_cols])
max_y_plot <- max(my_date_filtered[,hours_cols])
plot(1:24, my_date_filtered[1,hours_cols], type="n", ylim = c(min_y_plot, max_y_plot))
lines(1:24, my_date_filtered[1,hours_cols], type="l", col=1, lwd=2)

my_date_filtered <- subset(my_data, year==2004 & month==1 & day==1 & zone_id==2)
min_y_plot <- min(my_date_filtered[,hours_cols])
max_y_plot <- max(my_date_filtered[,hours_cols])
plot(1:24, my_date_filtered[1,hours_cols], type="n", ylim = c(min_y_plot, max_y_plot))
lines(1:24, my_date_filtered[1,hours_cols], type="l", col=2, lwd=2)

my_date_filtered <- subset(my_data, year==2004 & month==1 & day==1 & zone_id==4)
min_y_plot <- min(my_date_filtered[,hours_cols])
max_y_plot <- max(my_date_filtered[,hours_cols])
plot(1:24, my_date_filtered[1,hours_cols], type="n", ylim = c(min_y_plot, max_y_plot))
lines(1:24, my_date_filtered[1,hours_cols], type="l", col=3, lwd=2)



# grafico mais bonitinho
# http://stackoverflow.com/questions/11794436/stacking-multiple-plots-vertically-with-the-same-x-axis-but-different-y-axes-in
