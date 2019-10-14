output_final <- function(color_semaforo,T){
   n <- ncol(color_semaforo)
   output <- numeric(n+1)
   output[1] <- length(which(( color_semaforo[,1] == "r"))) / T
   for (i in 2:n){
     output[i] <- length(which( apply(color_semaforo,1, function(x) x[i] == "r" & sum(x[1:(i-1)] == "g") == (i-1)) )) / T
   }
   output[n+1] <- length(which(rowSums(color_semaforo == "g") == n)) / T
   return(output)
  
  
}