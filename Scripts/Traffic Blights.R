#x <- c(1,6,10,16)
#r <- c(2,2,2,3)
#g <- c(3,3,3,4)
#x <- c(4,9,13,21,30,2019)
#r <- c(1,8,3,5,9,20)
#g <- c(5,7,5,7,1,0)
#x <- c(2980,8694,42193)
#r <- c(2,19,21)
#g <- c(1,9,2)
#df <- data.frame(x,r,g)

file_name <- "sample-1.in"#"secret-31-all_red_n500_p100.in"
dirname(rstudioapi::getSourceEditorContext()$path)
file_path <- dirname(rstudioapi::getSourceEditorContext()$path)
data_path <- paste0(substr(file_path,0,nchar(file_path)-7),"K-trafficblights/")
df <- read.delim(paste0(data_path,file_name),sep = " ", header = FALSE,col.names = c("x","r","g"))
df <- df[2:nrow(df),]


# Program to find the L.C.M. of two input number
lcm <- function(x, y) {
  # choose the greater number
  if(x > y) {
    greater = x
  } else {
    greater = y
  }
  while(TRUE) {
    if((greater %% x == 0) && (greater %% y == 0)) {
      lcm = greater
      break
    }
    greater = greater + 1
  }
  return(lcm)
}


semaforo <- function(r,g,t){
  p <- r+g
  n <- length(r)
  output <- p*0
  for (i in 1:n) {
    if(t[i]%%p[i] < r[i]){
      output[i] <- "r"
    }
    else{
      output[i] <- "g"
    } 
  }
  return(output)
}

source(paste0(file_path,"/t_llegada.R"))

t_espera <- function(r,g,t){
  p <- r+g
  output <- (t%%p < r)*(r-t%%p) + (t%%p >= r)*0
  return(output)
}

T <- 2520
x <- c(0,1,2,5,6,7,8,9)
y <- x *0
color_semaforo <- matrix(nrow = T, ncol = nrow(df))
for(i in 1:length(x)){
  y[i] <- max(t_llegada(df,x[i])) - x[i]
  color_semaforo[i,] <- semaforo(df$r,df$g,t_llegada(df,x[i]))
}
color_semaforo <- as.data.frame(color_semaforo)

source(paste0(file_path,"/output_final.R"))

output_final(color_semaforo,T)

plot(x,y, xlab = "Tiempo Inicial de partida", ylab = "Tiempo de llegada")
summary(y)

t_i <- 7
t_llegada(df,t_i) - t_i
semaforo(df$r,df$g,t_llegada(df,9))
