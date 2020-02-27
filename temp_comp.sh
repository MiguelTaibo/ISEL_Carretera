#!bin/bash

spin -a carretera.pml
gcc -o pan pan.c
./pan -a -f -N cambio_pasando_por_amarillo
spin -t carretera.pml