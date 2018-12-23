
CREATE OR REPLACE PROCEDURE Findemp (cod emp.EMPNO%type)
IS 
	salario emp.sal%TYPE;
	
	BEGIN
	
	SELECT sal INTO Salario
	FROM emp 
	WHERE empno=cod;
	DBMS_OUTPUT.PUT_LINE ('Salario'  salario);
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE ('codigo no existe');

END;


BEGIN
	SCOTT.FINDEMP (7369);
END;
