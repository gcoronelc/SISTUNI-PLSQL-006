CREATE OR REPLACE PROCEDURE SCOTT.FINDEMP(COD EMP.EMPNO%TYPE)
IS
	SALARIO EMP.SAL%TYPE;
BEGIN
	SELECT SAL INTO SALARIO
	FROM SCOTT.EMP WHERE EMPNO = COD;
	
	DBMS_OUTPUT.PUT_LINE('Salario: '|| SALARIO );

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Código no existe');
END;
/
EXECUTE  SCOTT.FINDEMP(736900);
