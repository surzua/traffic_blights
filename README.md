# traffic_blights
El objetivo es Resolver el problema K del concurso ICPC 2019, "Traffic Blights".
El problema consiste en una distribución de semáforos situado a lo largo de una calle, cada uno con distintos periodos de luces verde y rojo. Un automóvil comienza a recorrer desde el principio de la calle desde cualquier instante (la variable *tiempo de partido* distribuye uniforme). Se deben resolver dos tareas:
a) Determinar la probabilidad de que cada semáforo sea el primero con que el automóvil se topa con luz roja
b) Determinar la probabilidad de que el automóvil pase todos los semáforos con luz verde.

# Manual de Uso
Para ejecutar esta solución se requiere tener instalado R, junto con paquete "rstudioapi"
Este paquete se utiliza con el fin de que el script se pueda ejecutar en cualquier directorio, sólo es necesario situar la carpeta del proyecto en un directorio de la máquina y se puede compilar
Se debe situar el archivo input en la carpeta **K_trafficblights**. Luego de eso, copiar el nombre del archivo en la linea 4 del main (variable file_name). 
Finalmente, se compila *main.R*

# Bibliografía
La solución está inspirada en una metodología "Divide and conquer", basada en el "Sketch" de solución otorgado por la 2019 ICPC World Finals. 

# Archivo de salida
La salida se guarda en un output de nombre output-*nombredelarchivoinput*.txt con la estructura solicitada en la tarea.
