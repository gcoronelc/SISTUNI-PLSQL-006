

-- TABLA ANIDADA


DECLARE

	TYPE nombres_t IS TABLE OF VARCHAR2(100);
	
	empleados   nombres_t := nombres_t ();
	en_oficinas nombres_t := nombres_t ();
	en_talleres nombres_t := nombres_t ();

BEGIN

	empleados.EXTEND (4);
	empleados (1) := 'Pepe';
	empleados (2) := 'Elena';
	empleados (3) := 'Carmen';
	empleados (4) := 'Juan';
	
	empleados.EXTEND;
	empleados (empleados.LAST) := 'Gustavo';

	en_oficinas.EXTEND;
	en_oficinas (en_oficinas.LAST) := 'Elena';
	en_oficinas.EXTEND;
	en_oficinas (en_oficinas.LAST) := 'Juan';

	en_talleres := empleados MULTISET EXCEPT en_oficinas;

	FOR l_row IN 1 .. en_talleres.COUNT
	LOOP
		DBMS_OUTPUT.put_line (en_talleres (l_row));
	END LOOP;
	
END;
/


