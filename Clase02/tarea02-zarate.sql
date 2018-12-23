--TAREA2

/*
Crear una funcion para encontrar la suma 
de los cuadrados de los "N" primeros numeros
enteros positivos
*/

CREATE OR REPLACE FUNCTION SCOTT.FN_SUMACUADRADOS
(P_NUM IN NUMBER) RETURN NUMBER
IS
	V_SUMA NUMBER :=0;
	V_NUM NUMBER :=P_NUM;
BEGIN
	
		V_SUMA := ((V_NUM*(V_NUM+1)*(2*V_NUM+1)))/6;
	RETURN V_SUMA;
END; 

SELECT FN_SUMACUADRADOS(4) FROM DUAL;