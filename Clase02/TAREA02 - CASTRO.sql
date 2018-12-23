CREATE OR REPLACE FUNCTION SCOTT.FN_SUMA_CUADRADOS_WHILE
( P_NUM NUMBER) RETURN NUMBER
IS
	V_SUMA NUMBER := 0;
	V_NUM NUMBER := P_NUM;
BEGIN
	WHILE (V_NUM > 0) LOOP
		V_SUMA := V_SUMA + V_NUM*V_NUM;
		V_NUM := V_NUM - 1;
	END LOOP;
	RETURN V_SUMA;
END;

SELECT FN_SUMA_CUADRADOS_WHILE(4) FROM DUAL;