#
# http://stackoverflow.com/questions/7395397/how-to-apply-function-over-each-matrix-elements-indices
#

xoxo <- outer(1:nrow(mat), 1:ncol(mat) , FUN="*")

mapply(function(x) x, row(xoxo))
mapply(function(x) x, col(xoxo))

data.frame(
  row=c(row(xoxo)), 
  col=c(col(xoxo)), 
  value=mapply(function(x) x, xoxo)
)



View(xoxo)
