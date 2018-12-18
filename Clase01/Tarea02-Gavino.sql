--Saliendo que se tiene cuentas en soles y en dolares solamente




CREATE OR REPLACE PROCEDURE eureka.pr_resumen_moneda
AS
	v_cuentas NUMBER;
	v_saldo NUMBER;
BEGIN
	SELECT sum(1),sum(dec_cuensaldo)
	INTO v_cuentas, v_saldo
	FROM eureka.cuenta a
	INNER JOIN eureka.MONEDA b ON a.CHR_MONECODIGO=b.CHR_MONECODIGO
	WHERE a.CHR_MONECODIGO='01';
	dbms_output.put_line('CUENTAS SOLES');
	dbms_output.put_line('CUENTAS: ' || v_cuentas);
	dbms_output.put_line('SALDO: ' || v_saldo);
	
	SELECT sum(1),sum(dec_cuensaldo)
	INTO v_cuentas, v_saldo
	FROM eureka.cuenta a
	INNER JOIN eureka.MONEDA b ON a.CHR_MONECODIGO=b.CHR_MONECODIGO
	WHERE a.CHR_MONECODIGO='02';
	dbms_output.put_line('CUENTAS DOLARES');
	dbms_output.put_line('CUENTAS: ' || v_cuentas);
	dbms_output.put_line('SALDO: ' || v_saldo);

END;
/


SELECT * FROM MONEDA


BEGIN
	EUREKA.pr_resumen_moneda ();
END;


