
--TAREA 5

CREATE OR REPLACE PROCEDURE SCOTT.PR105( cod emp.EMPNO%TYPE)
IS
	type reg IS RECORD	(
	nombre emp.ENAME%TYPE,
	salario emp.SAL%TYPE);
	r reg;
BEGIN
	SELECT ename, sal INTO r 
	FROM EMP WHERE EMPNO = cod;
	dbms_output.put_line('Nombre : ' || r.nombre);
	dbms_output.put_line('Salario :' || r.salario);
END;

--PRUEBA 

BEGIN
	SCOTT.PR105 (7698);
END;