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
	[](s -> <>Gs)
}
ltl no_llega_coche_secundaria {
	[](!s -> <>(Gp W s))
}
ltl uno_rojo {
	[](Rp || Rg)
}
ltl cambio_pasando_por_amarillo {
	[](!s || (<>(s && (!Rs U Ys))))
}
ltl prioridad_de_principal {
	[](Gs -> <>Gp)
}
ltl tiempo_minimo_principal {
	[](Gs -> (Gs U T))
}
ltl tiempo_minimo_secundario {
	[](Gp -> (Gp U T))
}

//Variables
mtype = {GR, YR, RG, RY};
int estado;
int s;
int T;
int Rp;
int Yp;
int Gp;
