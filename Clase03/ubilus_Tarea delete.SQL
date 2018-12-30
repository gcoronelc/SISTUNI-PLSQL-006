
create or replace procedure SCOTT.pr112
(empno number) 
is
begin
  delete from SCOTT.emp 
  where empno = pr112.empno;
end;

SELECT * FROM SCOTT.EMP;

BEGIN
	SCOTT.PR112 (7369);
END;

SELECT * FROM SCOTT.EMP;

ROLLBACK;

