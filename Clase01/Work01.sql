-- BLOQUE ANONIMO

DECLARE
  v_profe varchar2(100) := 'Gustavo Goronel';
BEGIN
  DBMS_OUTPUT.PUT_LINE('HOLA TODOS');
  DBMS_OUTPUT.PUT_LINE('BIENVENIDOS AL MEJOR CENTRO DE CAPACITACION');
  DBMS_OUTPUT.PUT_LINE(v_profe);
END;
/


-- FUNCION

CREATE OR REPLACE FUNCTION SCOTT.FN_SUMA
(  P_N1 NUMBER, P_N2 NUMBER ) RETURN NUMBER
IS
  V_SUMA NUMBER;
BEGIN
  V_SUMA := P_N1 + P_N2;
  RETURN V_SUMA;
END;
/



SELECT SCOTT.FN_SUMA (76, 45) FROM DUAL;




-- PROCEDIMIENTO

CREATE OR REPLACE PROCEDURE SCOTT.PR_SUMA
(  P_N1 NUMBER, P_N2 NUMBER )
IS
  V_SUMA NUMBER;
BEGIN
  V_SUMA := P_N1 + P_N2;
  DBMS_OUTPUT.PUT_LINE('SUMA: ' || V_SUMA);
END;
/


BEGIN
  SCOTT.PR_SUMA (87, 54);
END;


/*
Tarea 1
Hacer una funci�n que calcule el
promedio de de 4 notas.
*/









  









