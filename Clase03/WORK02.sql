
-- Ejemplo 01

DECLARE
  CURSOR c_demo
    IS SELECT * FROM scott.emp;
  r_emp scott.emp%ROWTYPE;
BEGIN
  OPEN  c_demo;
  FETCH c_demo INTO r_emp;
  CLOSE c_demo;
  dbms_output.PUT_LINE('CODIGO: ' || r_emp.empno);
  dbms_output.PUT_LINE('NOMBRE: ' || r_emp.ename);
END;
/

-- Ejemplo 02

DECLARE
  CURSOR c_demo IS SELECT * FROM scott.emp;
  r_emp    scott.emp%ROWTYPE;
  v_fila   NUMBER;
  v_cadena VARCHAR2(1000);
BEGIN
  OPEN  c_demo;
  LOOP
    FETCH c_demo INTO r_emp;
    EXIT WHEN c_demo%NOTFOUND;
    v_fila := c_demo%ROWCOUNT;
    v_cadena := v_fila || ' - ' || r_emp.empno || ' - ' || r_emp.ename;
    dbms_output.PUT_LINE(v_cadena);
  END LOOP;
  CLOSE c_demo;
END;
/


---------------------------------------------------------
-- Ejemplo 03

CREATE OR REPLACE PROCEDURE scott.sp_get_empleados
(p_cursor OUT SYS_REFCURSOR)
IS
BEGIN
  OPEN p_cursor FOR
   SELECT * FROM scott.emp;
END;
/


declare
  v_cursor SYS_REFCURSOR;
  r_emp    SCOTT.emp%RowType;
  v_fila   NUMBER;
  v_cadena VARCHAR2(1000);
begin
  scott.sp_get_empleados( v_cursor );
  LOOP
    FETCH v_cursor INTO r_emp;
    EXIT WHEN v_cursor%NOTFOUND;
    v_fila := v_cursor%ROWCOUNT;
    v_cadena := v_fila || ' - ' || r_emp.empno || ' - ' || r_emp.ename;
    dbms_output.PUT_LINE(v_cadena);
  END LOOP;
  close v_cursor;
end;
/


BEGIN
  SCOTT.SP_GET_EMPLEADOS (:p_cursor$REFCURSOR);
END;



-- Ejemplo 04

SELECT * FROM scott.dept;

DECLARE
  CURSOR c_demo IS SELECT * FROM scott.emp;
  v_fila   NUMBER;
  v_cadena VARCHAR2(1000);
BEGIN
  FOR r_emp IN c_demo
  LOOP
    v_fila := c_demo%ROWCOUNT;
    v_cadena := v_fila || ' - ' || r_emp.empno || ' - ' || r_emp.ename;
    dbms_output.PUT_LINE(v_cadena);
  END LOOP;
END;
/



-- Ejemplo 05

SELECT * FROM scott.dept;

DECLARE
  v_fila   NUMBER := 0;
  v_cadena VARCHAR2(1000);
BEGIN
  FOR r_emp IN (SELECT * FROM scott.emp)
  LOOP
    v_fila := v_fila + 1;
    v_cadena := v_fila || ' - ' || r_emp.empno || ' - ' || r_emp.ename;
    dbms_output.PUT_LINE(v_cadena);
  END LOOP;
END;
/


-- Ejemplo 06

SELECT * FROM scott.emp;

BEGIN
  UPDATE scott.emp
  SET SAL = SAL + 100
  WHERE EMPNO = 7369;
  IF SQL%NOTFOUND THEN
    dbms_output.PUT_LINE('no existe');
  ELSE
    dbms_output.PUT_LINE('ok');
  END IF;
END;
/

ROLLBACK;





