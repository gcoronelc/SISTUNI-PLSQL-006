CREATE OR REPLACE  PROCEDURE 	SCOTT.pr105 (cod emp.EMPNO%type)
IS
	 TYPE reg IS RECORD ( 
	 	nombre emp.ENAME%TYPE,
	 	salario emp.SAL%TYPE
	 	);
	 r reg;
BEGIN
	SELECT ename, sal INTO r
	FROM EMP WHERE EMPNO = cod;
	dbms_output.PUT_LINE('nombre:' || r.nombre);
	dbms_output.PUT_LINE('salario:' || r.salario);
END;
--prueba
SET SERVEROUTPUT ON
BEGIN 
 pr105(7698);
END;