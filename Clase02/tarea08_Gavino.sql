

CREATE OR REPLACE procedure RECURSOS.UpdateSalEmp
( 
  P_Codigo RECURSOS.EMPLEADO.IDEMPLEADO%Type, 
  P_CARGO RECURSOS.EMPLEADO.IDCARGO%TYPE, 
  P_SUELDO NUMERIC 
)
is
  SUELDOMAXIMO Number;
  Cont NUMBER;
BEGIN

  Select Count(*) Into Cont
    From RECURSOS.EMPLEADO
    Where IDEMPLEADO = P_Codigo;
    
  If (Cont=0) Then
    Raise_application_error(-20001, 'No existe el empleado.');
  End If;
  
  	SELECT MAX(SUELDO) INTO SUELDOMAXIMO 
	FROM RECURSOS.EMPLEADO 
	WHERE IDCARGO=P_CARGO ;

  If (P_SUELDO > SUELDOMAXIMO) Then
    Raise_application_error(-20002, 'EL SUELDO SUPERA EL LIMITE');
  End If;
  
  Update RECURSOS.EMPLEADO
    Set SUELDO = P_SUELDO
  Where IDEMPLEADO = P_Codigo;
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
  RECURSOS.UPDATESALEMP ('E0001','C01', 2900);
END;

BEGIN
  RECURSOS.UPDATESALEMP ('E0001','C01', 290000);
END;