#!bin/bash

spin -a carretera.pml
gcc -o pan pan.c
./pan -a -f -N $1
spin -t carretera.pml
