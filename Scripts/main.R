###EL ARCHIVO DEBE UBICARSE EN LA CARPETA K-trafficblights ####

#Ingrese nombre del archivo
file_name <- "sample-1.in"
file_path <- dirname(rstudioapi::getSourceEditorContext()$path)
data_path <- paste0(substr(file_path,0,nchar(file_path)-7),"K-trafficblights/")
output_path <-  paste0(substr(file_path,0,nchar(file_path)-7),"output/")
source(paste0(file_path, "/Traffic Blights.R"))
