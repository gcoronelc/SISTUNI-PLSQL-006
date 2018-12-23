CREATE OR REPLACE FUNCTION SCOTT.FN_SUMA_CUADRADOSBUCLE
(P_NUMERO IN NUMBER) RETURN NUMBER
IS
   V_SUMA NUMBER:=0;
   V_NUMERO NUMBER :=P_NUMERO;
BEGIN
WHILE(V_NUMERO>0) LOOP
V_SUMA:=V_SUMA + V_NUMERO*V_NUMERO;
V_NUMERO:=V_NUMERO -1;
END LOOP;
RETURN V_SUMA;
END;


SELECT SCOTT.FN_SUMA_CUADRADOSBUCLE (3) FROM DUAL;