
CREATE OR REPLACE PROCEDURE eureka.pr_resumen
AS
  v_cuentas NUMBER;
  v_saldo   NUMBER;
BEGIN

  SELECT count(1),  sum(dec_cuensaldo)
  INTO   v_cuentas, v_saldo 
  FROM   eureka.cuenta;
  
  dbms_output.PUT_LINE('CUENTAS: ' || v_cuentas);
  dbms_output.PUT_LINE('SALDO: ' || v_saldo);
  
END;
/

call EUREKA.PR_RESUMEN ();

BEGIN
  EUREKA.PR_RESUMEN ();
END;



/*
Tarea 2
Modificar el procedimiento eureka.pr_resumen
para que el resultado sea por moneda, sabiendo
que se tienen cuentas en SOLES y DOLARES solamente.
*/



