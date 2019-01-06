
CREATE OR REPLACE PROCEDURE sp_reporte_ventas_cliente(
  k_codcli IN cliente.CODCLI%TYPE,
  k_fecha_inicio IN VARCHAR2,
  k_fecha_fin IN VARCHAR2
)

AS
     TYPE reporte IS RECORD(
     v_codven VENTA.CODVEN%TYPE,
     v_coddetven DETALLE_VENTA.CODDETVEN%TYPE,
     v_nombre PRODUCTO.NOMBRE%TYPE,
     v_cantidad DETALLE_VENTA.CANTIDAD%TYPE,
     v_precio DETALLE_VENTA.PRECIO%TYPE,
     v_subtotal DETALLE_VENTA.SUBTOTAL%TYPE,
     v_total VENTA.TOTAL%TYPE,
	 v_unidad UNIDAD.NOMBRE%TYPE 
     );
     
     v_venta VENTA%ROWTYPE;
     v_fila_reporte reporte;
     
     CURSOR cursor_ventas IS 
 	   SELECT  v.*
 	   FROM VENTA v
 	   WHERE v.CODCLI = k_codcli  AND v.FECHA BETWEEN TO_DATE(k_fecha_inicio,'DD/MM/YYYY') AND TO_DATE(k_fecha_fin,'DD/MM/YYYY') ;
     
     CURSOR cursor_detalle_ventas IS 
     SELECT v.CODVEN,dv.CODDETVEN ,p.NOMBRE ,dv.CANTIDAD,dv.PRECIO,dv.SUBTOTAL,v.TOTAL,u.nombre
	 	       FROM DETALLE_VENTA dv INNER JOIN PRODUCTO p 
	 	                   ON dv.CODPROD = p.CODPROD
			   INNER JOIN UNIDAD u ON u.coduni = p.coduni
	 	       INNER JOIN VENTA v ON dv.CODVEN = v.CODVEN 
	 	                   AND v.CODVEN = v_venta.CODVEN 
	 	                   AND TO_DATE(v.FECHA) BETWEEN TO_DATE(k_fecha_inicio,'DD/MM/YYYY') AND TO_DATE(k_fecha_fin,'DD/MM/YYYY')
	 	                   AND v.CODCLI = k_codcli
	 	       ORDER BY dv.CODDETVEN,p.NOMBRE;

BEGIN
      IF( LENGTH(TRIM(k_codcli)) is null   OR k_codcli IS NULL ) 
      THEN
         RAISE_APPLICATION_ERROR(-20011,'CODIGO DE CLIENTE VACIO');
         DBMS_OUTPUT.PUT_LINE(LENGTH(TRIM(k_codcli)));
      END IF;
      
       IF(   LENGTH(TRIM(k_fecha_inicio)) is null  OR LENGTH(TRIM(k_fecha_fin)) is null OR k_fecha_inicio is NULL OR k_fecha_fin IS NULL ) 
      THEN
         RAISE_APPLICATION_ERROR(-20010,'NO PUEDE SER VACIO LA CADENA DE FECHA');
      END IF; 
	  
       OPEN cursor_ventas;
             
 	    LOOP FETCH  cursor_ventas INTO v_venta;
 	     EXIT WHEN cursor_ventas%NOTFOUND; 
 	           
 	        DBMS_OUTPUT.PUT_LINE('************************************************************');
 	        DBMS_OUTPUT.PUT_LINE('*           CODIGO VENTA:       ' || v_venta.codven || '   *');
 	        DBMS_OUTPUT.PUT_LINE('************************************************************');
 	        DBMS_OUTPUT.PUT_LINE('                                                            ');
 	        DBMS_OUTPUT.PUT_LINE(rpad('COD_DETALLE_VENTA',40)||RPAD('NOMBRE_PROD',40)||RPAD('CANTIDAD',40)|| RPAD('UNIDAD',40)||RPAD('PRECIO',40)||RPAD('SUBTOTAL',40));
 	       OPEN cursor_detalle_ventas;
	 	             
	 	       LOOP FETCH cursor_detalle_ventas INTO v_fila_reporte;
	 	       EXIT WHEN cursor_detalle_ventas%NOTFOUND;
	 	          IF (v_fila_reporte.v_codven !=  v_venta.codven) THEN
	 	              EXIT; 
	 	          ELSE  
	 	          DBMS_OUTPUT.PUT_LINE(RPAD(v_fila_reporte.v_coddetven,40)||RPAD(v_fila_reporte.v_nombre,40)|| RPAD( v_fila_reporte.v_cantidad,40) ||RPAD(v_fila_reporte.v_unidad,40)||RPAD( v_fila_reporte.v_precio,40)||RPAD( TO_CHAR(v_fila_reporte.v_subtotal,'000.00'),40));	
	 	          END IF;            	          
 	           END LOOP;
 	          
 	       DBMS_OUTPUT.PUT_LINE('===> TOTAL VENTA: '||LPAD(TO_CHAR(v_fila_reporte.v_total,'000.00'),20));
 	       CLOSE cursor_detalle_ventas;     
 	    END LOOP;
 	    
 	   
 	   CLOSE cursor_ventas;
 	   EXCEPTION WHEN OTHERS THEN
 	       DBMS_OUTPUT.PUT_LINE('OCURRIO UN ERROR EN EL REPORTE');
 	       DBMS_OUTPUT.PUT_LINE('CODIGO ERROR:' || TO_CHAR(SQLCODE));
 	       DBMS_OUTPUT.PUT_LINE('MENSAJE ERROR:' || SQLERRM);
 	       DBMS_OUTPUT.PUT_LINE('LINEA ERROR:' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
 	       
 	       
 	    
 	   CLOSE cursor_ventas;
END;


BEGIN
	VENTASPLSQL.SP_REPORTE_VENTAS_CLIENTE ('48283249', '01/01/2016', '06/01/2019');
END;


