--TAREA3

CREATE OR REPLACE FUNCTION scott.fn101
( p_deptno dept.deptno%TYPE )
RETURN dept.DNAME%TYPE
IS
	v_dname dept.DNAME%TYPE;
BEGIN
	SELECT dname INTO v_dname 
	FROM scott.DEPT 
	WHERE	DEPTNO = p_deptno;
	RETURN(v_dname);
END;

--PROBAR 

SELECT SCOTT.FN101 (10) FROM DUAL;