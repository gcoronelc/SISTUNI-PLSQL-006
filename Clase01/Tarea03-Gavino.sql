

CREATE OR REPLACE FUNCTION SCOTT.fn101
(p_deptno dept.deptno%type) RETURN dept.dname%type
IS
	v_dname dept.dname%type;
BEGIN
	SELECT dname INTO v_dname FROM SCOTT.dept WHERE deptno=p_deptno;
	RETURN (v_dname);

END;
/

SELECT SCOTT.fn101 (10) FROM DUAL;


SELECT * FROM MONEDA


BEGIN
	EUREKA.pr_resumen_moneda ();
END;


