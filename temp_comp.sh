#!bin/bash

spin -a carretera.pml
gcc -o pan pan.c
./pan -a -f -N no_llega_coche_secundaria
spin -t carretera.pml