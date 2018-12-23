-- REGISTROS

-- Excepciones

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
    DBMS_Output.Put_Line( 'Código: ' || sqlcode );
    DBMS_Output.Put_Line( 'Mensaje: ' || sqlerrm );
End;


--PRUEBA

BEGIN
  SCOTT.UPDATESALEMP (7698, 2900);
END;

BEGIN
  SCOTT.UPDATESALEMP (6666, 2900);
END;




-- raise_app_error

CREATE OR REPLACE procedure SCOTT.UpdateSalEmp
( Codigo Emp.EmpNo%Type, Salario Emp.Sal%Type )
is
  Cont Number;
Begin
  Select Count(*) Into Cont
    From Emp
    Where EmpNo = Codigo;
  If (Cont=0) Then
    Raise_application_error(-20001, 'No existe el empleado.');
  End If;
    Update Emp
    Set Sal = Salario
  Where EmpNo = Codigo;
  Commit;
  DBMS_Output.Put_Line( 'Proceso OK' );
Exception
  When others THEN
    ROLLBACK;
    DBMS_Output.Put_Line( 'Código no existe.' );
    DBMS_Output.Put_Line( 'Código: ' || sqlcode );
    DBMS_Output.Put_Line( 'Mensaje: ' || sqlerrm );
End;


--PRUEBA

BEGIN
  SCOTT.UPDATESALEMP (7698, 2900);
END;

BEGIN
  SCOTT.UPDATESALEMP (6666, 2900);
END;


----------------------------------------------------

CREATE OR REPLACE procedure SCOTT.UpdateSalEmp
( Codigo Emp.EmpNo%Type, Salario Emp.Sal%Type )
is
  Cont Number;
Begin
  Select Count(*) Into Cont
    From Emp
    Where EmpNo = Codigo;
  If (Cont=0) Then
    Raise_application_error(-20001, 'No existe el empleado.');
  End If;
    Update Emp
    Set Sal = Salario
  Where EmpNo = Codigo;
  Commit;
  DBMS_Output.Put_Line( 'Proceso OK' );
Exception
  When others THEN
    ROLLBACK;
    DBMS_Output.Put_Line( 'Código no existe.' );
    DBMS_Output.Put_Line( 'Código: ' || sqlcode );
    DBMS_Output.Put_Line( 'Mensaje: ' || sqlerrm );
    Raise_application_error(sqlcode, sqlerrm);    
End;


--PRUEBA

BEGIN
  SCOTT.UPDATESALEMP (7698, 2900);
END;

BEGIN
  SCOTT.UPDATESALEMP (6666, 2900);
END;


-- Manejar estados

CREATE OR REPLACE procedure SCOTT.UpdateSalEmp
( 
  Codigo    IN Emp.EmpNo%Type, 
  Salario   IN Emp.Sal%TYPE,
  p_estado  OUT NUMBER,
  p_mensaje OUT varchar2 
)
is
  Cont Number;
BEGIN
  Select Count(*) Into Cont
    From Emp
    Where EmpNo = Codigo;
  If (Cont=0) Then
    Raise_application_error(-20001, 'No existe el empleado.');
  End If;
    Update Emp
    Set Sal = Salario
  Where EmpNo = Codigo;
  Commit;
  p_estado  := 1;
  p_mensaje := 'Proceso OK';
Exception
  When others THEN
    ROLLBACK;
    p_estado  := -1;
    p_mensaje := SQLERRM; 
End;


--PRUEBA


BEGIN
  SCOTT.UPDATESALEMP (7698, 2900, :p_estado$NUMBER, :p_mensaje$VARCHAR2);
END;

BEGIN
  SCOTT.UPDATESALEMP (6666, 2900, :p_estado$NUMBER, :p_mensaje$VARCHAR2);
END;







