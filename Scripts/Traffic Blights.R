file_name <- "secret-31-all_red_n500_p100.in"
dirname(rstudioapi::getSourceEditorContext()$path)
file_path <- dirname(rstudioapi::getSourceEditorContext()$path)
data_path <- paste0(substr(file_path,0,nchar(file_path)-7),"K-trafficblights/")
df <- read.delim(paste0(data_path,file_name),sep = " ", header = FALSE,col.names = c("x","r","g"))
df <- df[2:nrow(df),]
df$p <- df$r + df$g


# Program to find the L.C.M. of two input number
lcm <- function(x) {
  # choose the greater number
  greater <- max(x)
  while(TRUE) {
    if( sum(greater %% x == 0) == length(x)) {
      lcm = greater
      break
    }
    greater = greater + 1
  }
  return(lcm)
}

gcd <- function(x, y) {
  while(y) {
    temp = y
    y = x %% y
    x = temp
  }
  return(x)
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

X <- 2520#lcm(df$p)
df$p_reduced <-0

#probability approach
for (i in 1:nrow(df)) {
  df$p_reduced[i] <-  df$p[i] / gcd(X,df$p[i])
}

T_f <- max(df$p_reduced)

color_semaforo <- matrix(nrow = T_f, ncol = nrow(df))
#color_semaforo <- data.frame()

subproblem_sol <- matrix(nrow = X, ncol = nrow(df)+1)
source(paste0(file_path,"/output_final.R"))

for (i in  0:(X-1)){
  x <- (0:(T_f-1))*X + i
  #color_semaforo[i,] <- semaforo(df$r,df$g,t_llegada(df,i))
  for(j in x){
    color_semaforo[which(x==j),] <- semaforo(df$r,df$g,t_llegada(df,j))
  }
  subproblem_sol[i+1,] <- output_final(color_semaforo,T_f)
  if(i%%1000 == 0){
    print(paste("Voy en el caso",i))
  }
}

color_semaforo <- as.data.frame(color_semaforo)
subproblem_sol <- as.data.frame(subproblem_sol)

problema_sol <- apply(subproblem_sol, 2, function(x) {sum(x)/X })

write.table(problema_sol,paste0(data_path,"output.txt"), sep = "\n", row.names = FALSE, col.names = FALSE)
