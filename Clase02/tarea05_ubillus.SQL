CREATE OR REPLACE PROCEDURE SCOTT.pr105 
(cod emp.EMPNO%type)
IS 
	TYPE reg IS RECORD 
	(
  	nombre emp.ename%TYPE,
  	salario emp.sal%TYPE
	);
	r reg;
BEGIN
	
	SELECT ename,SAL INTO r
	FROM emp WHERE empno=cod;
	DBMS_OUTPUT.PUT_LINE ('nombre:' || r.nombre);
	DBMS_OUTPUT.PUT_LINE ('Salario:' || r.salario);
END;
	
	
BEGIN
	SCOTT.PR105 (7369);
END;