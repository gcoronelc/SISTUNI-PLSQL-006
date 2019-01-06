
DECLARE

	-- Definimos el arreglo
	TYPE AlumnosArray IS VARRAY(5) OF VARCHAR2(100);
	TYPE NotasArray IS VARRAY(5) OF NUMBER(4);
	
	-- Utilizar el arreglo
	alumnos AlumnosArray;
	notas   NotasArray;
	
BEGIN

	alumnos := AlumnosArray('Gustavo','Lucero','Ricardo','Andrea','Laura');
	notas := NotasArray(20,18,16,10,15);
	
	dbms_output.PUT_LINE( alumnos(1) || ' - ' || notas(1) );
	
	
	dbms_output.PUT_LINE( '-----------------------------');
	FOR i IN 1 .. alumnos.count LOOP
		dbms_output.PUT_LINE( alumnos(i) || ' - ' || notas(i) );
	END LOOP;
	
	
END;


