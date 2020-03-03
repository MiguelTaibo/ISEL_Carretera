#include <stdlib.h>

#include "fsm_cruce.h"

int T = 0;
int S = 0;


fsm_t* fsm_new_cruce (void) 
{
	static fsm_trans_t tt[] = {
		{GR,	comprobarTS,	YR,	setYR},
		{YR,	comprobarT,		RG,	setRG},
		{RG,	comprobarT,		RY,	setRY},
		{RY,	comprobarT,		GR,	setGR},
		{-1,	NULL,			-1,	NULL},
	};
	return fsm_new(tt);
}

//Funciones de comprobacion
static int comprobarTS(fsm_t* this) {	return (T && S);}

static int comprobarT(fsm_t* this)	{	return T; 		}

//Funciones de transicion
static void setYR(fsm_t* this) 
{
	T = 0;
	S = 0;

	timer_start(Short);

	//digitalWrite(GPIO_Gp, LOW);
	//digitalWrite(GPIO_Yp, HIGH);	

	printf("Principal a amarillo\n");
}

static void setRG(fsm_t* this) 
{
	T = 0;

	timer_start(Long);

	//digitalWrite(GPIO_Yp, LOW);
	//digitalWrite(GPIO_Rp, HIGH);

	//digitalWrite(GPIO_Rs, LOW);
	//digitalWrite(GPIO_Gs, HIGH);

	printf("Principal a rojo y Secundario a verde\n");
}

static void setRY(fsm_t* this) 
{
	T = 0;

	timer_start(Short);

	//digitalWrite(GPIO_Gs, LOW);
	//digitalWrite(GPIO_Ys, HIGH);

	printf("Secundario a amarillo\n");
}

static void setGR(fsm_t* this) 
{
	T = 0;

	timer_start(Long);

	//digitalWrite(GPIO_Rp, LOW);
	//digitalWrite(GPIO_Gp, HIGH);

	//digitalWrite(GPIO_Ys, LOW);
	//digitalWrite(GPIO_Rs, HIGH);

	printf("Principal a verde y Secundario a rojo\n");
}

//ISR function
//static void secundaria_isr (union sigval arg) { S = 1; }
void secundaria_isr (void) { S = 1; return;}
void timer_isr (void) { T = 1; return;}
