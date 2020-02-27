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
ltl uno_rojo {
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

//Variables
mtype = {GR, YR, RG, RY};
int estado;
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

			T = 0;
			s = 0;
			
			Yp = 1; // Semaforo principal 
			Gp = 0; // a amarillo
		fi
	}
	::	estado == YR -> atomic {
		if
		::	(T) ->
			estado = RG;

			T = 0;

			Yp = 0; // Semaforo principal
			Rp = 1; // a rojo
			Rs = 0; // Semaforo secundario
			Gs = 1; // a verde
		fi
	}
	::	estado == RG -> atomic {
		if
		:: (T) ->
			estado = RY;

			T = 0;

			Ys = 1; // Semaforo secundario
			Gs = 0; // a amarillo

		fi
	}
	::	estado == RY -> atomic {
		if
		::	(T) ->
			estado = GR;

			T = 0;

			Rp = 0; // Semaforo principal
			Gp = 1; // a verde
			Ys = 0; // Semaforo secundario
			Rs = 1; // a rojo
		fi
	}
	od
}

//run fsm_carretera();
