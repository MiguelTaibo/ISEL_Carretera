#ifndef FSM_CRUCE_H
#define FSM_CRUCE_H
#endif


#include "fsm.h"
//#include <wiringPi.h>

enum tt_estado {GR, YR, RG, RY};

fsm_t* fsm_new_cruce (void);

//Funciones de comprobacion
static int comprobarTS(fsm_t* this);
static int comprobarT(fsm_t* this);

//Funciones de transicion
static void setYR(fsm_t* this);
static void setRG(fsm_t* this);
static void setRY(fsm_t* this);
static void setGR(fsm_t* this);

//ISR function
void secundaria_isr (void);
void timer_isr (void);

//Definicion de los tiempos en segundos
#define Long	10
#define Short	5


//Definicion de los pines GPIO
#define GPIO_SECUNDARIA 0
#define GPIO_Rp			1
#define GPIO_Yp			2
#define GPIO_Gp			3
#define GPIO_Rs 		4
#define GPIO_Ys			5
#define GPIO_Gs			6