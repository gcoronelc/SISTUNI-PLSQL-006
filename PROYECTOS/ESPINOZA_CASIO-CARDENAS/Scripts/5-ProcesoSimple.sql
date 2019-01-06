--=============================================================================
--programar un proceso simple
--=============================================================================

--Obtener los datos de untrabajador--

CREATE OR REPLACE PROCEDURE EEC_PRSIMPLE
(p_id IN TRABAJADOR.CODIGO_TRABAJADOR%TYPE,
 p_codigo OUT TRABAJADOR.CODIGO_TRABAJADOR%TYPE,
 p_nombre OUT TRABAJADOR.NOMBRE_TRABAJADOR%TYPE,
 p_apellido OUT TRABAJADOR.APELLIDOS_TRABAJADOR%TYPE,
 p_telefono OUT TRABAJADOR.TELEFONO_TRABAJADOR%TYPE,
 p_direccion OUT  TRABAJADOR.DIRECCION%TYPE,
 p_rol OUT TRABAJADOR.ROL%TYPE
)
AS 
BEGIN
	SELECT CODIGO_TRABAJADOR, NOMBRE_TRABAJADOR, APELLIDOS_TRABAJADOR,
	       TELEFONO_TRABAJADOR, DIRECCION, ROL
	INTO p_codigo, p_nombre,p_apellido,p_telefono,p_direccion,p_rol
	FROM TRABAJADOR
	WHERE CODIGO_TRABAJADOR = p_id;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		raise_application_error(-20001,'trabajador no esta registrado');
END;



--Obtener los datos de un producto--

CREATE OR REPLACE PROCEDURE EEC_PRSIMPLE_PRODUCTO_3
(p_id IN PRODUCTO.CODIGO_PRODUCTO%TYPE,
 p_cod OUT PRODUCTO.CODIGO_PRODUCTO%TYPE,
 p_nombre OUT PRODUCTO.NOMBRE_PRODUCTO%TYPE,
 p_descripcion OUT PRODUCTO.DESCRIPCION_PRODUCTO%TYPE,
 p_precio OUT PRODUCTO.PRECIO_PRODUCTO%TYPE,
 p_stock OUT PRODUCTO.STOCK_PRODUCTO%type
)
AS 
BEGIN
	SELECT CODIGO_PRODUCTO, NOMBRE_PRODUCTO, DESCRIPCION_PRODUCTO,
	       PRECIO_PRODUCTO, STOCK_PRODUCTO
	INTO p_cod, p_nombre, p_descripcion, p_precio, p_stock
	FROM PRODUCTO
	WHERE CODIGO_PRODUCTO = p_id;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		raise_application_error(-20001,'producto no esta registrado');
END;



--Modificar el precio de un producto--

CREATE OR REPLACE PROCEDURE EEC_PRSIMPLE_PRODUCTO_4
(p_id_producto IN PRODUCTO.CODIGO_PRODUCTO%TYPE,
 p_cod_admin IN  TRABAJADOR.CODIGO_TRABAJADOR%TYPE,
 p_precio_nuevo IN  PRODUCTO.PRECIO_PRODUCTO%TYPE
)
AS
	v_rol TRABAJADOR.ROL%TYPE;
BEGIN
	SELECT ROL INTO v_rol
	FROM TRABAJADOR 
	WHERE CODIGO_TRABAJADOR = p_cod_admin;
	IF (v_rol = 'Administrador') THEN
		UPDATE PRODUCTO
		SET PRECIO_PRODUCTO = p_precio_nuevo
		WHERE CODIGO_PRODUCTO = p_id_producto;
		COMMIT;
	ELSE
		raise_application_error(-20004, 'no eres administrador');
	END IF;
EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;
		DBMS_OUTPUT.PUT_LINE('codigo: ' || SQLCODE);
		DBMS_OUTPUT.PUT_LINE('mensaje: ' || SQLERRM);
		raise_application_error(SQLCODE, SQLERRM);
END;



--Consultar el stock de un producto determinado--

CREATE OR REPLACE FUNCTION EEC_FNSIMPLE_PRODUCTO_1
(p_id_producto IN PRODUCTO.CODIGO_PRODUCTO%type)
RETURN NUMBER 
IS
	v_stock PRODUCTO.STOCK_PRODUCTO%TYPE;
BEGIN
	SELECT STOCK_PRODUCTO INTO v_stock
	FROM PRODUCTO 
	WHERE CODIGO_PRODUCTO = p_id_producto;
	RETURN v_stock;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		raise_application_error(-20001,'producto no esta registrado');
END;