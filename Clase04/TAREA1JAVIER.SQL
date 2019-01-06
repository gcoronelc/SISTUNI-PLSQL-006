Create or Replace Trigger tr_UpdateEmpSal 
AFTER Update ON Emp
For Each Row Begin
IF(:New.Sal <>:Old.Sal) THEN
Insert Into Sal_History(EmpNo, SalOld, SalNew, StartDate, SetUser)
Values( :New.EmpNo, :Old.Sal, :New.Sal, sysdate, USER );
END IF;

End tr_UpdateEmpSal;


update emp
set sal = 1600
where empno = 7369;

SELECT * FROM SAL_HISTORY;