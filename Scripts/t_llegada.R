t_llegada <- function(df,t_i){
  n <- nrow(df)
  output <- 0
  p<-0
  for (i in 1:n){
    if(i!=1){
      output[i] <- p  + output[i-1] + df$x[i] - df$x[i-1]
      p <- t_espera(df$r[i],df$g[i],p  + df$x[i] - df$x[i-1] + output[i-1])
    }
    else{
      output[i] <- df$x[i] + t_i
      p <- t_espera(df$r[i],df$g[i],t_i + df$x[i])
    }
  }
  return(output)
}

