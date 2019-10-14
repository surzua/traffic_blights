####LCM Y GCD ####

lcm <- function(x) {
  # Funcion para encontrar el minimo comun multiplo de un vector de números
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
  # Funcion para encontrar el maximo comun divisor entre dos numeros
  while(y) {
    temp = y
    y = x %% y
    x = temp
  }
  return(x)
}


#### SEMAFORO ####
semaforo <- function(r,g,t){
  #Funcion que calcula el color de la luz de un semaforo en un determinado tiempo
  #Recibe como input la duracion, en segundos, que la luz esta de color roja (r), 
  #la duracion, en segundos, que la luz esta de color verde (g), 
  #y el tiempo en que el auto llega dicho semaforo (t)
  #Se puede evaluar en un vector de semaforos y un vector de tiempos de llegada para cada uno de estos.
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

#### TIEMPO DE ESPERA ####

t_espera <- function(r,g,t){
  #Funcion que calcula el tiempo de espera de un semafor si el auto llega en el tiempo t.
  #Recibe como input la duracion, en segundos, que la luz esta de color roja (r), 
  #la duracion, en segundos, que la luz esta de color verde (g), 
  #y el tiempo en que el auto llega dicho semaforo (t)
  #Se puede evaluar en un vector de semaforos y un vector de tiempos de llegada para cada uno de estos.
  p <- r+g
  output <- (t%%p < r)*(r-t%%p) + (t%%p >= r)*0
  return(output)
}

#### TIEMPO DE LLEGADA ####

t_llegada <- function(df,t_i){
  #Esta funcion calcula el tiempo en que el auto llega a cada uno de los semaforos
  #Recibe como parametros la distribucion de los semaforos y sus periodos (df)
  #Y el tiempo de partida del auto (t_i)
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


#### OUTPUT ####
output_final <- function(color_semaforo,T){
  #Calcula la probabilidad de que cada semaforo sea el primero en que el auto se tope con luz roja.
  #Este calculo lo realiza para todos los semaforos.
  #Ademas, calcula la probabilidad de que al auto le toquen todos los semaforos en verde.
  n <- ncol(color_semaforo)
  output <- numeric(n+1)
  output[1] <- length(which(( color_semaforo[,1] == "r"))) / T
  for (i in 2:n){
    output[i] <- length(which( apply(color_semaforo,1, function(x) x[i] == "r" & sum(x[1:(i-1)] == "g") == (i-1)) )) / T
  }
  output[n+1] <- length(which(rowSums(color_semaforo == "g") == n)) / T
  return(output)
}