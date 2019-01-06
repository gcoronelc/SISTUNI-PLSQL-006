/* PROCESO PARA ACTUALIZAR DESCEUNTO A PRODUCTOS MENOS VENDIDOS DEL MES ANTERIOR*/
CREATE OR REPLACE PROCEDURE sp_asignar_descuento_producto(
  k_descuento IN NUMBER,
  k_fecha_inicio VARCHAR2,
  k_fecha_fin VARCHAR2
)
IS

  TYPE registro IS RECORD(
     v_codigo producto.codprod%TYPE,
     v_nombre producto.nombre%TYPE,
     v_precio producto.precio%TYPE,
     v_cantidad NUMBER
  );
  
  v_mes_actual VARCHAR2(2);
  v_ano NUMBER;
  registro_unidad registro;
  v_nuevo_precio NUMBER(9,2):= 0.0;
  
  
  CURSOR cursor_productos IS 
  SELECT r.*
      FROM(
			  SELECT dv.codprod ,p.nombre,p.precio, SUM(dv.cantidad)
			  
			  FROM ((detalle_venta dv INNER JOIN  venta v ON dv.codven=v.codven)
			       INNER JOIN producto p ON p.codprod=dv.codprod)
			  WHERE  TO_DATE(v.fecha) BETWEEN TO_DATE(k_fecha_inicio,'DD/MM/YYYY') AND TO_DATE(k_fecha_fin,'DD/MM/YYYY')
			  GROUP BY(dv.codprod,p.precio,p.nombre)
			  ORDER BY SUM(dv.cantidad) ASC ) 
			  r
	  
	  WHERE ROWNUM <= 3;
	    
BEGIN 
  
   IF( k_descuento IS null ) 
      THEN
         RAISE_APPLICATION_ERROR(-20010,'EL DESCUENTO ES NULLO');
      END IF;
	  
    IF(   LENGTH(TRIM(k_fecha_inicio)) is null  OR LENGTH(TRIM(k_fecha_fin)) is null OR k_fecha_inicio is NULL OR k_fecha_fin IS NULL ) 
      THEN
         RAISE_APPLICATION_ERROR(-20011,'NO PUEDE SER VACIO LA CADENA DE FECHA');
      END IF;
   -- APLICAR DESCUENTO  
  --- MOSTRAR NUEVOS DESCUENTOS
  DBMS_OUTPUT.PUT_LINE('PRODUCTOS CON DESCUENTO'); 
  DBMS_OUTPUT.PUT_LINE(RPAD('CODIGO',30)||RPAD('DESCRIPCION',30)||LPAD('PRECIO',10)||LPAD('DESCUENTO',30)||LPAD( 'PRECIO_VENTA_FINAL',30));
  
  
  OPEN cursor_productos;

  LOOP FETCH  cursor_productos INTO  registro_unidad;
  
  EXIT WHEN cursor_productos%NOTFOUND;
  
   UPDATE producto SET descuento = k_descuento 
   WHERE producto.codprod = registro_unidad.v_codigo;  
  
   v_nuevo_precio :=0;
  
   v_nuevo_precio := registro_unidad.v_precio - (registro_unidad.v_precio*k_descuento);
  
   DBMS_OUTPUT.PUT_LINE(RPAD(registro_unidad.v_codigo,30)||RPAD(registro_unidad.v_nombre,30)||LPAD(TO_CHAR(registro_unidad.v_precio),10)||LPAD(TO_CHAR(k_descuento,'0.00'),30)||LPAD( TO_CHAR(v_nuevo_precio),30)); 
    
  END LOOP;
 
   
  CLOSE cursor_productos;
  COMMIT;
  
  EXCEPTION 
  WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('OCURRIO UN ERROR EN EL PROCESO');
   DBMS_OUTPUT.PUT_LINE('CODIGO DE ERROR : '|| to_char(SQLCODE));
   DBMS_OUTPUT.PUT_LINE('MENSAJE DE ERROR : '|| SQLERRM);
END;

--PRUEBA

BEGIN
	VENTASPLSQL.SP_ASIGNAR_DESCUENTO_PRODUCTO (0.2, '12/12/2018', '06/01/2019');
END;

SELECT * FROM PRODUCTO;
