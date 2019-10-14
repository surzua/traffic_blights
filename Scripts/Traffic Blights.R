df <- read.delim(paste0(data_path,file_name),sep = " ", header = FALSE,col.names = c("x","r","g"))
df <- df[2:nrow(df),]
df$p <- df$r + df$g
df$p_reduced <-0

source(paste0(file_path,"/Funciones.R"))

X <- 2520#lcm(df$p)

for (i in 1:nrow(df)){
  df$p_reduced[i] <-  df$p[i] / gcd(X,df$p[i])
}

T_f <- max(df$p_reduced)

color_semaforo <- matrix(nrow = T_f, ncol = nrow(df))
subproblem_sol <- matrix(nrow = X, ncol = nrow(df)+1)

for (i in  0:(X-1)){
  x <- (0:(T_f-1))*X + i
  for(j in x){
    color_semaforo[which(x==j),] <- semaforo(df$r,df$g,t_llegada(df,j))
  }
  subproblem_sol[i+1,] <- output_final(color_semaforo,T_f)
  if(i%%1000 == 0){
    print(paste("Voy en el caso",i))
  }
}

subproblem_sol <- as.data.frame(subproblem_sol)
problema_sol <- apply(subproblem_sol, 2, function(x) {sum(x)/X })

write.table(problema_sol,paste0(data_path,"output-",substr(file_name,1,nchar(file_name)-3),".txt"), sep = "\n", row.names = FALSE, col.names = FALSE)
