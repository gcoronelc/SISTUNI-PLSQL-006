CREATE OR REPLACE PROCEDURE eureka.pr_resumen_moneda
AS
	v_cuentas NUMBER;
	v_saldo NUMBER;
BEGIN

-- SOLES
	SELECT sum(1),sum(dec_cuensaldo)
	INTO v_cuentas, v_saldo
	FROM eureka.cuenta a
	INNER JOIN eureka.MONEDA b ON a.CHR_MONECODIGO=b.CHR_MONECODIGO
	WHERE a.CHR_MONECODIGO='01';
	dbms_output.put_line('MONEDA SOLES');
	dbms_output.put_line('CUENTAS: ' || v_cuentas);
	dbms_output.put_line('SALDO: ' || v_saldo);

--DOLARES

	SELECT sum(1),sum(dec_cuensaldo)
	INTO v_cuentas, v_saldo
	FROM eureka.cuenta a
	INNER JOIN eureka.MONEDA b ON a.CHR_MONECODIGO=b.CHR_MONECODIGO
	WHERE a.CHR_MONECODIGO='02';
	dbms_output.put_line('MONEDA DOLARES');
	dbms_output.put_line('CUENTAS: ' || v_cuentas);
	dbms_output.put_line('SALDO: ' || v_saldo);

END;
/

--PROBAR

BEGIN
	EUREKA.PR_RESUMEN_MONEDA ();
END;