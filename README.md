# ISEL_Carretera
Implementación y verificación del ejercicio de modelado de carretera en ISEL 2020. En este ejercicio hay una calle principal de gran afluencia y una secundaria de poca afluencia, ambas con un semáforo. Si llega un coche por la secundaria (visto por un sensor S) hay que dejarle pasar eventualmente, pero si no llega ninguno el semáforo dejará pasar siempre a los coches de la calle principal. Ambos semáforos, si están en verde, deben pasar por amarillo antes de ponerse en rojo y deben permanecer en verde un tiempo mínimo (marcado por un temporizador T). También hay que asegurar que los coches de la calle principal puedan pasar eventualmente.

## Verificacion

Se ha usado spin para realizar la verificación del modelo tras la especificación y modelado que desarrollamos en la sesión del 27/02/2020.

### Modo de uso

Primero tendremos que instalar spin:

```
sudo apt-get install spin
```

Para comprobar la verificación del modelo tenemos que ejecutar:
```
bash comprobacion.sh
```

Para comprobar una especificación en especial ejecutaremos:
```
bash temp_comp.sh <nombre_de_especificacion>
```
Si no se quieren usar estos scripts, la secuencia de comandos que se deben ejecutar para comprobar una propiedad es:
```
spin -a carretera.pml
gcc -o pan pan.c
./pan -a -f -N <nombre_de_propiedad>
spin -t carretera.pml
```

## Implementación

Se ha usado C orientado a objetos para realizar la implementación. Los archivos fsm_cruce.* implementan la máquina de estados. Los archivos timer.* manejan los tiempos y las esperas del sistema. El archivo main.c inicializa y mantiene ejecutándose el sistema que se compone de la máquina de estamos antes mencionada y de una thread de lectura de teclado que provisionalmente emula el entorno: si llega un coche por la calle secundaria.

### Modo de uso

Primero debemos compilar todos los archivos *.c que usamos y después ejecutar el fichero obtenido de dicha compilación. Al menos por el momento la única opción necesaria es _-phthread_ que sirve para que el compilador encuentre la librería _<pthread.h>_

```
gcc fsm_cruce.c fsm.c main.c timer.c -o main -pthread
./main
```

Una vez hecho esto los controles son muy faciles:
  - Si pulsas 's' simulas que llega un coche.
  - Si pulsas 'q' sales de la ejecución.
  - Si pulsas cualquier otra tecla se escriben dos lineas con la información anterior.

Se sabe que la máquina de estados funciona correctamente porque al cambiar de color los semáforos se informa vía consola de ello. En el futuro habría que integrar WiringPi en el código, eliminando tanto las impresiones por pantalla como la lectura de teclado.
