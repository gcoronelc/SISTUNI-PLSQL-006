-- CASE

CREATE OR REPLACE FUNCTION SCOTT.FN_NUMERO
( P_NUMERO NUMBER ) RETURN VARCHAR2
IS
  V_NUMERO VARCHAR2(500); 
BEGIN
  CASE P_NUMERO
    WHEN 1 THEN
      V_NUMERO := 'UNO';
    WHEN 2 THEN
      V_NUMERO := 'DOS';
    WHEN 3 THEN 
      V_NUMERO := 'TRES';
    ELSE
      V_NUMERO := 'NO SE';
  END CASE;
  RETURN V_NUMERO;
END;
/

SELECT FN_NUMERO(3) FROM DUAL;


-- LOOP

CREATE OR REPLACE FUNCTION SCOTT.FN_SUMA_CUADRADOS
( P_NUM IN NUMBER ) RETURN NUMBER
IS
  V_SUMA NUMBER := 0;
  V_NUM  NUMBER := P_NUM;
BEGIN
  LOOP
    V_SUMA := V_SUMA + V_NUM * V_NUM;
    V_NUM := V_NUM -1;
    EXIT WHEN (V_NUM = 0);
  END LOOP;
  RETURN V_SUMA;
END;
/


SELECT SCOTT.FN_SUMA_CUADRADOS(4) FROM DUAL;


-- WHILE

-- TAREA 02
/*
Crear una funcion para encontrar la suma
de los cuadrados de los "N" primeros numeros
enteros positivos.
*/


-- for

BEGIN
  FOR n IN  1 .. 10 LOOP
    dbms_output.PUT_LINE(N || '.- FELIZ NAVIDAD CON ORACLE PL/SQL');
  END LOOP;
END;


-- TAREA 3 (FOR o WHILE)
/*
Desarrollar una funcion para encontrar el
MCD de dos números enteros.
*/


-- TAREA 4 (FOR)
/*
Desarrollar una funcion para encontrar el
factorial de un número entero positivo.
*/





