
DROP TABLE SCOTT.ALGO;

BEGIN

  EXECUTE IMMEDIATE
  'CREATE TABLE SCOTT.ALGO( A VARCHAR2(20) )';
  
END;


----------------------------------------------------

SELECT * FROM SCOTT.EMP;

DECLARE
  V_SAL NUMBER;
BEGIN
  UPDATE SCOTT.EMP
  SET SAL = SAL * 1.1
  WHERE EMPNO = 7369
  RETURNING . INTO V_SAL;
  DBMS_OUTPUT.PUT_LINE('NUEVO SAL: ' || V_SAL );
END;  
  

------------------------------------------------------------------
/*
IP: 172.17.3.96
PUERTO: 1521
SERVICIO: ORCL
USUARIO: SYSTEM
CLAVE: oracle
*/

CREATE PUBLIC DATABASE LINK DB_REMOTO
CONNECT TO SYSTEM IDENTIFIED BY oracle
USING 'COCA';

SELECT * FROM scott.emp@DB_REMOTO;

SELECT * FROM scott.emp;

DROP PUBLIC DATABASE LINK "DB_REMOTO";

CREATE PUBLIC DATABASE LINK SCOTT.DB_REMOTO
CONNECT TO SYSTEM IDENTIFIED BY oracle
USING '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 172.17.3.96)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = ORCL)
    )
  )';

SELECT * FROM scott.emp@SCOTT.DB_REMOTO;



