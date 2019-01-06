-- DISPARADOR DE SUSTITUCION

CREATE OR REPLACE VIEW SCOTT.V_EMPLEADOS 
AS 
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME 
FROM EMP E 
INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;


INSERT INTO SCOTT.V_EMPLEADOS
(EMPNO, ENAME)
VALUES(5544,'PEDRO');

INSERT INTO SCOTT.V_EMPLEADOS
VALUES(5544,'PEDRO',10,'ALGO');

ROLLBACK;

SELECT * FROM SCOTT.EMP;



CREATE OR REPLACE TRIGGER SCOTT.TR_VISTA
INSTEAD OF INSERT OR DELETE ON SCOTT.V_EMPLEADOS
FOR EACH ROW
DECLARE
  CUENTA NUMBER; 
BEGIN
  
  IF INSERTING THEN
  
    -- Si el departamento no existe, lo inserta
    SELECT COUNT(*) INTO CUENTA 
    FROM DEPT WHERE 
    DEPTNO = :NEW.DEPTNO;
    IF CUENTA = 0 THEN
      INSERT INTO DEPT(DEPTNO,DNAME) 
      VALUES(:NEW.DEPTNO, :NEW.DNAME);
    END IF;

    -- Si el empleado no existe, lo inserta
    SELECT COUNT(*) INTO CUENTA 
    FROM EMP 
    WHERE EMPNO = :NEW.EMPNO; 
    IF CUENTA = 0 THEN
      INSERT INTO EMP(EMPNO,ENAME,DEPTNO)
      VALUES(:NEW.EMPNO, :NEW.ENAME, :NEW.DEPTNO);
    END IF;
    
  ELSIF DELETING THEN
  
    DELETE FROM EMP 
    WHERE EMPNO = :OLD.EMPNO;
    
  END IF;

END TR_VISTA;


INSERT INTO SCOTT.V_EMPLEADOS
VALUES(5544,'PEDRO',50,'ALGO');

SELECT * FROM scott.DEPT;

SELECT * FROM SCOTT.EMP;


