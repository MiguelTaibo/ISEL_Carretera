//#include <wiringPi.h>
#include <time.h>
#include <stdio.h>
#include <pthread.h>
#include <time.h>
//#include <conio.h>

#include "fsm_cruce.h"

void *checkInputsThread (void *arg)
{

	char *tmpStr = (char *) arg;
	// Codigo de la funcion

	char ss;
	//struct timespec segundo = {0,0};

	while (scanf("%c",&ss)) {
		if (ss=='s') {
			secundaria_isr();
		}	else if (ss=='q') {
			exit(-1);
		}	else if (ss=='\n'){
			continue;
		}	else {
			printf("Pulsa 's' para simular que llega un coche. \n Pulsa 'q' para salir\n");
		}
		//nanosleep(&segundo,&segundo);
	}
	pthread_exit(NULL);
}

/*void configurar ()
{
	wiringPiSetup();
	//Input PIN
	pinMode(GPIO_SECUNDARIA, INPUT);
	wiringPiISR (GPIO_SECUNDARIA, INT_EDGE_FALLING, secundaria_isr);
	//Output PINs
	pinMode(GPIO_Rp, OUTPUT);
	pinMode(GPIO_Yp, OUTPUT);
	pinMode(GPIO_Gp, OUTPUT);
	pinMode(GPIO_Rs, OUTPUT);
	pinMode(GPIO_Ys, OUTPUT);
	pinMode(GPIO_Gs, OUTPUT);
}
*/
int main() {

	/*	Inicio de la thread que creara el entorno:
			-LLama a la funcion secundaria_isr cuando se pulsa cualquier tecla
			-LLama a la funcion timer_isr cuando el temporizador ha acabado
	*/
	pthread_t thInputs;
	if ( 0 != pthread_create(&thInputs, NULL, checkInputsThread, NULL) ) {
		printf("no empezamos thread\n");
	}


	//Clock registers
	struct timespec next;
	clock_gettime(CLOCK_REALTIME, &next);
	struct timespec T = {0, 500000000}; //medio segundo

	//Finite State Machine
	fsm_t* fsm_cruce = fsm_new_cruce();

	while(1) {
		fsm_fire(fsm_cruce);
		timespec_add(&next,&next,&T);
		delay_until(&next);

		if (timer_finished()) {
			timer_isr();
		}
	}
}
