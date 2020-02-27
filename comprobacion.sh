#!bin/bash

#
#	Script que muestra como se cumplen todas las especificaciones 
#	del ejercicio de las carreteras propuesto en clase de ISEL
#	2020 (cuando se cumplan)
#
#	author: Miguel taibo
#	date 27/02/2020
#

clear

spin -a carretera.pml
gcc -o pan pan.c

echo
echo

echo 'Comprobacion de la especificacion llega_coche_secundaria: G(s->F(Gs))'
./pan -a -f -N llega_coche_secundaria | grep errors
echo 'Comprobacion de la especificacion no_llega_coche_secundaria: G(!s->F(Gp W s))'
./pan -a -f -N no_llega_coche_secundaria | grep errors
echo 'Comprobacion de la especificacion uno_en_rojo: G(Rp || Rs)'
./pan -a -f -N uno_en_rojo | grep errors
echo 'Comprobacion de la especificacion cambio_pasando_por_amarillo: G(!s || F(s && (!Rs U Ys)))'
./pan -a -f -N cambio_pasando_por_amarillo | grep errors
echo 'Comprobacion de la especificacion no_llega_coche_secundaria: G(!s->F(Gp W s))'
./pan -a -f -N prioridad_de_principal | grep errors
echo 'Comprobacion de la especificacion tiempo_minimo_principal: G(Gs -> (Gs U T))'
./pan -a -f -N tiempo_minimo_principal | grep errors
echo 'Comprobacion de la especificacion tiempo_minimo_secundario: G(Gp -> (Gp U T))'
./pan -a -f -N tiempo_minimo_secundario | grep errors
