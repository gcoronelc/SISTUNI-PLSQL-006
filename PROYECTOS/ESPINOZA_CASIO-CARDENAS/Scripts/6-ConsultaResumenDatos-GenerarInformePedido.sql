
/*RESUMEN DE DATOS: 
			MOSTRAR LOS PRODUCTOS DE LOS PEDIDOS REGISTRADOS EN LA BASE DE DATOS QUE HA HECHO UN CLIENTE
			
*/

CREATE OR REPLACE PACKAGE GENERAR_INFORME_PEDIDOS AS
	PROCEDURE PEDIDO_DEL_CLIENTE(
		v_codigoCliente IN CLIENTE.DNI_CLIENTE%TYPE
	);
	
	PROCEDURE MOSTRAR_PRODUCTOS_CLIENTE(
		v_codigoPedido PEDIDO.CODIGO_PEDIDO%TYPE,
		v_montoTotal PEDIDO.TOTAL%TYPE,
		v_fechaEntrega PEDIDO.FECHA_ENTREGA%TYPE,
		v_nombreTrabajador TRABAJADOR.NOMBRE_TRABAJADOR%TYPE
	);
END GENERAR_INFORME_PEDIDOS;



CREATE OR REPLACE PACKAGE BODY GENERAR_INFORME_PEDIDOS AS

		PROCEDURE PEDIDO_DEL_CLIENTE(
			v_codigoCliente IN CLIENTE.DNI_CLIENTE%TYPE
		)
		IS
			CURSOR pedido_cursor IS SELECT p.CODIGO_PEDIDO,p.TOTAL,p.FECHA_ENTREGA,t.NOMBRE_TRABAJADOR 
			FROM PEDIDO p JOIN TRABAJADOR t ON p.CODIGO_TRABAJADOR = t.CODIGO_TRABAJADOR  
			WHERE DNI_CLIENTE=v_codigoCliente;
			
			v_codigoPedido PEDIDO.CODIGO_PEDIDO%TYPE;
			v_montoTotal PEDIDO.TOTAL%TYPE;
			v_fechaEntrega PEDIDO.FECHA_ENTREGA%TYPE;
			v_nombreTrabajador TRABAJADOR.NOMBRE_TRABAJADOR%TYPE;
		BEGIN
			OPEN pedido_cursor;
				IF pedido_cursor%NOTFOUND THEN
					DBMS_OUTPUT.PUT_LINE('EL CLIENTE NO TIENE PEDIDO.');
					CLOSE pedido_cursor;
					RETURN;
				END IF;
				LOOP
					FETCH pedido_cursor INTO v_codigoPedido,v_montoTotal,v_fechaEntrega,v_nombreTrabajador;
					EXIT WHEN pedido_cursor%NOTFOUND;
					MOSTRAR_PRODUCTOS_CLIENTE(v_codigoPedido,v_montoTotal,v_fechaEntrega,v_nombreTrabajador);	
				END LOOP;
			CLOSE pedido_cursor;
		END PEDIDO_DEL_CLIENTE;

		PROCEDURE MOSTRAR_PRODUCTOS_CLIENTE(
			v_codigoPedido PEDIDO.CODIGO_PEDIDO%TYPE,
			v_montoTotal PEDIDO.TOTAL%TYPE,
			v_fechaEntrega PEDIDO.FECHA_ENTREGA%TYPE,
			v_nombreTrabajador TRABAJADOR.NOMBRE_TRABAJADOR%TYPE
		)
		IS
			CURSOR product_cur IS SELECT p.NOMBRE_PRODUCTO,p.PRECIO_PRODUCTO,pp.CANTIDAD,pp.MONTO 
			FROM PRODUCTO_PEDIDO pp JOIN PRODUCTO p 
			ON p.CODIGO_PRODUCTO = pp.CODIGO_PRODUCTO WHERE pp.CODIGO_PEDIDO=v_codigoPedido;
		BEGIN
			DBMS_OUTPUT.PUT_LINE('*******************   BOLETA  **********************');
			DBMS_OUTPUT.PUT_LINE('Codigo pedido: '||v_codigoPedido);
			DBMS_OUTPUT.PUT_LINE('Nombre del trabajador: '||INITCAP(v_nombreTrabajador));
			DBMS_OUTPUT.PUT_LINE('---------------------------------------');
			FOR producto_cursor IN product_cur LOOP
				DBMS_OUTPUT.PUT_LINE('Nombre del Producto: '||INITCAP(producto_cursor.NOMBRE_PRODUCTO)||' - '||
									'Precio: '||producto_cursor.PRECIO_PRODUCTO||' soles - '||
									'Cantidad: '||producto_cursor.CANTIDAD||' unidades - '||
									'PrecioxCantidad: '||producto_cursor.MONTO||' soles.');
			END LOOP;
			DBMS_OUTPUT.PUT_LINE('---------------------------------------');
			DBMS_OUTPUT.PUT_LINE('                                 MONTO TOTAL: '||v_montoTotal||' soles'||'  -  '||
																	'Fecha de entrega: '||v_fechaEntrega);
			DBMS_OUTPUT.PUT_LINE('************************************************');
		END MOSTRAR_PRODUCTOS_CLIENTE;


END GENERAR_INFORME_PEDIDOS;

