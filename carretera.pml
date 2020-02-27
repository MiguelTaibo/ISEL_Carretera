/**
 *	Archivo pml que modela y verifica el ejecicio
 *	propuesto en clase: carrtera principal y secundaria.
 *	
 *	Leyenda:
 *		R : red (rojo)
 *		Y : yellow (amarillo)
 *		G : green (verde)
 *		p : principal
 *		s : secundaria
 *
 *	Entradas:
 *		s : Sensor de la calle secundaria
 *		T : Temporizador
 *	Salidas:
 *		Rp, Yp, Gp : Color del semaforo de la calle principal
 *		Rs, Ys, Gs : Color del semaforo de la calle secundaria
 *		
**/

//Especificaciones
ltl llega_coche_secundaria {
	[](s -> <>Gs);
}
ltl no_llega_coche_secundaria {
	[](!s -> <>(Gp W s));
}
ltl uno_en_rojo {
	[](Rp || Rs);
}
ltl cambio_pasando_por_amarillo {
	[](!s || (<>(s && (!Rs U Ys))));
}
ltl prioridad_de_principal {
	[](Gs -> <>Gp);
}
ltl tiempo_minimo_principal {
	[](Gs -> (Gs U T));
}
ltl tiempo_minimo_secundario {
	[](Gp -> (Gp U T));
}

//Preparacion de timers
#define timer int 
#define set(tmr,val) tmr=val
#define expire(tmr) (tmr==0) /*timeout*/ 
#define tick(tmr) if :: tmr>=0 -> tmr=tmr-1 :: else fi 

#define delay(tmr,val) set(tmr,val); expire(tmr);

#define Short 3
#define Long 10

timer tmr1

active proctype Timers() { 
	do 
	:: timeout -> atomic { tick(tmr1) } 
	od
}


//Variables
mtype = {GR, YR, RG, RY}

#define GR 1
#define YR 2
#define RG 3
#define RY 4

mtype estado
int s;

int T;
int Rp, Yp, Gp;
int Rs, Ys, Gs;



// Modelado por medio de una FSM de 4 estados
active proctype fsm_carretera () {
	estado = GR
	T = 1;
	Rp = 0;
	Yp = 0;
	Gp = 1;
	Rs = 1;
	Ys = 0;
	Gs = 0;
	do
	::	estado == GR -> atomic {
		if
		::	(T && s) ->
			estado = YR;
			
			T=0;
			s = 0;

			Rp = 0;
			Yp = 1;
			Gp = 0;
			Rs = 1;
			Ys = 0;
			Gs = 0;
			
			set(tmr1,Short);
		fi;
	}
	::	estado == YR -> atomic {
		if
		::	T ->
			estado = RG;

			T = 0;

			Rp = 1;
			Yp = 0;
			Gp = 0;
			Rs = 0;
			Ys = 0;
			Gs = 1;
			//Yp = 0; // Semaforo principal
			//Rp = 1; // a rojo
			//Rs = 0; // Semaforo secundario
			//Gs = 1; // a verde
			set(tmr1,Long);
		fi;
	}
	::	estado == RG -> atomic {
		if
		:: T ->
			estado = RY;

			T = 0;

			Rp = 1;
			Yp = 0;
			Gp = 0;
			Rs = 0;
			Ys = 1;
			Gs = 0;
			//Ys = 1; // Semaforo secundario
			//Gs = 0; // a amarillo
			set(tmr1,Short)

		fi;
	}
	::	estado == RY -> atomic {
		if
		::	T ->
			estado = GR;

			T = 0;

			Rp = 0;
			Yp = 0;
			Gp = 1;
			Rs = 1;
			Ys = 0;
			Gs = 0;
			//Rp = 0; // Semaforo principal
			//Gp = 1; // a verde
			//Ys = 0; // Semaforo secundario
			//Rs = 1; // a rojo
			set(tmr1,1)
		fi;
	}
	od
}

active proctype entorno () {
	printf ("estado:%d, T:%d, S:%d, Sp:%d %d %d, Ss:%d %d %d \n", estado, T, s, Rp, Yp, Gp, Rs, Ys, Gs);
	do
	::	if
		:: s = 1
		:: expire(tmr1)-> T=1
		fi;
		printf ("estado:%d, T:%d, S:%d, Sp:%d %d %d, Ss:%d %d %d \n", estado, T, s, Rp, Yp, Gp, Rs, Ys, Gs);
	od
}


//run fsm_carretera();
