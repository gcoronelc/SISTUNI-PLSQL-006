--TAREA 6
--PROCEDURE 

CREATE OR REPLACE PROCEDURE SCOTT.FINDEMP (COD EMP.EMPNO%TYPE)
IS
  SALARIO EMP.SAL%TYPE;
BEGIN
  SELECT SAL INTO SALARIO
    FROM SCOTT.EMP
    WHERE EMPNO = COD;
  DBMS_OUTPUT.PUT_LINE ('SALARIO: ' || SALARIO );
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE ('CODIGO NO EXISTE');
END;

--PRUEBA
    
CALL SCOTT.FINDEMP(7698)
