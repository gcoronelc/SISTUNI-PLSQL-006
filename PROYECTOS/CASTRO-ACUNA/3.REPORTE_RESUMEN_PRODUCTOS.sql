CREATE OR REPLACE PROCEDURE sp_reporte_prod_mes(
  k_fecha_inicio VARCHAR2,
  k_fecha_fin VARCHAR2
)
 AS 
  TYPE v_prod IS RECORD(
    v_codprod PRODUCTO.CODPROD%TYPE,
    v_descripcion PRODUCTO.NOMBRE%TYPE,
    v_cantidad NUMBER 
  
  );
  
  dato_producto v_prod;
  
  CURSOR cursor_menos  IS
       SELECT tb_menos_vendidos.*
     	 	FROM(
				  SELECT dv.codprod ,p.nombre,SUM(dv.cantidad)
				  
				  FROM ((detalle_venta dv INNER JOIN  venta v ON dv.codven=v.codven)
				       INNER JOIN producto p ON p.codprod=dv.codprod)
				  WHERE  TO_DATE(v.fecha) BETWEEN TO_DATE(k_fecha_inicio,'DD/MM/YYYY') AND TO_DATE(k_fecha_fin,'DD/MM/YYYY')
				  GROUP BY(dv.codprod,p.precio,p.nombre)
				  ORDER BY SUM(dv.cantidad) ASC ) 
				  tb_menos_vendidos
	  
	  		WHERE ROWNUM <= 10;
  
 
  CURSOR cursor_mas IS
        SELECT tb_mas_vendidos.*
      		FROM(
					  SELECT dv.codprod ,p.nombre,SUM(dv.cantidad) 
					  
					  FROM ((detalle_venta dv INNER JOIN  venta v ON dv.codven=v.codven)
					       INNER JOIN producto p ON p.codprod=dv.codprod)
					  WHERE  TO_DATE(v.fecha) BETWEEN TO_DATE(k_fecha_inicio,'DD/MM/YYYY') AND TO_DATE(k_fecha_fin,'DD/MM/YYYY')
					  GROUP BY(dv.codprod,p.precio,p.nombre)
					  ORDER BY SUM(dv.cantidad) DESC ) 
					  tb_mas_vendidos
			  
			 WHERE ROWNUM <= 10;
	  
   CURSOR cursor_bajo IS
        SELECT tb_bajo_stock.*
		         FROM(
						  SELECT p.CODPROD ,p.NOMBRE ,p.STOCK
						  FROM PRODUCTO p
						  WHERE p.STOCK <= 20) 
						  tb_bajo_stock
					 
		       WHERE ROWNUM <= 10;           
  
 BEGIN 
         
      IF(   LENGTH(TRIM(k_fecha_inicio)) is null  OR LENGTH(TRIM(k_fecha_fin)) is null OR k_fecha_inicio is NULL OR k_fecha_fin IS NULL ) 
      THEN
         RAISE_APPLICATION_ERROR(-20010,'NO PUEDE SER VACIO LA CADENA DE FECHA');
      END IF;
      
      DBMS_OUTPUT.PUT_LINE(RPAD('REPORTE PRODUCTOS',100));
      DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------');
      DBMS_OUTPUT.PUT_LINE(RPAD('PRODUCTOS MENOS VENDIDOS',90));
      OPEN cursor_menos;
      FETCH cursor_menos INTO dato_producto;
          DBMS_OUTPUT.PUT_LINE(RPAD('CODIGO ',50)|| RPAD('NOMBRE',45)||RPAD( 'CANTIDAD VENDIDA',50));
	      WHILE cursor_menos%FOUND LOOP
	        DBMS_OUTPUT.PUT_LINE(RPAD(dato_producto.v_codprod,50)||RPAD(dato_producto.v_descripcion,45) || RPAD(dato_producto.v_cantidad,50));
	          FETCH cursor_menos INTO dato_producto;
	      END lOOP;
            
      CLOSE cursor_menos;
      -------
      DBMS_OUTPUT.PUT_LINE('------------------------------------');
      DBMS_OUTPUT.PUT_LINE(RPAD('PRODUCTOS MAS  VENDIDOS',90));
      OPEN cursor_mas;
      FETCH cursor_mas INTO dato_producto;
      DBMS_OUTPUT.PUT_LINE(RPAD('CODIGO ',50)|| RPAD('NOMBRE',45)||RPAD( 'CANTIDAD VENDIDA',50));
	      WHILE cursor_mas%FOUND LOOP
	          DBMS_OUTPUT.PUT_LINE(RPAD(dato_producto.v_codprod,50)||RPAD(dato_producto.v_descripcion,45) || RPAD(dato_producto.v_cantidad,50));
	          FETCH cursor_mas INTO dato_producto;
	      END lOOP;
            
      CLOSE cursor_mas;
      --------
      DBMS_OUTPUT.PUT_LINE('-----------------------------------');
      DBMS_OUTPUT.PUT_LINE(RPAD('PRODUCTOS BAJO STOCK',90));
      OPEN cursor_bajo;
      FETCH cursor_bajo INTO dato_producto;
          DBMS_OUTPUT.PUT_LINE(RPAD('CODIGO ',50)|| RPAD('NOMBRE',45)||RPAD( 'STOCK',50));
	      WHILE cursor_bajo%FOUND LOOP
	         DBMS_OUTPUT.PUT_LINE(RPAD(dato_producto.v_codprod,50)||RPAD(dato_producto.v_descripcion,45) || RPAD(dato_producto.v_cantidad,50));
	         FETCH cursor_bajo INTO dato_producto;
	      END lOOP;
            
      CLOSE cursor_bajo;
      
      EXCEPTION 
      		   
      WHEN OTHERS THEN	
           DBMS_OUTPUT.PUT_LINE('OCURRIO UN ERROR EN EL REPORTE');
		   DBMS_OUTPUT.PUT_LINE('CODIGO DE ERROR : '|| to_char(SQLCODE));
		   DBMS_OUTPUT.PUT_LINE('MENSAJE DE ERROR : '|| SQLERRM);
    
 END;
 
 
BEGIN
	VENTASPLSQL.SP_REPORTE_PROD_MES ('01/01/2016', '06/01/2019');
END;
