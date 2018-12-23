--TAREA7
--PROCEDURE

CREATE OR REPLACE procedure SCOTT.UpdateSalEmp
( Codigo Emp.EmpNo%Type, Salario Emp.Sal%Type )
is
	Cont Number;
Begin
	Select Count(*) Into Cont
		From Emp
		Where EmpNo = Codigo;
	If (Cont=0) Then
		Raise No_Data_Found;
	End If;
		Update Emp
		Set Sal = Salario
	Where EmpNo = Codigo;
	Commit;
	DBMS_Output.Put_Line( 'Proceso OK' );
Exception
	When No_Data_Found THEN
		ROLLBACK;
		DBMS_Output.Put_Line( 'Código no existe.' );
End;


--PRUEBA

BEGIN
	SCOTT.UPDATESALEMP (7698, 2900);
END;

BEGIN
  SCOTT.UPDATESALEMP (6666, 2900);
END;
