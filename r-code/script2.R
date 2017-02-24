#install.packages('gdata')

require(stats)
require(gdata)

#
# Correlacoes entre as zonas.
#

rm(list = ls())

setwd('~/zenlabs/GEFCom2012_3/r-code')
#setwd('~/zenlabs/GEFCom2012/kaggle/r-code')

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

my_date_filtered <- subset(my_data, year==2004 & month==1 & day==1)

## calculando correlacao entre duas zonas.
## esse indice está bem ok em relação ao que eu havia visualizado.
correlations <- cor(t(my_date_filtered[,hours_cols]), t(my_date_filtered[,hours_cols]))
correlations <- abs(correlations)
colnames(correlations) <- 1:20
rownames(correlations) <- 1:20
lowerTriangle(correlations, diag=TRUE) <- NA
View(correlations)

indexed_correlations <- data.frame(
  row=c(row(correlations)), 
  col=c(col(correlations)), 
  value=mapply(function(x) x, correlations)
)

# filtrando somente os disponiveis.
indexed_correlations <- indexed_correlations[!is.na(indexed_correlations[,3]),]

# ordenando
indexed_correlations <- indexed_correlations[order(indexed_correlations[,3], decreasing = TRUE),]

View(indexed_correlations)

